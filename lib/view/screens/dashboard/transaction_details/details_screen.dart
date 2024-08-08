import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/transaction_details_card.dart';

class DetailsScreen extends ConsumerWidget {
  DetailsScreen({Key? key, this.transactionStatus}) : super(key: key);
  String? transactionStatus;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var dashProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(context, text: "Details"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 15.w,
        ),
        child: Column(
          children: [
            YouBought(themeMode: themeMode, dashProvider: dashProvider, theme: theme),
            Gap(20.h),
            TransactionDetails(
              details: [
                Details(
                  title: "Reference",
                  trailing: Row(
                    children: [
                      TextView(
                        text: "VNDCHBSDFDVL.SNCKLC.J",
                        color:
                            themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          dashProvider.copyToClipboard("Fidelity Bank");
                          showToast(msg: "Copied to clipboard", isError: false);
                        },
                        child: ImageView.asset(
                          AppImages.copyIcon,
                          width: 16.w,
                          height: 16.h,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20.h),
                Details(
                  title: "Hash",
                  trailing: Row(
                    children: [
                      TextView(
                        text: "cmvdhf,vakckw.acwk.vc",
                        color:
                            themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          dashProvider.copyToClipboard("Fidelity Bank");
                          showToast(msg: "Copied to clipboard", isError: false);
                        },
                        child: ImageView.asset(
                          AppImages.copyIcon,
                          width: 16.w,
                          height: 16.h,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Gap(20.h),
            TransactionDetails(
              label: "Payment Details",
              details: [
                Details(
                  title: "Status",
                  trailing: TextView(
                    text: transactionStatus ?? "Error",
                    color: dashProvider.transactionStatusColor(transactionStatus ?? "Error"),
                  ),
                ),
                Gap(20.h),
                Details(
                  title: "Rate",
                  trailing: TextView(
                    text: "1705.56/$dollarSign",
                    color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                  ),
                ),
                Gap(20.h),
                Details(
                  title: "Merchant Name",
                  trailing: Row(
                    children: [
                      TextView(
                        text: "Fidelity Bank",
                        color:
                            themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          dashProvider.copyToClipboard("Fidelity Bank");
                          showToast(msg: "Copied to clipboard", isError: false);
                        },
                        child: ImageView.asset(
                          AppImages.copyIcon,
                          width: 16.w,
                          height: 16.h,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20.h),
                Details(
                  title: "Bank Name",
                  trailing: Row(
                    children: [
                      TextView(
                        text: "Fidelity Bank",
                        color:
                            themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          dashProvider.copyToClipboard("Fidelity Bank");
                          showToast(msg: "Copied to clipboard", isError: false);
                        },
                        child: ImageView.asset(
                          AppImages.copyIcon,
                          width: 16.w,
                          height: 16.h,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20.h),
                Details(
                  title: "Account Number",
                  trailing: Row(
                    children: [
                      TextView(
                        text: "0550241576",
                        color:
                            themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                      ),
                      Gap(10.w),
                      GestureDetector(
                        onTap: () {
                          dashProvider.copyToClipboard("Fidelity Bank");
                          showToast(msg: "Copied to clipboard", isError: false);
                        },
                        child: ImageView.asset(
                          AppImages.copyIcon,
                          width: 16.w,
                          height: 16.h,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Gap(50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButtonMain(
                  width: 160.w,
                  borderColor: AppColors.kPrimary1,
                  textColor: AppColors.kPrimary1,
                  text: "Share",
                  onPressed: () {
                    navigateBack(context);
                  },
                ),
                DefaultButtonMain(
                  width: 160.w,
                  onPressed: () {
                    dashProvider.setPageIndexToHome(context);
                  },
                  color: AppColors.kPrimary1,
                  text: "Go home",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class YouBought extends StatelessWidget {
  const YouBought({
    super.key,
    required this.themeMode,
    required this.dashProvider,
    required this.theme,
  });

  final ThemeMode themeMode;
  final DashboardViewModel dashProvider;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextView(
            text: "You bought",
            color: themeMode == ThemeMode.light ? AppColors.kGrey500 : AppColors.kGrey400,
          ),
          Gap(7.h),
          Text.rich(
            TextSpan(text: dashProvider.cryptoAssetController.text, children: [
              TextSpan(
                  text: " ${DummyData.cryptoAbbreviation}",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontFamily: soraFont,
                    fontSize: 18.spMin,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            style: TextStyle(
              color: themeMode == ThemeMode.light ? AppColors.kWarning500 : AppColors.kGoldenOrange,
              fontFamily: soraFont,
              fontSize: 18.spMin,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(7.h),
          Text.rich(
            TextSpan(
              text: "Completed time: ",
              children: [
                TextSpan(
                  text: "14:23",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 12.spMin,
                    fontWeight: FontWeight.w600,
                    fontFamily: soraFont,
                  ),
                )
              ],
            ),
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 12.spMin,
              fontWeight: FontWeight.w400,
              fontFamily: soraFont,
            ),
          ),
        ],
      ),
    );
  }
}
