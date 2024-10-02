import 'package:flutter/material.dart';
import 'package:web_com/config/app_colors.dart';

class DropDownMetrics extends StatelessWidget {
  const DropDownMetrics({super.key,required this.selected, required this.color, required this.onPressed, this.needBorder = false});

  final bool selected;
  final Color color;
  final bool needBorder;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: selected ? color : needBorder ? color : AppColors.borderGrey,width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: selected ? Row(
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
                        color: !needBorder ? Colors.black: AppColors.secondaryBlueDarker),
                  )
                ],
              ),

              CustomPaint(
                painter: TrianglePainter( selected ? color : AppColors.borderGrey),
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
                    color: !needBorder ? Colors.black: AppColors.secondaryBlueDarker),
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