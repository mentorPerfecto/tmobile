import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/exchange_screen_component/note_card.dart';
import 'package:tampay/view/components/transaction_details_card.dart';

class CryptoAssetFinalPurchaseScreen extends ConsumerWidget {
  const CryptoAssetFinalPurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    var dashProvider = ref.watch(dashboardViewModel);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(context,
          isVisible: false, text: "Buy ${DummyData.cryptoAbbreviation}"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 15.w,
        ),
        child: Column(
          children: [
            YouAreAboutToPay(
              themeMode: themeMode,
              dashProvider: dashProvider,
              theme: theme,
            ),
            Gap(20.h),
            TransactionDetails(details: [
              Details(
                title: "Destination",
                trailing: TextView(
                  text: dashProvider.walletAddressController.text,
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ),
              Gap(20.h),
              Details(
                title: "Network",
                trailing: TextView(
                  text: DummyData.networkType ?? "Error",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ),
              Gap(20.h),
              Details(
                title: "Transaction Fee 1%",
                trailing: TextView(
                  text: "3.25 ${DummyData.cryptoAbbreviation}",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ),
              Gap(20.h),
              Details(
                title: "Estimated confirm time",
                trailing: TextView(
                  text: "5 minutes",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ),
            ]),
            Gap(20.h),
            TransactionDetails(
              label: "Payment Details",
              details: [
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
              ],
            ),
            Gap(20.h),
            const SomethingToNote(thingsToNote: WarningNotesWhileTransacting()),
            Gap(40.h),
            BottomActionButton(themeMode: themeMode, dashProvider: dashProvider)
          ],
        ),
      ),
    );
  }
}


class WarningNotesWhileTransacting extends StatelessWidget {
  const WarningNotesWhileTransacting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: "1. Do not reference ",
            children: [
              TextSpan(
                text: '"Crypto"',
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 10.spMin,
                  fontFamily: soraFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'In your transfer description',
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 10.spMin,
                  fontFamily: soraFont,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          style: TextStyle(
            color: AppColors.kWhite,
            fontSize: 10.spMin,
            fontFamily: soraFont,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextView(
          text: "2. Make sure you sent the exact amount",
          fontSize: 10.spMin,
          color: AppColors.kWhite,
        ),
        TextView(
          text: "3. Recheck transaction details before confirming",
          fontSize: 10.spMin,
          color: AppColors.kWhite,
        ),
      ],
    );
  }
}

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({
    super.key,
    required this.themeMode,
    required this.dashProvider,
  });

  final ThemeMode themeMode;
  final DashboardViewModel dashProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultButtonMain(
          width: 160.w,
          borderColor: AppColors.kPrimary1,
          textColor: AppColors.kPrimary1,
          text: "Cancel trade",
          onPressed: () {
            navigateBack(context);
          },
        ),
        DefaultButtonMain(
          width: 160.w,
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: TPayDefaultProgressStatusPopUp(
                  progressStatusLogo: AppImages.inProgressIcon,
                  progressStatusLogoColor: themeMode == ThemeMode.light
                      ? AppColors.kWoodSmoke300
                      : AppColors.kWoodSmoke700,
                  progressStatusTextTitle: "In progress",
                  progressStatusTextBody:
                      "Your order has been received. We will notify you when it's ready,"
                      " usually within 45 seconds",
                  action: DefaultButtonMain(
                    width: 195.w,
                    color: AppColors.kPrimary1,
                    text: "Back to Home",
                    onPressed: () {
                      dashProvider.setPageIndexToHome(context);
                    },
                  ),
                ),
              ),
            );
          },
          color: AppColors.kPrimary1,
          text: "Transferred",
        ),
      ],
    );
  }
}

class YouAreAboutToPay extends StatelessWidget {
  const YouAreAboutToPay({
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
            text: "You're about to buy",
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
              text: "Time left to transfer: ",
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
