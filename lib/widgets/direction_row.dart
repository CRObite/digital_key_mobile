import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/service_operation_type_enum.dart';

import '../config/app_colors.dart';
import '../domain/service_operation.dart';

class DirectionRow extends StatelessWidget {
  const DirectionRow({super.key, required this.operation});

  final ServiceOperation operation;


  @override
  Widget build(BuildContext context) {

    return Row(
      children: [


        if(operation.type == ServiceOperationType.FUND)
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
        if(operation.type == ServiceOperationType.REFUND || operation.type == ServiceOperationType.TRANSFER)
          Flexible(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                operation.fromService?.service.logo?.url != null ?
                  SizedBox(height: 20, child:  Image.network(operation.fromService!.service.logo!.url!)):
                  const SizedBox(),
                const SizedBox(width: 5,),
                Flexible(child: Text(operation.fromService?.service.name ?? '-', style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),

        Flexible(flex: 1,child: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.mainBlue,size: 15,)),

        if(operation.type == ServiceOperationType.REFUND)
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

        if(operation.type == ServiceOperationType.FUND || operation.type == ServiceOperationType.TRANSFER)
          Flexible(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                operation.toService?.service.logo?.url != null ?
                SizedBox(height: 20, child:  Image.network(operation.toService!.service.logo!.url!)):
                const SizedBox(),
                const SizedBox(width: 5,),
                Flexible(child: Text(operation.toService?.service.name ?? '-', style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),

      ],
    );


  }
}
