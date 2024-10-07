import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:web_com/data/repository/bank_repository.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../config/app_colors.dart';
import '../domain/bank.dart';

class LazyDropDown extends StatefulWidget {
  const LazyDropDown({super.key, required this.navigationPageCubit, required this.selected, this.currentValue});

  final NavigationPageCubit navigationPageCubit;
  final Function(Bank) selected;
  final Bank? currentValue;


  @override
  State<LazyDropDown> createState() => _LazyDropDownState();
}

class _LazyDropDownState extends State<LazyDropDown> {

  bool isDropdownOpen = false;
  Bank? selectedValue;
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

  void selectItem(Bank value) {
    setState(() {
      selectedValue = value;
      isDropdownOpen = false;
    });

    widget.selected(selectedValue!);

    _overlayEntry?.remove();
  }

  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: DropDownMenu(navigationPageCubit: widget.navigationPageCubit, selectItem: (value) {
              selectItem(value);
            },)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
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
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderGrey,
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(selectedValue?.name ?? 'Выберите банк', maxLines: 1,overflow: TextOverflow.ellipsis,),),
              Icon(
                isDropdownOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key, required this.navigationPageCubit, required this.selectItem});

  final NavigationPageCubit navigationPageCubit;
  final Function(Bank) selectItem;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  late ScrollController scrollController;
  TextEditingController searchController = TextEditingController();
  List<Bank> filteredBanks = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // Load initial bank data
    getBankData();

    // Add scroll listener for lazy loading
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (page < maxPage) {
          getBankData();
        }
      }
    });

    // Add listener for search text input
    searchController.addListener(_filterBanks);
  }

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<Bank> listOfBanks = [];

  Future<void> getBankData({String query = ''}) async {
    try {
      Pageable? pageable = await BankRepository().getBanks(context, page, size, query);

      if (pageable != null) {
        maxPage = pageable.totalPages;

        for (var item in pageable.content) {
          listOfBanks.add(Bank.fromJson(item));
        }

        // Filter banks after loading new data
        _filterBanks();
        page++;
      }
    } catch (e) {
      if (e is DioException) {
        CustomException customException = CustomException.fromDioException(e);
        widget.navigationPageCubit.showMessage(customException.message, false);
      }
    } finally {
      setState(() {});
    }
  }

  // Function to filter the list based on search query
  void _filterBanks() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredBanks = listOfBanks
          .where((bank) => bank.name?.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

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
      height: 300, // Increased height to fit the TextField
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search TextField at the top
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value){
                  page = 0;
                  getBankData(query: value);
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
            // Scrollable list of banks
            listOfBanks.isNotEmpty ? Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredBanks.map((item) {
                    return GestureDetector(
                      onTap: () {
                        widget.selectItem(item);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(item.name ?? ''),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ): const Text('Данных нет'),
          ],
        ),
      ),
    );
  }
}
