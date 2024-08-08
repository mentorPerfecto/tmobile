import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/a_user_bank_container.dart';
class SelectBankScreen extends ConsumerStatefulWidget {
  const SelectBankScreen({super.key});

  @override
  ConsumerState<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends ConsumerState<SelectBankScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(dashboardViewModel);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Scaffold(
      appBar: AppBars.mainAppBar(
        context,
        bottomVisible: true,
        bottomText: selectBankText,
        textSize: 20.spMin,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0.w,
              vertical: 15.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "Select bank to receive payout",
                  fontSize: 14.spMin,
                ),
                Gap(20.h),
                ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AUserBank(themeMode: themeMode, isBankList: false,);
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
          ),
        ),
      ),
    );
  }
}
