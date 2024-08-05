import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tampay/src/config.dart';

import '../src/components.dart';

void showToast({
   // String? title,
  required String msg,
  required bool isError,
  bool isNeutralMessage = false,
}) {

  // BotToast.showSimpleNotification(
  //   title: msg,
  //   borderRadius: 10.0,
  //   duration: const Duration(seconds: 3),
  //   titleStyle: const TextStyle(color: AppColors.kMidnightBlue),
  //   align: Alignment.topRight,
  //   crossPage: false,
  //   animationDuration: const Duration(milliseconds: 200),
  //   wrapToastAnimation: (controller, cancel, child) =>
  //       CustomOffsetAnimation(
  //           reverse: true,
  //           controller: controller,
  //           child: child),
  //   backgroundColor: isNeutralMessage
  //       ? Colors.grey
  //       : isError
  //           ? Colors.red
  //           : AppColors.kLightSilver,
  // );

  BotToast.showAttachedWidget(
    target: const Offset(-16, -16),
    verticalOffset: 10.0,
    horizontalOffset: 4.0,
    duration: const Duration(seconds: 6),
    animationDuration: const Duration(milliseconds: 200),
    // animationReverseDuration:
    // const Duration(milliseconds: 200),
    //   wrapToastAnimation: (controller, cancel, child) =>
    //       CustomOffsetAnimation(
    //           reverse: true,
    //           controller: controller,
    //           child: child),
    preferDirection: PreferDirection.topRight,
    onlyOne: false,
    attachedBuilder: (cancel) {
      return AlertBody(cancel: cancel, msg: msg, isError: isError);
    },
  );
}


class AlertBody extends StatefulWidget  {
  final VoidCallback cancel;
  final String msg;
  final bool isError;

  const AlertBody({super.key, required this.cancel, required this.msg, required this.isError});
  @override
  State<AlertBody> createState() => _AlertBodyState();
}

class _AlertBodyState extends State<AlertBody> with SingleTickerProviderStateMixin  {

  double _start =5.0;

  AnimationController? _animationController;
  Animation<double>? _animation;


  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {


    init();

    super.didChangeDependencies();
  }

  init(){
    _animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 5.0, end: 0.0).animate(_animationController!)
      ..addListener(() {
        initAnt();
      });

    _animationController!.forward();
  }


  Future <void >initAnt() async{
   setState(() {
     _start = _animation!.value;
   });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.kMidnight50,
          border: Border.all(color: AppColors.kMidnight200, width: 3),
          borderRadius: BorderRadius.circular(15.r)),
        height: 70.h,
        width: 360.w,
        child: Stack(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all( 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container( width: 25.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimary1,
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: widget.cancel,
                          //  splashRadius: 5,
                          icon: Icon(
                            Icons.check, size: 15.spMin,
                            color: AppColors.kWhite,
                          ),
                        ),
                      ),
                      const Gap(7),
                      SizedBox(
                        // width: 250,
                        child: Row(
                          children: [
                            TextView(text: widget.msg, color: AppColors.kMidnight950,
                              fontSize: 14.spMin, maxLines: 3,
                              fontWeight: FontWeight.w600,),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: widget.cancel,
                      splashRadius: 5,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.kBlack8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // LinearProgressIndicator(value: _start.toDouble(),  color: AppColors.kPrimary1,
            //   backgroundColor: AppColors.kWhite, ,)
            // Positioned( bottom: 0, left: 10,
            //   child: ClipRRect(
            //     borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(20.r),
            //       bottomRight: Radius.circular(20.r),  topRight: Radius.circular(20.r)),
            //     child: LinearPercentIndicator(
            //       barRadius: Radius.circular(20.r),
            //       width: 350.w,padding: const EdgeInsets.only(bottom: 0),
            //       lineHeight: 5.0,
            //       percent: (_start/5),
            //       backgroundColor: AppColors.kMidnight50,
            //       progressColor: AppColors.kPrimary1,
            //     ),
            //   ),
            // ), // Positioned( bottom: 0, left: 10,
            //   child: ClipRRect(
            //     borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(20.r),
            //       bottomRight: Radius.circular(20.r),  topRight: Radius.circular(20.r)),
            //     child: LinearPercentIndicator(
            //       barRadius: Radius.circular(20.r),
            //       width: 350.w,padding: const EdgeInsets.only(bottom: 0),
            //       lineHeight: 5.0,
            //       percent: (_start/5),
            //       backgroundColor: AppColors.kMidnight50,
            //       progressColor: AppColors.kPrimary1,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
