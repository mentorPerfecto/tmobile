import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';


class AddBankScreen extends ConsumerStatefulWidget {
  const AddBankScreen({super.key});

  @override
  ConsumerState<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends ConsumerState<AddBankScreen> {
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
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            bankLists(),
            SizedBox(
              height: 44.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: addButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget bankWidget({
    required String accName,
    required String accNo,
    required String bankName,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: accNo,
              fontSize: 12.spMin,
            ),
            SizedBox(
              height: 8.h,
            ),
            TextView(
              text: bankName,
              fontSize: 12.spMin,
              color: AppColors.kCardText,
            ),
            SizedBox(
              height: 8.h,
            ),
            TextView(
              text: accName,
              fontSize: 12.spMin,
              color: AppColors.kCardText,
            ),
          ],
        ),
        GestureDetector(
            onTap: () {},
            child: ImageView.asset(
              AppImages.deleteLogo,
              width: 20.w,
            ))
      ],
    );
  }

  bankLists() {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Check if it's the last item
        bool isLastItem = index == 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
              ),
              child: bankWidget(
                  accName: 'Daniel Mason Ovie',
                  accNo: '8107143027',
                  bankName: 'Opay'),
            ),
            isLastItem
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const TampayDivider(),
                  ),
          ],
        );
      },
    );
  }

  addButton() {
    return GestureDetector(
      onTap: () {
        navigatePush(context, const  FillBankDetailsScreen());
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 35.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                width: 0.5.r, color: AppColors.kCardText.withOpacity(0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.kCardText,
              size: 24.r,
            ),
            SizedBox(
              width: 8.w,
            ),
            TextView(
              text: addAnotherBankText,
              fontSize: 12.spMin,
            )
          ],
        ),
      ),
    );
  }
}
