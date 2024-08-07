import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';

class FillBankDetailsScreen extends ConsumerStatefulWidget {
  const FillBankDetailsScreen({super.key});

  @override
  ConsumerState<FillBankDetailsScreen> createState() =>
      _FillBankDetailsScreenState();
}

class _FillBankDetailsScreenState extends ConsumerState<FillBankDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBars.mainAppBar(
        context,
     
        text: addNewBankText,
        textSize: 20.spMin,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: TextView(
                      text: pleaseEnsureThatDetailsMatch,
                      fontSize: 12.spMin,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  CustomTextField(
                    fieldLabel: bankNameText,
                    hint: selectBankText,
                    readOnly: true,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const CustomTextField(
                    // fieldLabel: accountNumberText,
                    fieldLabel: '',
                    hint: enterTenDigitsAccNumberText,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const TextView(
                    text: 'Daniel Mason Ovie',
                    color: AppColors.kCardText,
                  )
                ],
              ),
              Column(
                children: [
                  DefaultButtonMain(
                    text: saveBankText,
                    color: AppColors.kPrimary1,
                    // buttonState: provider.buttonLoginState!.buttonState,
                    onPressed: () {
                      bankAddedSuccessfulBottomModalSheetWidget(context);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
