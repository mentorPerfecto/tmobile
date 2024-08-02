import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_id/smile_id_smart_selfie_enrollment.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class FacialVerificationScreen extends StatefulWidget {
  const FacialVerificationScreen({super.key});



  @override
  State<FacialVerificationScreen> createState() => _FacialVerificationScreenState();
}

class _FacialVerificationScreenState extends State<FacialVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
          context,
          bottomVisible: true,
          bottomText: "Facial Verification"

      ),
      body: SingleChildScrollView(
        child: Column (
          children: [
            Padding(
              padding: EdgeInsets.all(15.r),
              child: const TextView(
                text: 'You will need to start the video recording and place your face on the center of the circle to confirm',
                maxLines: 3,
                color: AppColors.kGrey400,
              ),
            ),
           // Gap(5),
            SizedBox(height:  640.h,
              child: SmileIDSmartSelfieEnrollment(
                onSuccess: (String? result) {
                  // Your success handling logic
                  Map<String, dynamic> jsonResult = json.decode(result ?? '{}');
                  String formattedResult = jsonEncode(jsonResult);
                  showToast(msg: "Success: $formattedResult", isError: false);
                  navigateReplace(context, const AccountVerifiedConfirmationScreen());
                },
                onError: (String errorMessage) {
                  // Your error handling logic
                  showToast(msg: "Could not complete Facial Verification", isError: false);
                  navigateReplace(context, const AccountVerifiedConfirmationScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
