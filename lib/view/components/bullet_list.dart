import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class BulletList extends StatelessWidget {
  const BulletList({Key? key, required this.list}) : super(key: key);
  final List<dynamic>? list;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list!.map<Widget>((listDetails) {
          return SizedBox(
            height: 25.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "\u25AB",
                  fontSize: 14.spMin,
                  height: 1.5,
                ),
                Gap(5.w),
                Expanded(
                  child: TextView(
                    text: listDetails,
                    softRap: true,
                    fontSize: 14.spMin,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
