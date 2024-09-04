import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_colors.dart';

class DirectionRow extends StatelessWidget {
  const DirectionRow({super.key, required this.title, required this.icon, this.reversed = false});

  final String title;
  final String icon;
  final bool reversed;


  @override
  Widget build(BuildContext context) {

    if(reversed){
      return Row(
        children: [

          Flexible(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20, child: Image.asset(icon)),
                const SizedBox(width: 5,),
                Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),
          Flexible(flex: 1,child: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.mainBlue,size: 15,)),
          Flexible(
            flex: 7,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_wallet.svg'),
                const SizedBox(width: 5,),
                const Flexible(child: Text('Основной счет', style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),
        ],
      );
    }else{
      return Row(
        children: [
          Flexible(
            flex: 7,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_wallet.svg'),
                const SizedBox(width: 5,),
                const Flexible(child: Text('Основной счет', style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),
          Flexible(flex: 1,child: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.mainBlue,size: 15,)),
          Flexible(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20, child: Image.asset(icon)),
                const SizedBox(width: 5,),
                Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),
        ],
      );
    }


  }
}
