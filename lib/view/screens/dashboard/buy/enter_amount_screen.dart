import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/view_model/dashboard/buy_view_model.dart';

class EnterAmountScreen extends ConsumerStatefulWidget {
  EnterAmountScreen({
    Key? key,
    this.cryptoName = bitcoin,
    this.cryptoAcronym = btc,
    this.ratePerCrypto = 1505,
  }) : super(key: key);
  final String cryptoName;
  final String cryptoAcronym;
  final int ratePerCrypto;
  @override
  ConsumerState<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends ConsumerState<EnterAmountScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var buySectionProvider = ref.watch(buyViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.primaryColor,
        text: enterAmount,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "$pleaseEnterTheAmountOf ",
                      style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.primary,
                        fontFamily: soraFont,
                      ),
                      children: [
                        TextSpan(
                          text: "${widget.cryptoName} (${widget.cryptoAcronym}) ",
                          style: TextStyle(
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                            fontFamily: soraFont,
                          ),
                        ),
                        TextSpan(
                          text: youWantToBuy,
                          style: TextStyle(
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.primary,
                            fontFamily: soraFont,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(20.h),
                  TextFieldsForAmount(buySectionProvider: buySectionProvider),
                  Gap(5.h),
                  TextView(
                    text: "Rate = ${widget.ratePerCrypto}/$dollarSign",
                    fontSize: 14.spMin,
                    fontWeight: FontWeight.w400,
                    fontFamily: soraFont,
                  )
                ],
              ),
              DefaultButtonMain(
                color: AppColors.kPrimary1,
                buttonState: buySectionProvider.enterAmountButtonState.buttonState,
                text: buySectionProvider.enterAmountButtonState.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldsForAmount extends StatelessWidget {
  const TextFieldsForAmount({
    super.key,
    required this.buySectionProvider,
  });

  final BuyViewModel buySectionProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          fieldLabel: iWillPay,
          hint: dummyAmount,
          keyboardType: TextInputType.number,
          focusNode: buySectionProvider.paymentNode,
          controller: buySectionProvider.paymentController,
          onChanged: (value) => buySectionProvider.updateEnterAmountButtonState(),
          showSuffixText: true,
          suffixText: ngn,
        ),
        Gap(5.h),
        Container(
          height: 36.h,
          width: 36.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kMidnightBlue,
          ),
          child: Center(
            child: Image.asset(
              AppImages.refreshLogo,
              width: 13.w,
              height: 15.h,
            ),
          ),
        ),
        Gap(5.h),
        CustomTextField(
          fieldLabel: iWillReceive,
          keyboardType: TextInputType.number,
          hint: dummyAmount,
          focusNode: buySectionProvider.receipientNode,
          controller: buySectionProvider.receipientController,
          onChanged: (value) => buySectionProvider.updateEnterAmountButtonState(),
          showSuffixText: true,
          suffixText: btc,
        ),
      ],
    );
  }
}
