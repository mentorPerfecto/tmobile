import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/view/components/a_user_bank_container.dart';



class BankListScreen extends ConsumerStatefulWidget {
  const BankListScreen({super.key});

  @override
  ConsumerState<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends ConsumerState<BankListScreen> {
  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Scaffold(
      appBar: AppBars.mainAppBar(
        context,
        bottomVisible: true,
        bottomText: 'Your Bank',
        textSize: 20.spMin,
      ),
      body: SafeArea(
        child: XResponsiveWrap.mobile(
          onRefresh: () => profileProvider.loadData(context),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          // loading: provider.isGettingPersonalListings,
          // loadFailed:  recycleProvider.recycleHistoryResponse!.data == [],
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(30),
                  Align(alignment: Alignment.centerLeft,
                    child: TextView(
                      text: "Your bank to receive payout",
                      fontSize: 14.spMin,
                    ),
                  ),
                  Gap(20.h),
                  ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AUserBank(themeMode: themeMode, isBankList: true,);
                      }),
                  Gap(50.h),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        navigatePush(context, const FillBankDetailsScreen());
                      },
                      child: Container(
                        width: 179.w,
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.kPrimary1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 28.spMin,
                              color: AppColors.kPrimary1,
                            ),
                            Gap(10.w),
                            const TextView(
                              text: "Add Bank Account",
                              color: AppColors.kPrimary1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
