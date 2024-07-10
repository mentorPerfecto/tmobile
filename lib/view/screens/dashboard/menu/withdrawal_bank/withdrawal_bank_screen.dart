import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/providers.dart';


class WithdrawalBankScreen extends ConsumerStatefulWidget {
  const WithdrawalBankScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<WithdrawalBankScreen> createState() =>
      _WithdrawalBankScreenState();
}

class _WithdrawalBankScreenState extends ConsumerState<WithdrawalBankScreen> {
  @override
  void didChangeDependencies() {
    ref.watch(profileViewModel).fetchLandlordsBanks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return profileProvider.isDeletingBankAccountDetails
        ? const SuccessLoadingScreen(
            informationText: deletionInProgress,
            detailText: processingDeleteBank,
          )
        : Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBars.mainAppBar(
              context,
              text: accountDetailsText,
              backgroundColor: theme.scaffoldBackgroundColor,
              arrowBackColor: theme.colorScheme.primary,
            ),
            body: XResponsiveWrap.mobile(
              onRefresh: () {
                return profileProvider.fetchLandlordsBanks();
              },
              loadFailed: profileProvider.landLordWithdrawalBanks == [],
              children: [
                Gap(10.h),
                profileProvider.isFetchingLandlordBanks
                    ? Container(
                        height: 450.h,
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
                      )
                    : profileProvider.landLordWithdrawalBanks.isEmpty
                        ? EmptyListStateWidget(
                            stateDesc: "No Bank Account Detail Added",
                            height: 450.h,
                          )
                        : SizedBox(
                            height: double.parse((90.h *
                                    profileProvider
                                        .landLordWithdrawalBanks.length)
                                .toString()),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var accountItem = profileProvider
                                    .landLordWithdrawalBanks[index];
                                return InkWell(
                                  onTap: () {
                                    // listingProvider.deleteListing(context, id: widget.id);
                                    displayDeleteConfirmationMessageAlert(
                                        theme: theme,
                                        themeMode: themeMode,
                                        message:
                                            'Are you sure you want to remove your bank details? '
                                            'Doing that will remove this particular property details. This action can not be undone.',
                                        isDismissible: true,
                                        context,
                                        'Delete Bank Detail', onTap: () {
                                      navigateBack(context);

                                      profileProvider
                                          .deleteBankAccountDetails(context);
                                    });
                                  },
                                  child: MyWithdrawalBankCard(
                                    bankName: accountItem.bankName ?? "",
                                    accountName: accountItem.accountName ?? "",
                                    accountNumber:
                                        accountItem.accountNumber ?? "",
                                    verificationStatus:
                                        accountItem.isApproved == true
                                            ? 'Verified'
                                            : 'Unverified',
                                    verificationTextStatus:
                                        accountItem.isApproved == true
                                            ? AppColors.kGreen
                                            : AppColors.kDeepOrange,
                                    verifyContainerStatus:
                                        themeMode == ThemeMode.light
                                            ? AppColors.kGreenLight
                                            : AppColors.kGreenTrans,
                                  ),
                                );
                              },
                              itemCount: profileProvider
                                  .landLordWithdrawalBanks.length,
                            ),
                          ),
                Gap(10.h),
              ],
            ),
            floatingActionButton:
                profileProvider.landLordWithdrawalBanks.isEmpty
                    ? FloatingActionButton(
                        backgroundColor: AppColors.kPrimary2,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        onPressed: () {
                          navigatePush(context, const AddBankDetailsScreen());
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
          );
  }
}

class MyBankDetails {
  final String? bankName;
  final String? accountName;
  final String? accountNumber;

  MyBankDetails(
      {required this.accountName,
      required this.accountNumber,
      required this.bankName});
}

class MyWithdrawalBankCard extends ConsumerWidget {
  const MyWithdrawalBankCard({
    super.key,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.verificationStatus,
    required this.verificationTextStatus,
    required this.verifyContainerStatus,
  });
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String verificationStatus;
  final Color verifyContainerStatus;
  final Color verificationTextStatus;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 10.h, right: 10.h, left: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        height: 75.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: themeMode == ThemeMode.light
              ? AppColors.kNeutralViolet
              : AppColors.kTransparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       width: 40.w,
            //       height: 40.h,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4.r),
            //         color: AppColors.kEnabledButton,
            //       ),
            //       child: Center(
            //         child: Image.asset(
            //           AppImages.bankAccount,
            //           width: 24.w,
            //           height: 24.h,
            //         ),
            //       ),
            //     ),
            //     // Gap(10.w),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         TextView(
            //           text: bankName,
            //           fontSize: 18.spMin,
            //           fontWeight: FontWeight.w600,
            //           textOverflow: TextOverflow.ellipsis,
            //           color: AppColors.kTextBlack,
            //           fontFamily: ttHoves,
            //         ),
            //         Gap(3.h),
            //         TextView(
            //           text: '$accountName - $accountNumber',
            //           fontSize: 10.spMin,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.kSubText,
            //           fontFamily: ttHoves,
            //         )
            //       ],
            //     ),
            //   ],
            // ),
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: themeMode == ThemeMode.light
                    ? AppColors.kEnabledButton
                    : AppColors.kPrimary150,
              ),
              child: Center(
                child: Image.asset(
                  AppImages.bankAccount,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: bankName,
                    fontSize: 18.spMin,
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                    fontFamily: ttHoves,
                  ),
                  Gap(3.h),
                  TextView(
                    text: '$accountName - $accountNumber',
                    fontSize: 10.spMin,
                    fontWeight: FontWeight.w400,
                    color: themeMode == ThemeMode.light
                        ? AppColors.kSubText
                        : AppColors.kTextWhite,
                    fontFamily: ttHoves,
                  )
                ],
              ),
            ),
            Container(
              // width: 47.w,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              height: 22.h,
              decoration: BoxDecoration(
                color: verifyContainerStatus,
                borderRadius: BorderRadius.circular(
                  40.r,
                ),
              ),
              child: Center(
                child: TextView(
                  text: verificationStatus,
                  fontSize: 10.spMin,
                  fontWeight: FontWeight.w500,
                  color: verificationTextStatus,
                  fontFamily: ttHoves,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
