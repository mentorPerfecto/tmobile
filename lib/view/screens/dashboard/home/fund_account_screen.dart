// import 'package:flutter/material.dart';
// import 'package:tampay/src/components.dart';
// import 'package:tampay/src/config.dart';
// import 'package:tampay/src/utils.dart';
// import 'package:tampay/view/screens/dashboard/home/add_money_screen.dart';
// import 'package:tampay/view/screens/dashboard/home/bank_transfer_screen.dart';
//
// class FundAcoountScreen extends StatelessWidget {
//   const FundAcoountScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = (MediaQuery.sizeOf(context).width - 20);
//     double seventyOfScreenSize = screenWidth * (74 / 100);
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20.w,
//             vertical: 40.h,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 200.w,
//                 height: 24.h,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () => navigateBack(context),
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         size: 24.spMin,
//                         color: AppColors.kTextBlack,
//                       ),
//                     ),
//                     TextView(
//                       text: fundYourAccount,
//                       fontSize: 16.spMin,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: ttHoves,
//                       color: AppColors.kTextBlack,
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 45.h,
//               ),
//               UserAccountCard(
//                 leadingLogoContainerColor: AppColors.kAsh50,
//                 titleDouble: 16.spMin,
//                 subTitleDouble: 14.spMin,
//                 titleFontWeight: FontWeight.w500,
//                 subTitleFontWeight: FontWeight.w400,
//                 titleColor: AppColors.kTextBlack,
//                 subTitleColor: AppColors.kSubText,
//                 entireWidgetOnTap: () {
//                   navigatePush(context, const BankTransferScreen());
//                 },
//                 title: bankTransfer,
//                 subTitleText: transferToAccount,
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 24.spMin,
//                   color: AppColors.kTextBlack,
//                 ),
//                 leadingLogo: Image.asset(
//                   AppImages.bankAccount,
//                   width: 20.w,
//                   height: 20.h,
//                   color: AppColors.kPrimary1,
//                 ),
//                 screenWidth: screenWidth,
//                 sixtyOfScreenSize: seventyOfScreenSize,
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               UserAccountCard(
//                 leadingLogoContainerColor: AppColors.kAsh50,
//                 titleDouble: 16.spMin,
//                 subTitleDouble: 14.spMin,
//                 titleFontWeight: FontWeight.w500,
//                 subTitleFontWeight: FontWeight.w400,
//                 titleColor: AppColors.kTextBlack,
//                 subTitleColor: AppColors.kSubText,
//                 screenWidth: screenWidth,
//                 sixtyOfScreenSize: seventyOfScreenSize,
//                 leadingLogo: Image.asset(
//                   AppImages.creditCard,
//                   width: 20.w,
//                   height: 20.h,
//                   color: AppColors.kPrimary1,
//                 ),
//                 entireWidgetOnTap: () {
//                   navigatePush(context, const AddMoneyScreen());
//                 },
//                 subTitleText: fundWithCard,
//                 title: debitCredit,
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 24.spMin,
//                   color: AppColors.kTextBlack,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
