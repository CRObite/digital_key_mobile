import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/custom_drop_down.dart';

class DropDownMetrics extends StatefulWidget {
  const DropDownMetrics({super.key,required this.selected, required this.color, required this.onPressed, this.needBorder = false, required this.metricsValues, required this.onMetricSelected});

  final bool selected;
  final Color color;
  final bool needBorder;
  final Map<String,dynamic> metricsValues;
  final VoidCallback onPressed;
  final Function(String) onMetricSelected;

  @override
  State<DropDownMetrics> createState() => _DropDownMetricsState();
}

class _DropDownMetricsState extends State<DropDownMetrics> {

  bool isSelected = false;
  String selectedMetric = 'impressions';
  dynamic value;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    isSelected = widget.selected;
    value = widget.metricsValues['impressions'];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isSelected = !isSelected;
        });

        widget.onPressed();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: isSelected ? widget.color : widget.needBorder ? widget.color : AppColors.borderGrey,width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: isSelected ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(width: 40,),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Клики',
                        style: TextStyle(color: AppColors.mainGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.mainGrey,
                      ),
                    ],
                  ),
                  Text(
                    '54 558',
                    style: TextStyle(
                        fontSize: 20,
                        color: !widget.needBorder ? Colors.black: AppColors.secondaryBlueDarker),
                  )
                ],
              ),

              CustomPaint(
                painter: TrianglePainter( isSelected ? widget.color : AppColors.borderGrey),
                child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.check_rounded, color: Colors.white,size: 17,),
                        )
                    )

                ),
              ),
            ],
          ): Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(

                child: DropdownButtonHideUnderline(

                  child: DropdownButton2<dynamic>(
                    dropdownSearchData: DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          style: const TextStyle(fontSize: 12),
                          controller: textEditingController,
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().contains(searchValue);
                      },
                    ),

                    items: widget.metricsValues.keys
                        .map((dynamic item) => DropdownMenuItem<dynamic>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedMetric,
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedMetric = value;
                      });

                      widget.onMetricSelected(value as String);
                    },
                    iconStyleData:  IconStyleData(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      iconSize: 25,
                      iconDisabledColor: AppColors.mainGrey,
                      iconEnabledColor: AppColors.mainGrey,
                    ),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      elevation: 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      maxHeight: 200,
                      offset: const Offset(0, -10),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 50,
                    ),
                  ),
                ),
              ),
              Text(
                '${(value as double).round()}',
                style: TextStyle(
                    fontSize: 20,
                    color: !widget.needBorder ? Colors.black: AppColors.secondaryBlueDarker),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TrianglePainter extends CustomPainter {

  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}