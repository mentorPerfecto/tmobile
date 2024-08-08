import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/a_user_bank_container.dart';
import 'package:tampay/view/components/exchange_screen_component/note_card.dart';

class SellCryptoScreen extends ConsumerStatefulWidget {
  const SellCryptoScreen({super.key});

  @override
  ConsumerState<SellCryptoScreen> createState() => _SellCryptoScreenState();
}

class _SellCryptoScreenState extends ConsumerState<SellCryptoScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var dashProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        text: "Sell ${DummyData.cryptoAbbreviation}",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: themeMode == ThemeMode.dark ? AppColors.kOnyxBlack : AppColors.kSilverMist,
              ),
              child: Center(
                child:
                SizedBox(
                  width:177.w,
                  height: 177.h,
                  child: Center(
                    child: QrImageView(
                      data: "message",
                      version: QrVersions.auto,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppColors.kPrimary1,
                        // borderRadius: 10,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColors.kPrimary1,
                        // borderRadius: 5,
                        // roundedOutsideCorners: true,
                      ),
                      embeddedImage: const AssetImage('assets/images/4.0x/logo_yakka_transparent.png'),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size.square(40),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // ImageView.asset(
                //   AppImages.barScanCode,
                //   width: 177.w,
                //   height: 177.h,
                //   color: themeMode == ThemeMode.dark ? AppColors.kGrey200 : AppColors.kWhite,
                // ),
              ),
            ),
            Gap(20.h),
            DropDownButtonMain(
              title: dashProvider.cryptoAcronym,
              hintText: "",
              onTap: (crypto) {
                dashProvider.selectACyptoAsset(cryptoAcronym: crypto);
              },
              items: dashProvider.tPayCryptoAssets
                  .map(
                    (cryptoAssets) => DropdownMenuItem<String>(
                      value: cryptoAssets,
                      child: TextView(
                        text: cryptoAssets,
                      ),
                    ),
                  )
                  .toList(),
              label: "Network",
            ),
            Gap(20.h),
            WalletAddress(themeMode: themeMode, dashProvider: dashProvider),
            Gap(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(text: "Credited Account"),
                Gap(5.h),
                AUserBank(themeMode: themeMode)
              ],
            ),
            Gap(20.h),
            SomethingToNote(
              thingsToNote: TextView(
                text:
                    "Please ensure to send only ${DummyData.crypto} (${DummyData.cryptoAbbreviation})"
                    " to this address or you may lose your funds.",
                color: AppColors.kWhite,
                maxLines: 2,
              ),
            ),
            Gap(20.h),
            DefaultButtonMain(
              color: AppColors.kPrimary1,
              text: "Completed",
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
            )
          ],
        ),
      ),
    );
  }
}



class WalletAddress extends StatelessWidget {
  const WalletAddress({
    super.key,
    required this.themeMode,
    required this.dashProvider,
  });

  final ThemeMode themeMode;
  final DashboardViewModel dashProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: "Wallet Address"),
        Gap(5.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                    color: themeMode == ThemeMode.light
                        ? AppColors.kLightSilver
                        : AppColors.kOnyxBlack,
                    borderRadius: BorderRadius.circular(16.r)),
                child: TextView(
                  text: "bc1q04tvdada..............wjdgfee7g",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ),
            ),
            Gap(7.w),
            WalletActionButton(
              themeMode: themeMode,
              onPressed: () async {
                dashProvider.copyToClipboard("bc1q04tvdada..............wjdgfee7g");
                showToast(msg: "Copied Wallet Address to clipboard", isError: false);
              },
              actionImage: AppImages.copyIcon,
            ),
            Gap(7.w),
            WalletActionButton(
              themeMode: themeMode,
              onPressed: () {},
              actionImage: AppImages.downloadIcon,
            ),
          ],
        ),
      ],
    );
  }
}

class WalletActionButton extends StatelessWidget {
  WalletActionButton({
    super.key,
    required this.themeMode,
    required this.actionImage,
    this.onPressed,
  });

  final ThemeMode themeMode;
  final String actionImage;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
        ),
        child: Center(
            child: ImageView.asset(
          actionImage,
          width: 18.w,
          height: 18.h,
          color: themeMode == ThemeMode.light ? AppColors.kGrey900 : AppColors.kWhite,
        )),
      ),
    );
  }
}
