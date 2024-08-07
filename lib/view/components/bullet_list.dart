import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class BulletList extends StatelessWidget {

  final List<dynamic>? list;
  final bool isCompleted;

  const BulletList({super.key, this.list, required this.isCompleted});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list!.map<Widget>((listDetails) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              height: 25.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isCompleted ? const Icon(Icons.check_circle_outline,  color: AppColors.kGreenLoader,)
                  : const Icon(Icons.remove_circle_outline, color: AppColors.kGrey600,),
                  Gap(5.w),
                  Expanded(
                    child: TextView(
                      text: listDetails,
                      softRap: true, color: AppColors.kGrey600,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
