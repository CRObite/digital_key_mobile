import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../config/app_colors.dart';

class LazyDropDown<T> extends StatefulWidget {
  const LazyDropDown({
    super.key,
    required this.navigationPageCubit,
    required this.selected,
    this.currentValue,
    required this.title,
    required this.important,
    required this.getData,
    required this.fromJson,
    required this.fieldName,
    required this.toJson,
    this.noBorder = false,
  });

  final NavigationPageCubit navigationPageCubit;
  final Function(T) selected;
  final T? currentValue;
  final String title;
  final bool important;
  final Future<Pageable?> Function(int page, int size, String query) getData;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final String fieldName;
  final bool noBorder;

  @override
  State<LazyDropDown<T>> createState() => _LazyDropDownState<T>();
}

class _LazyDropDownState<T> extends State<LazyDropDown<T>> {
  bool isDropdownOpen = false;
  T? selectedValue;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    selectedValue = widget.currentValue;
    super.initState();
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });

  }

  void selectItem(T value) {
    setState(() {
      selectedValue = value;
      isDropdownOpen = false;
    });

    widget.selected(selectedValue!);

    _overlayEntry?.remove();
  }


  String _getFieldValue(T item) {
    final value = widget.toJson(item)[widget.fieldName];
    return value?.toString() ?? '';
  }

  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Add a GestureDetector to capture taps outside the dropdown
          GestureDetector(
            onTap: () {
              // Close the dropdown when tapped outside
              if (isDropdownOpen) {
                _overlayEntry?.remove();
                setState(() {
                  isDropdownOpen = false;
                });
              }
            },
            child: Container(
              color: Colors.transparent, // Modal barrier to capture outside taps
            ),
          ),
          // Positioned dropdown menu
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 5.0),
              child: Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: DropDownMenu<T>(
                  navigationPageCubit: widget.navigationPageCubit,
                  selectItem: (value) {
                    selectItem(value);
                  },
                  getData: widget.getData,
                  fromJson: widget.fromJson,
                  fieldName: widget.fieldName,
                  toJson: widget.toJson,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LazyDropDown<T> oldWidget) {

    if(widget.currentValue == null){
      setState(() {
        selectedValue = null;
      });
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(!widget.noBorder)
        RichText(
          text: TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black),
            children: widget.important
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]
                : [],
          ),
        ),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: () {
              if (isDropdownOpen) {
                _overlayEntry?.remove();
              } else {
                _overlayEntry = _createOverlayEntry();
                Overlay.of(context).insert(_overlayEntry!);
              }
              toggleDropdown();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.only(top: 5),
              decoration: widget.noBorder ? AppBoxDecoration.boxWithShadow : BoxDecoration(
                border: Border.all(
                  color: AppColors.borderGrey,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      selectedValue!= null ?  _getFieldValue(selectedValue!) : widget.noBorder ? widget.title : 'Выберите элемент',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: selectedValue == null? Colors.grey: null,fontSize: 12),
                    ),
                  ),


                  Icon(
                    isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.mainGrey,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownMenu<T> extends StatefulWidget {
  const DropDownMenu({
    super.key,
    required this.navigationPageCubit,
    required this.selectItem,
    required this.getData,
    required this.fromJson,
    required this.fieldName,
    required this.toJson,
  });

  final NavigationPageCubit navigationPageCubit;
  final Function(T) selectItem;
  final Future<Pageable?> Function(int page, int size, String query) getData;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final String fieldName;

  @override
  State<DropDownMenu<T>> createState() => _DropDownMenuState<T>();
}

class _DropDownMenuState<T> extends State<DropDownMenu<T>> {
  late ScrollController scrollController;
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // Load initial data
    getData();

    // Add scroll listener for lazy loading
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < maxPage) {
          getData(needLoading: false);
        }
      }
    });

    // Add listener for search text input
    // searchController.addListener(_filterItems);
  }

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<T> listOfItems = [];
  bool isLoading = false;

  Future<void> getData({String query = '', bool needLoading = true}) async {

    if(needLoading){
      setState(() {
        isLoading = true;
      });
    }


    try {
      Pageable? pageable = await widget.getData(page, size, query);

      if(pageable!= null){
        maxPage = pageable.totalPages;

        setState(() {
          for(var item in pageable.content){
            listOfItems.add(widget.fromJson(item));
          }
          page++;
        });

        // _filterItems();
      }

      setState(() {
        isLoading = false;
      });

        } catch (e) {
      if (e is DioException) {
        CustomException customException =
        CustomException.fromDioException(e);
        widget.navigationPageCubit
            .showMessage(customException.message, false);

        setState(() {
          isLoading = false;
        });
      }else{
        rethrow;
      }
    }
  }


  String _getFieldValue(T item) {
    final value = widget.toJson(item)[widget.fieldName];
    return value?.toString() ?? '';
  }

  // void _filterItems() {
  //   String query = searchController.text.toLowerCase();
  //   setState(() {
  //     filteredItems = listOfItems.where((item) {
  //       String fieldValue = _getFieldValue(item); // Get field value
  //       return fieldValue.toLowerCase().contains(query);
  //     }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderGrey,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: 300,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            if(isLoading)
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: CircularProgressIndicator(color: AppColors.secondaryBlueDarker,),
              ),

            if(!isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  page = 0;
                  listOfItems.clear();
                  getData(query: value,needLoading: false);
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Поиск по имени',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(fontSize: 12),
              ),
            ),

            if(!isLoading)
            listOfItems.isNotEmpty
                ? Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: listOfItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        widget.selectItem(item);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(_getFieldValue(item)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
                : const Text('Данных нет'),
          ],
        ),
      ),
    );
  }
}
