// import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tampay/model/response/user_banks_response.dart';

// import 'package:tampay/model/response/local_response/user_banks_response.dart';

import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';

import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';

class AddBankDetailsScreen extends ConsumerStatefulWidget {
  const AddBankDetailsScreen({super.key});

  @override
  ConsumerState<AddBankDetailsScreen> createState() =>
      _AddBankDetailsScreenState();
}

class _AddBankDetailsScreenState extends ConsumerState<AddBankDetailsScreen> {
  // @override
  // void didChangeDependencies() {
  //   ref.watch(profileViewModel).fetchAllNigerianBanks();
  //   super.didChangeDependencies();
  // }

  @override
  void didChangeDependencies() {
    ref.watch(profileViewModel).initPage().then((value) {
      // ref.watch(profileViewModel).fetchAllNigerianBanks();
      ref.watch(profileViewModel).updateSaveBankButtonState();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var userProfileProvider = ref.watch(profileViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
          text: addBank,
          isVisible: false
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 20.w,
        ),
        child: SizedBox(
          width: 360.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // height: 329.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: 'Please ensure that your bank account name matches your BVN name',
                      fontSize: 14.spMin,
                      fontFamily: soraFont,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                    Gap(20.h),
                    const TextView(text: "Bank name"),
                    const Gap(10),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.kTransparent,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.kPrimary1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text(
                            bankNameText,
                            style: TextStyle(
                              color: AppColors.kWhite,
                            ),
                          ),
                          value: userProfileProvider.bankName,
                          icon: Icon( Icons.keyboard_arrow_down_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          iconSize: 24,
                          // elevation: 16,
                          style: TextStyle(color: theme.colorScheme.primary),
                          onChanged: (newBankName) {
                            userProfileProvider.newBankName(newBankName!);
                            userProfileProvider.getBankCode(newBankName);
                            if (userProfileProvider.bankCode!.isNotEmpty &&
                                userProfileProvider
                                    .accountNumberController.text.isNotEmpty) {
                              userProfileProvider.validateUserBankAccount();
                            }
                          },
                          items: userProfileProvider.bankList
                              .map<DropdownMenuItem<String>>((BanksData value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: TextView(
                                text: value.name!,
                                color: theme.colorScheme.primary,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Gap(20.h),
                    CustomTextField(
                      controller: userProfileProvider.accountNumberController,
                      textColor: themeMode == ThemeMode.light
                          ? AppColors.kBlack4
                          : AppColors.kTextGray,
                      fieldLabel: 'Account Number',
                      // maxlength: 10,
                      hint: accountNumberText,
                      keyboardType: TextInputType.number,
                      onChanged: (accountNumber) {
                        userProfileProvider.updateSaveBankButtonState();
                        userProfileProvider
                            .changeShowBanks(accountNumber!.length == 10);
                        if (userProfileProvider
                                    .accountNumberController.text.length ==
                                10 &&
                            userProfileProvider.bankCode!.isNotEmpty) {
                          userProfileProvider.validateUserBankAccount();
                        }
                      },
                    ),


                    userProfileProvider.isLoadingVerifiedBanks
                        ? Column(
                          children: [
                            Gap(10.h),
                            Container(
                                // color: Colors.red,
                                // height: 50.h,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballGridPulse,
                                    colors: const [
                                      AppColors.kPrimary2,
                                    ],
                                    strokeWidth: 2,
                                    backgroundColor: theme.scaffoldBackgroundColor,
                                    pathBackgroundColor: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                          ],
                        )
                        :     TextView(text: "Daniel Mason Ovie", color: AppColors.kDisabledButton, fontSize: 13.spMin,),
                  ],
                ),
              ),
              Column(
                children: [
                  DefaultButtonMain(
                    textColor: AppColors.kWhite,
                    color: AppColors.kPrimary1,
                    text: saveInfo,
                    buttonState:
                    userProfileProvider.buttonSaveBankDetailsState.buttonState,
                    onPressed: () {
                      userProfileProvider.addUserAccountNumber(
                        context,
                      );
                    },
                  ),
                  Gap(15.h),
                  DefaultButtonMain(
                    textColor: AppColors.kPrimary1,
                    color: AppColors.kTransparent,
                    text: "Skip",
                    onPressed: () {
                      navigateBack(context);
                      navigateBack(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
