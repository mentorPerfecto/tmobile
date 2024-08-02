import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_id/smile_id_smart_selfie_enrollment.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column (
            children: [
              const TextView(
                text: 'You will need to start the video recording and place your face on the center of the circle to confirm',
                color: AppColors.kGrey400,
              ),
              SizedBox(height:  600.h,
                child: SmileIDSmartSelfieEnrollment(
                  onSuccess: (String? result) {
                    // Your success handling logic
                    Map<String, dynamic> jsonResult = json.decode(result ?? '{}');
                    String formattedResult = jsonEncode(jsonResult);
                    final snackBar = SnackBar(content: Text("Success: $formattedResult"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pop();
                  },
                  onError: (String errorMessage) {
                    // Your error handling logic
                    final snackBar = SnackBar(content: Text("Error: $errorMessage"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
