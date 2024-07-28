// import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
// import 'package:tampay/model/response/local_response/user_banks_response.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
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
        trailing: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap: () {},
            child: TextView(
              text: skip,
              fontWeight: FontWeight.w600,
              fontSize: 14.spMin,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: SizedBox(
          width: 360.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    TextView(
                    text: addBank,
                    textStyle: theme.textTheme.titleLarge,
                  ),
                  Gap(10.h),
                  TextView(
                    text: pleaseEnsureThatDetailsMatch,
                    fontSize: 14.spMin,
                    fontFamily: soraFont,
                    maxLines: 3,
                 
                  ),
                  Gap(20.h),
                  const TextView(text: bankName),
                  const Gap(10),
                  Container(
                   
                    decoration: BoxDecoration(
                      color: AppColors.kOnyxBlack,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                      border: Border.all(
                        width: 1.w,
                        color: userProfileProvider.bankName != null
                            ? AppColors.kCoolGray
                            : AppColors.kTransparent,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                     
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text(
                          bankNameText,
                          style: TextStyle(
                            color: AppColors.kGraphiteGray,
                          ),
                        ),
                        value: userProfileProvider.bankName,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.colorScheme.primary,
                        ),
                        iconSize: 24,
                        // elevation: 16,
                        style: TextStyle(color: theme.colorScheme.primary),
                        onChanged: (newBankName) {
                          userProfileProvider.newBankName(newBankName!);
                          userProfileProvider.getBankCode(newBankName);
                          if (userProfileProvider.bankCode!.isNotEmpty &&
                              userProfileProvider.accountNumberController.text.isNotEmpty) {
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
                
                    fieldLabel: accountNumber,
                    maxlength: 10,
                    hint: enterTenDigitsAccNumberText,
                    keyboardType: TextInputType.number,
                    onChanged: (accountNumber) {
                      userProfileProvider.updateSaveBankButtonState();
                      userProfileProvider.changeShowBanks(accountNumber!.length == 10);
                      if (userProfileProvider.accountNumberController.text.length == 10 &&
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
                      : TextView(
                          text: dummyName,
                          color: AppColors.kGrey500,
                          fontSize: 14.spMin,
                        ),
                ],
              ),
              DefaultButtonMain(
                color: AppColors.kPrimary1,
                text: add,
                buttonState: userProfileProvider.buttonSaveBankDetailsState.buttonState,
                onPressed: () {
                  userProfileProvider.addUserAccountNumber(
                    context,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
