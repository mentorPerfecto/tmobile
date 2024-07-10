// import 'dart:convert';
//
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:monnify_payment_sdk/monnify_payment_sdk.dart';
// import 'package:uuid/uuid.dart';
// import 'package:tampay/model/response/transaction_pin_status.dart';
// import 'package:tampay/repository/backend/trx_backend.dart';
// import 'package:tampay/src/components.dart';
// import 'package:tampay/src/models.dart';
// import 'package:tampay/src/providers.dart';
// import 'package:tampay/src/utils.dart';
// import 'package:tampay/view/screens/dashboard/dashboard_screen.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// import '../model/response/trx_history_response.dart';
// import '../src/config.dart';
//
// final walletViewModel = ChangeNotifierProvider((ref) => WalletViewModel());
//
// class WalletViewModel extends ChangeNotifier {
//   final trxService = TransactionBackend();
//   // final String _pinCode = '';
//   late Monnify? monnify;
//   var uuid = const Uuid();
//
//   bool isSettingOTP = false;
//
//   CurrencyTextInputFormatter currencyFormatter(context) => CurrencyTextInputFormatter.currency(
//
//         locale: 'en',
//         symbol: '${UtilFunctions.currency(context)} ',
//       );
//
//   CustomButtonState _buttonFundingState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//
//   CustomButtonState _buttonWithdrawalState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   CustomButtonState _buttonPinState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   CustomButtonState _buttonCreatePinState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   CustomButtonState _buttonOtpPinState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   CustomButtonState _buttonConfirmPinState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   final CustomButtonState _buttonSendFundState = CustomButtonState(
//     buttonState: ButtonState.disabled,
//     text: createAccount,
//   );
//   CustomButtonState _downloadReceiptState = CustomButtonState(
//     buttonState: ButtonState.idle,
//     text: 'Download Receipt',
//   );
//
//   TrxHistoryResponse? _trxResponse;
//
//   void _setCanLoadMoreTransactions({required bool status}) {
//     _canLoadMoreTransactions = status;
//     notifyListeners();
//   }
//
//   int _trxPage = 2;
//   int get trxPage => _trxPage;
//   bool _canLoadMoreTransactions = true;
//   bool get canLoadMoreTransactions => _canLoadMoreTransactions;
//
//   CustomButtonState get downloadReceiptState => _downloadReceiptState;
//   CustomButtonState get buttonFundingState => _buttonFundingState;
//   CustomButtonState get buttonCreatePinState => _buttonCreatePinState;
//   CustomButtonState get buttonOtpPinState => _buttonOtpPinState;
//   CustomButtonState get buttonConfirmPinState => _buttonConfirmPinState;
//   CustomButtonState get buttonWithdrawalState => _buttonWithdrawalState;
//   CustomButtonState get buttonSendFundState => _buttonSendFundState;
//   CustomButtonState get buttonPinState => _buttonPinState;
//   TextEditingController _fundWalletAmountController = TextEditingController();
//   TextEditingController _createPinController = TextEditingController();
//   TextEditingController _otpController = TextEditingController();
//   TextEditingController _confirmPinController = TextEditingController();
//   final TextEditingController _withdrawalAmountController = TextEditingController();
//   TextEditingController _pinCodeController = TextEditingController();
//
//   TextEditingController get fundWalletAmountController => _fundWalletAmountController;
//   TextEditingController get createPinController => _createPinController;
//   TextEditingController get otpController => _otpController;
//   TextEditingController get confirmPinController => _confirmPinController;
//   TextEditingController get pinCodeController => _pinCodeController;
//   TextEditingController get withdrawalAmountController => _withdrawalAmountController;
//
//   ProfileViewModel profileViewModel = ProfileViewModel();
//   // bool isGettingData = true;
//   bool isGettingTrx = true;
//   bool isCheckingTrx = false;
//   bool isCreatingWithdrawalRequest = false;
//   bool isRentingProperty = false;
//
//   String? acctBalance = "0";
//   String errorText = "Pin does not match";
//   List<Transactions> trxList = [];
//
//   TransactionPinStatus? _transactionPinStatus;
//   TransactionPinStatus? get transactionPinStatus => _transactionPinStatus;
//
//   void updateFundingButtonState() {
//     if (_fundWalletAmountController.text.isEmpty) {
//       _buttonFundingState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//     } else {
//       _buttonFundingState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//     }
//     notifyListeners();
//   }
//
//   void updateWithdrawalButtonState() {
//     if (_withdrawalAmountController.text.isEmpty) {
//       _buttonWithdrawalState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//     } else {
//       _buttonWithdrawalState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//     }
//     notifyListeners();
//   }
//
//   void updateCreatePinButtonState() {
//     if (_createPinController.text.length < 4) {
//       _buttonCreatePinState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//     } else {
//       _buttonCreatePinState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//     }
//     notifyListeners();
//   }
//
//   void updateOtpPinButtonState() {
//     if (_otpController.text.length < 6) {
//       _buttonOtpPinState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//     } else {
//       _buttonOtpPinState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//     }
//     notifyListeners();
//   }
//
//   void updateConfirmPinButtonState() {
//     if (_confirmPinController.text != _createPinController.text &&
//         _confirmPinController.text.length == 4) {
//       _buttonConfirmPinState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//       errorText;
//     } else if (_confirmPinController.text == _createPinController.text &&
//         _confirmPinController.text.length == 4) {
//       _buttonConfirmPinState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//       errorText = '';
//     }
//     notifyListeners();
//   }
//
//   Future<void> generateTransactionDetailsDocument(int index) async {
//     _downloadReceiptState = CustomButtonState(
//       buttonState: ButtonState.loading,
//       text: 'Download Receipt',
//     );
//     notifyListeners();
//     final doc = pw.Document(pageMode: PdfPageMode.fullscreen);
//     // final font = await rootBundle.load("assets/fonts/TTHoves-Black.ttf");
//     // final ttf = pw.Font.ttf(font);
//     final imageByteData = await rootBundle.load(AppImages.blueAppLogo);
//     // Convert ByteData to Uint8List
//     final imageUint8List =
//         imageByteData.buffer.asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
//     final image = pw.MemoryImage(
//       imageUint8List,
//     );
//
//     pw.Widget divider = pw.SizedBox(
//       height: 1.5.h,
//       width: double.infinity.w,
//       child: pw.Divider(
//         color: const PdfColor.fromInt(0xffEAECF0),
//         thickness: 1.5.h,
//       ),
//     );
//     pw.Widget header() {
//       var trxItem = trxList[index];
//       String addMinus = trxItem.transactionType == credit ? "+" : "-";
//       return pw.Align(
//           alignment: pw.Alignment.topCenter,
//           child: pw.Padding(
//             padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.center,
//               children: [
//                 //first sub
//                 pw.Text(
//                   "Transaction Receipt",
//                   style: pw.TextStyle(
//                     fontSize: 16.spMin,
//                     color: PdfColors.black,
//                     // font: ttf,
//                   ),
//                 ),
//                 pw.SizedBox(height: 30.h),
//                 //second sub
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   children: [
//                     pw.Text(
//                       "$addMinus $nairaNotation${UtilFunctions.formatAmount(double.parse(trxItem.amount.toString()))}",
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 30.spMin,
//                         color: trxItem.transactionType == credit
//                             ? const PdfColor.fromInt(0xff1E9114)
//                             : const PdfColor.fromInt(0xffF42727),
//                         // font: ttf,
//                       ),
//                     ),
//                     pw.SizedBox(height: 13.h),
//                     pw.Text(
//                       "${UtilFunctions.formatDate(trxItem.createdAt.toString())}, ${UtilFunctions.formatTime(trxItem.createdAt.toString())}",
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.normal,
//                         fontSize: 12.spMin,
//                         color: const PdfColor.fromInt(0xff57585B),
//                         // font: ttf,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ));
//     }
//
//     // pw.Widget recipientDetails() {
//     //   var trxItem = trxList[index];
//     //   return pw.Padding(
//     //     padding: pw.EdgeInsets.symmetric(vertical: 15.h),
//     //     child:
//
//     //         //
//     //         pw.Container(
//     //             width: double.infinity.w,
//     //             color: PdfColors.white,
//     //             padding: pw.EdgeInsets.only(top: 10.h),
//     //             child: pw.Column(children: [
//     //               pw.Row(
//     //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//     //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//     //                 children: [
//     //                   pw.Text(
//     //                     'Transaction Description ',
//     //                     style: pw.TextStyle(
//     //                       fontSize: 14.spMin,
//     //                       color: PdfColors.black,
//     //                       fontWeight: pw.FontWeight.bold
//     //                       // font: ttf,
//     //                     ),
//     //                   ),
//     //                   pw.SizedBox(width: 10.w),
//     //                   pw.Expanded(
//     //                     child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
//     //                       pw.Text(
//     //                         trxItem.paymentDescription.toString(),
//     //                         maxLines: 2,
//     //                         style: pw.TextStyle(
//     //                           fontSize: 15.spMin,
//     //                           fontWeight: pw.FontWeight.normal,
//     //                           color: PdfColors.black,
//     //                           // font: ttf,
//     //                         ),
//     //                       ),
//
//     //                       pw.SizedBox(height: 5.h),
//     //                     ]),
//     //                   )
//     //                 ],
//     //               ),
//
//     //             ])),
//     //   );
//     // }
//
//     pw.Widget purpose() {
//       var trxItem = trxList[index];
//       return pw.Padding(
//         padding: pw.EdgeInsets.symmetric(vertical: 15.h),
//         child:
//             //
//             pw.Container(
//           width: double.infinity.w,
//           color: PdfColors.white,
//           padding: pw.EdgeInsets.only(top: 15.h),
//           child: pw.SizedBox(
//             child: pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text(
//                   'Purpose',
//                   style: pw.TextStyle(
//                     fontSize: 14.spMin,
//                     color: PdfColors.black,
//                     fontWeight: pw.FontWeight.bold,
//                     // font: ttf,
//                   ),
//                 ),
//                 pw.Text(
//                   trxItem.paymentMethod?.toUpperCase() ?? "",
//                   style: pw.TextStyle(
//                     fontSize: 15.spMin,
//                     color: PdfColors.black,
//                     // font: ttf,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     pw.Widget transactionType() {
//       var trxItem = trxList[index];
//       return pw.Padding(
//         padding: pw.EdgeInsets.symmetric(vertical: 15.h),
//         child: pw.Container(
//           width: double.infinity.w,
//           color: PdfColors.white,
//           padding: pw.EdgeInsets.only(top: 10.h),
//           child: pw.SizedBox(
//             child: pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text(
//                   'Transaction Type',
//                   style: pw.TextStyle(
//                     fontSize: 14.spMin,
//                     color: PdfColors.black,
//                     fontWeight: pw.FontWeight.bold,
//                     // font: ttf,
//                   ),
//                 ),
//                 pw.Text(
//                   trxItem.transactionType?.toUpperCase() ?? "",
//                   style: pw.TextStyle(
//                     fontSize: 15.spMin,
//                     // fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.black,
//                     // font: ttf,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     pw.Widget transactionReference() {
//       var trxItem = trxList[index];
//       return pw.Padding(
//         padding: pw.EdgeInsets.symmetric(vertical: 15.h),
//         child:
//             //
//             //
//             pw.Container(
//           width: double.infinity.w,
//           color: PdfColors.white,
//           padding: pw.EdgeInsets.only(top: 10.h),
//           child: pw.SizedBox(
//             child: pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   child: pw.Text(
//                     'Transaction Reference',
//                     style: pw.TextStyle(
//                       fontSize: 14.spMin,
//                       color: PdfColors.black,
//                       fontWeight: pw.FontWeight.bold,
//                       // font: ttf,
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   child: pw.Text(
//                     trxItem.transactionReference ?? "",
//                     maxLines: 2,
//                     style: pw.TextStyle(
//                       fontSize: 15.spMin,
//                       //fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.black,
//                       // font: ttf,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     pw.Widget transactionStatus() {
//       var trxItem = trxList[index];
//       return pw.Padding(
//         padding: pw.EdgeInsets.symmetric(vertical: 15.h),
//         child:
//             //
//             pw.Container(
//           width: double.infinity.w,
//           color: PdfColors.white,
//           padding: pw.EdgeInsets.only(top: 10.h),
//           child: pw.SizedBox(
//             child: pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text(
//                   'Transaction Status',
//                   style: pw.TextStyle(
//                     fontSize: 14.spMin,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.black,
//                     // font: ttf,
//                   ),
//                 ),
//                 pw.Text(
//                   trxItem.status?.toUpperCase() ?? "",
//                   style: pw.TextStyle(
//                     fontSize: 15.spMin,
//                     //fontWeight: pw.FontWeight.bold,
//                     color: trxItem.status!.toUpperCase() == "SUCCESS"
//                         ? const PdfColor.fromInt(0xff1E9114)
//                         : PdfColors.black,
//                     // font: ttf,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     pw.Widget bottomImage() {
//       return pw.Align(
//           alignment: pw.AlignmentDirectional.bottomCenter,
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.center,
//             children: [
//               pw.SizedBox(
//                 child: pw.Image(
//                   image,
//                   width: 240.w,
//                   height: 100.h,
//                 ),
//               ),
//               pw.SizedBox(
//                 height: 5.h,
//               ),
//             ],
//           ));
//     }
//
//     doc.addPage(
//       pw.MultiPage(
//         // pageTheme: const pw.PageTheme(
//         //   orientation: pw.PageOrientation.portrait,
//         // ),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return [
//             bottomImage(),
//             divider,
//             pw.SizedBox(height: 5.h),
//             header(),
//             pw.SizedBox(height: 5.h),
//             divider,
//             purpose(),
//             divider,
//             transactionType(),
//             divider,
//             transactionReference(),
//             divider,
//             transactionStatus(),
//           ];
//         },
//       ),
//     );
//
//     //
//
//     await Printing.sharePdf(bytes: await doc.save(), filename: 'tampay-transaction${DateTime.now()}.pdf');
//     PdfPreview(
//       build: (format) => doc.save(),
//     );
//
//     _downloadReceiptState = CustomButtonState(
//       buttonState: ButtonState.idle,
//       text: 'Download Receipt',
//     );
//     notifyListeners();
//   }
//
//   Future<dynamic> getTransactions({required num userType}) async {
//     try {
//       await trxService.fetchTransactions(userType: userType.toInt()).then((value) async {
//         if (value != null) {
//           final decodedResponse = jsonDecode(value.toString());
//
//           if (decodedResponse['status'].toString() == 'true') {
//             _trxResponse = TrxHistoryResponse.fromJson(decodedResponse);
//             trxList = _trxResponse!.data!.transactions!.toList();
//             notifyListeners();
//             // check page count if its more than one, on every successful data fetch
//             _setCanLoadMoreTransactions(
//                 status: int.parse(_trxResponse!.data!.lastPage.toString()) > 1);
//           }
//         }
//       }).whenComplete(() {
//         isGettingTrx = false;
//         notifyListeners();
//       }).onError((error, stackTrace) {
//         logger
//           ..e(error)
//           ..e(stackTrace);
//       });
//     } catch (e) {
//       logger.e(e);
//     }
//   }
//
//   Future<dynamic> getMoreTransactions({required num userType}) async {
//     await trxService.fetchTransactions(userType: userType.toInt(), page: _trxPage).then((value) {
//       if (value != null) {
//         final decodedResponse = jsonDecode(value.toString());
//
//         if (decodedResponse['status'].toString() == 'true') {
//           _trxResponse = TrxHistoryResponse.fromJson(decodedResponse);
//           trxList.addAll(_trxResponse!.data!.transactions!.toList());
//           notifyListeners();
//         }
//         // check page count if its more than one, on every successful data fetch
//         // update page count on every successful data fetch
//         if (int.parse(_trxResponse!.data!.lastPage.toString()) > _trxPage) {
//           _trxPage++;
//           _setCanLoadMoreTransactions(status: true);
//         } else {
//           _setCanLoadMoreTransactions(status: false);
//         }
//       }
//     }).onError((error, stackTrace) {
//       logger
//         ..e(error)
//         ..e(stackTrace);
//     });
//   }
//
//   Future<void> getAcctBalance({required num? userType}) async {
//     try {
//       await trxService.fetchAcctBalance(userType: userType!.toInt()).then((value) {
//         if (value != null) {
//           final decodedResponse = jsonDecode(value.toString());
//           if (decodedResponse['status'] == true) {
//             var resBody = decodedResponse as Map<String, dynamic>;
//             acctBalance = resBody['data']['balance'].toString();
//             _trxPage = 2;
//             notifyListeners();
//             // logger.t(acctBalance);
//           }
//         }
//       });
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }
//
//   Future<void> setTransactionPin(BuildContext context) async {
//     try {
//       _buttonConfirmPinState = CustomButtonState(
//         buttonState: ButtonState.loading,
//         text: login,
//       );
//       // navigatePush(
//       //     context, const SuccessLoadingScreen(informationText: processingInfo));
//       isSettingOTP = true;
//       notifyListeners();
//       await trxService.setTransactionPin(pin: _createPinController.text).then((value) {
//         if (value != null) {
//           if (value['status'] == true) {
//             navigateReplace(
//               context,
//               const SuccessScreen(
//                 infoText: pinSetSuccessfully,
//                 newPage: DashBoardScreen(),
//                 navigateButtonText: continueText,
//               ),
//             );
//
//             _buttonConfirmPinState = CustomButtonState(
//               buttonState: ButtonState.idle,
//               text: login,
//             );
//             isSettingOTP = false;
//             clearData();
//             notifyListeners();
//             //checkTransactionPinState(context);
//
//             notifyListeners();
//             // logger.t(acctBalance);
//           } else {
//             navigateBack(context);
//             showToast(
//               msg: value['message'],
//               isError: false,
//             );
//             isSettingOTP = false;
//             notifyListeners();
//           }
//           notifyListeners();
//         }
//       }).whenComplete(() {
//         _buttonConfirmPinState = CustomButtonState(
//           buttonState: ButtonState.idle,
//           text: login,
//         );
//         isSettingOTP = false;
//         notifyListeners();
//       });
//     } catch (e) {
//       logger.e(e.toString());
//       showToast(
//         msg: somethingWentWrong,
//         isError: true,
//       );
//     }
//   }
//
//   Future<void> resetTransactionPin(
//     BuildContext context,
//     // {
//     //   required String otp,
//     //   required String newPin,
//     // }
//   ) async {
//     try {
//       _buttonConfirmPinState = CustomButtonState(
//         buttonState: ButtonState.loading,
//         text: login,
//       );
//       isSettingOTP = true;
//       // navigatePush(
//       //     context, const SuccessLoadingScreen(informationText: processingInfo));
//       notifyListeners();
//       await trxService
//           .resetTransactionPin(newPin: _createPinController.text, otp: _otpController.text)
//           .then((value) {
//         if (value != null) {
//           if (value['status'] == true) {
//             navigateReplace(
//               context,
//               SuccessScreen(
//                 infoText: value['message'],
//                 newPage: const DashBoardScreen(),
//                 navigateButtonText: continueText,
//               ),
//             );
//             _buttonConfirmPinState = CustomButtonState(
//               buttonState: ButtonState.idle,
//               text: login,
//             );
//             isSettingOTP = false;
//             clearData();
//
//             notifyListeners();
//             // logger.t(acctBalance);
//           } else {
//             isSettingOTP = false;
//             navigateBack(context);
//             showToast(
//               msg: value['message'],
//               isError: false,
//             );
//
//             notifyListeners();
//           }
//           notifyListeners();
//         }
//       }).whenComplete(() {
//         isSettingOTP = false;
//         _buttonConfirmPinState = CustomButtonState(
//           buttonState: ButtonState.idle,
//           text: login,
//         );
//         notifyListeners();
//       });
//     } catch (e) {
//       logger.e(e.toString());
//       showToast(
//         msg: somethingWentWrong,
//         isError: true,
//       );
//     }
//   }
//
//   Future<void> initPage() async {
//     _fundWalletAmountController = TextEditingController();
//     // _withdrawalAmountController = TextEditingController();
//     _pinCodeController = TextEditingController();
//     _createPinController = TextEditingController(text: _createPinController.text);
//     _confirmPinController = TextEditingController(text: _confirmPinController.text);
//     _otpController = TextEditingController(text: _otpController.text);
//     monnify = await Monnify.initialize(
//       applicationMode: ApplicationMode.TEST,
//       apiKey: 'MK_TEST_VRCX9LM0NK',
//       contractCode: '6693925283',
//     );
//     logger.t(monnify?.applicationMode);
//     notifyListeners();
//   }
//
//   void onInitializePayment(
//     context, {
//     required String customerName,
//     required String customerEmail,
//     required num userType,
//   }) async {
//     final paymentReference = uuid.v4();
//     var finalAmount =
//         _fundWalletAmountController.text.toString().split(' ')[1].replaceAll(',', '').toString();
//
//     // var finalAmount = 1000.toString();
//     final transaction = TransactionDetails().copyWith(
//         amount: double.parse(finalAmount),
//         currencyCode: 'NGN',
//         customerName: customerName,
//         customerEmail: customerEmail,
//         paymentReference: paymentReference,
//         paymentMethods: [PaymentMethod.CARD, PaymentMethod.ACCOUNT_TRANSFER]);
//
//     try {
//       final response = await monnify?.initializePayment(transaction: transaction);
//
//       logger.t(response);
//
//       navigatePush(
//           context, const SuccessLoadingScreen(informationText: "Confirming Wallet Funding"));
//
//       if (response!.transactionStatus.toString().toUpperCase() == 'PAID') {
//         await createTransactionRecord(context,
//             amount: response.amountPaid.toString(),
//             paymentReference: paymentReference.toString(),
//             userType: userType.toInt());
//         navigateReplace(context, const DashBoardScreen(setIndex: 3,));
//         showToast(
//           // msg:
//           //     "SUCCESS: NGN ${UtilFunctions.formatAmount(double.parse(response.amountPaid.toString()))} payment ${response.transactionStatus.toString().toLowerCase()}"
//           //     " through ${response.paymentMethod.toString().toLowerCase()}",
//             msg: "Successful",
//             isError: false);
//         notifyListeners();
//       } else {
//         navigateReplace(context, const DashBoardScreen(setIndex: 3,));
//         showToast(
//             msg: "Transaction ${response.transactionStatus.toString().toLowerCase()}",
//             isError: true);
//         notifyListeners();
//       }
//     } catch (e) {
//       logger.e('$e');
//       showToast(msg: e.toString(), isError: true);
//     }
//   }
//
//   ///Method to clear all data from controllers
//   void clearData() {
//     _createPinController.clear();
//     _confirmPinController.clear();
//     _otpController.clear();
//     notifyListeners();
//   }
//
//   Future<dynamic> createTransactionRecord(context,
//       {required String amount, required String paymentReference, required int userType}) async {
//     isCheckingTrx = true;
//     notifyListeners();
//
//     try {
//       await trxService
//           .createTrxRecord(amount: amount, paymentReference: paymentReference)
//           .then((value) async {
//         if (value != null) {
//           logger.w(value['status'] == true);
//           logger.w(value['message']);
//           if (value['status'] == true) {
//             SuccessScreen(
//                 infoText: value['message'].toString(),
//                 newPage: const DashBoardScreen(),
//                 navigateButtonText: continueText);
//             getAcctBalance(userType: userType);
//             navigateReplace(context, const DashBoardScreen());
//           } else {
//             ErrorScreen(
//                 infoText: value['message'].toString(),
//                 newPage: const DashBoardScreen(),
//                 navigateButtonText: continueText);
//           }
//         }
//       }).onError((error, stackTrace) {
//         logger
//           ..e(error)
//           ..e(stackTrace);
//         showToast(
//           msg: 'Something went wrong',
//           isError: true,
//         );
//         isCheckingTrx = false;
//         notifyListeners();
//       });
//     } catch (e) {
//       isCheckingTrx = false;
//       notifyListeners();
//       showToast(
//         msg: 'Something went wrong',
//         isError: true,
//       );
//       logger.e(e);
//     }
//   }
//
//   Future<void> createWithdrawalRequest(BuildContext context, {required String amount}) async {
//     isCreatingWithdrawalRequest = true;
//
//     // navigatePush(context,
//     //     const SuccessLoadingScreen(informationText: verifyingProperty));
//     notifyListeners();
//     try {
//       await trxService
//           .createWithdrawalRequest(amount: amount
//               // image: _image!,
//               )
//           .then((value) async {
//         if (value != null) {
//           // final decodedResponse = jsonDecode(value.toString());
//
//           if (value['status'] == true) {
//             showToast(
//               msg: value['message'].toString(),
//               isError: false,
//             );
//             isCreatingWithdrawalRequest = false;
//             await navigateReplace(
//                 context,
//                 SuccessScreen(
//                     infoText: value['message'],
//                     newPage: const DashBoardScreen(),
//                     navigateButtonText: continueText));
//             // await clearData();
//             notifyListeners();
//           } else if (value['status'] == true) {
//             showToast(
//               msg: value['message'].toString(),
//               isError: false,
//             );
//             // navigateBack(context);
//             isCreatingWithdrawalRequest = false;
//             notifyListeners();
//           }
//         }
//       }).whenComplete(() {
//         isCreatingWithdrawalRequest = false;
//         notifyListeners();
//       });
//     } catch (e, s) {
//       logger
//         ..i(checkErrorLogs)
//         ..e(s);
//     }
//   }
//
//   Future<void> rentProperty(
//     BuildContext context, {
//     // required String tenantId,
//     // required String landlordId,
//     required String listingId,
//     required String transactionType,
//   }) async {
//     // isCreatingWithdrawalRequest = true;
//     isRentingProperty = true;
//     _buttonPinState = CustomButtonState(
//       buttonState: ButtonState.loading,
//       text: login,
//     );
//
//     // navigatePush(context,
//     //     const SuccessLoadingScreen(informationText: verifyingProperty));
//     notifyListeners();
//     try {
//       await trxService
//           .rentAProperty(
//         listingId: listingId,
//         // tenantId: tenantId,
//         // landlordId: landlordId,
//         numberOfUnits: 1.toString(),
//         transactionType: transactionType,
//         accessToken: DummyData.accessToken!.toString(),
//         transactionPin: _pinCodeController.text,
//         renewalDate: getFutureRentRenewalDate(),
//       )
//           .then((value) async {
//         if (value != null) {
//           // final decodedResponse = jsonDecode(value.toString());
//
//           if (value['status'] == true) {
//             showToast(
//               msg: value['message'].toString(),
//               isError: false,
//             );
//             // isCreatingWithdrawalRequest = false;
//             isRentingProperty = false;
//             _buttonPinState = CustomButtonState(
//               buttonState: ButtonState.idle,
//               text: login,
//             );
//             await navigateReplace(
//                 context,
//                 SuccessScreen(
//                     infoText: value['message'],
//                     newPage: const DashBoardScreen(),
//                     navigateButtonText: continueText));
//             // await clearData();
//             notifyListeners();
//           } else if (value['status'] == true) {
//             showToast(
//               msg: value['message'].toString(),
//               isError: false,
//             );
//             // navigateBack(context);
//             // isCreatingWithdrawalRequest = false;
//             isRentingProperty = false;
//             _buttonPinState = CustomButtonState(
//               buttonState: ButtonState.idle,
//               text: login,
//             );
//             notifyListeners();
//           }
//         }
//       }).whenComplete(() {
//         // isCreatingWithdrawalRequest = false;
//         isRentingProperty = false;
//         _buttonPinState = CustomButtonState(
//           buttonState: ButtonState.idle,
//           text: login,
//         );
//         notifyListeners();
//       });
//     } catch (e, s) {
//       logger
//         ..i(checkErrorLogs)
//         ..e(s);
//     }
//   }
//
//   Future<void> fetchListingRentalRequest({required String? id}) async {
//     try {
//       await trxService.fetchListingRentalRequest(id: id.toString()).then((value) {
//         if (value != null) {
//           final decodedResponse = jsonDecode(value.toString());
//           if (decodedResponse['status'] == true) {
//             // var resBody = decodedResponse as Map<String, dynamic>;
//             // acctBalance = resBody['data']['balance'].toString();
//             notifyListeners();
//             // logger.t(acctBalance);
//           }
//         }
//       });
//     } catch (e) {
//       logger.e(e.toString());
//     }
//   }
//
//   // Future<void> checkTransactionPinState(BuildContext context) async {
//   //   try {
//   //     await trxService.checkTransactionPinState().then((value) async {
//   //       if (value != null) {
//   //         if (value['status'] == true) {
//   //           // logger.f(value);
//   //           _transactionPinStatus = TransactionPinStatus.fromJson(value);
//   //           isCreatingWithdrawalRequest = false;
//   //           notifyListeners();
//   //         } else if (value['status'] == true) {
//   //           showToast(
//   //             msg: value['message'].toString(),
//   //             isError: false,
//   //           );
//   //           // navigateBack(context);
//   //           isCreatingWithdrawalRequest = false;
//   //           notifyListeners();
//   //         }
//   //       }
//   //     }).whenComplete(() {
//   //       isCreatingWithdrawalRequest = false;
//   //       notifyListeners();
//   //     });
//   //   } catch (e, s) {
//   //     logger
//   //       ..i(checkErrorLogs)
//   //       ..e(s);
//   //   }
//   // }
//
//   void updateEnterPinButtonState() {
//     // _pinCode = value;
//     // notifyListeners();
//
//     if (_pinCodeController.text.length < 4) {
//       _buttonPinState = CustomButtonState(
//         buttonState: ButtonState.disabled,
//         text: login,
//       );
//     } else {
//       _buttonPinState = CustomButtonState(
//         buttonState: ButtonState.idle,
//         text: login,
//       );
//     }
//     notifyListeners();
//   }
//
//   String getFutureRentRenewalDate() {
//     DateTime currentDate = DateTime.now();
//     DateTime futureDate = currentDate.add(const Duration(days: 360));
//     // Format the future date in the desired format
//     String formattedFutureDate =
//         '${futureDate.year}-${_formatNumber(futureDate.month)}-${_formatNumber(futureDate.day)}';
//     return formattedFutureDate;
//     // print('Future date: $formattedFutureDate');
//   }
//
//   String _formatNumber(int number) {
//     // Add leading zero if number is less than 10
//     return number < 10 ? '0$number' : '$number';
//   }
// }
