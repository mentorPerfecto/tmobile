import 'dart:io';

import 'package:tampay/repository/services/api/api_service.dart';

class TransactionBackend extends ApiService {
  Future<dynamic> fetchTransactions({
    required int userType,
    int? page = 1,
  }) async {
    return getMth(
      trxHistoryUri( page: page.toString()),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> fetchAcctBalance({required int userType}) async {
    return getMth(walletBalanceUri, headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> setTransactionPin({
    required String pin,
  }) async {
    return postMth(
      setTransactionPinUri,
      headers: apiHeaderWithToken,
      body: {
        'pin': pin,
      },
    );
  }

  Future<dynamic> createTrxRecord({
    required String amount,
    required String paymentReference,
  }) async {
    return postMth(
      createTrxRecordUri,
      headers: apiHeaderWithToken,
      body: {"amount": amount, "paymentReference": paymentReference},
    );
  }

  Future<dynamic> resetTransactionPin({
    required String newPin,
    required String otp,
  }) async {
    return postMth(
      resetTransactionPinUri,
      headers: apiHeaderWithToken,
      body: {
        'newPin': newPin,
        'otp': otp,
      },
    );
  }

  // Future<dynamic> checkTransactionPinState() async {
  //   return postMth(
  //     checkTransactionPinStateUri,
  //     headers: apiHeaderWithToken,
  //     body: {
  //       // 'newPin': '1234',
  //       // 'otp': otp,
  //     },
  //   );
  // }

  Future<dynamic> createWithdrawalRequest({
    required String amount,
  }) async {
    return postMth(
      createWithdrawalRequestUri,
      headers: apiHeaderWithToken,
      body: {
        "amount": amount,
      },
    );
  }

  Future<dynamic> rentAProperty(
      {
      // required String tenantId,
      // required String landlordId,
      required String listingId,
      required String numberOfUnits,
      required String transactionType,
      required String renewalDate,
      required String accessToken,
      required String transactionPin}) async {
    return postMth(
      rentAPropertyUri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'x-transaction-pin': transactionPin
      },
      body: {
        // "tenantId": tenantId,

        // "landlordId": landlordId,
        "listingId": listingId,
        "numberOfUnits": 1,
        "transactionType": transactionType,
        "renewalDate": renewalDate
        // "renewalDate": "2025-02-03"
      },
    );
  }

  Future<dynamic> fetchListingRentalRequest({required String id}) async {
    return getMth(
      fetchListingRentalRequestUri(id: id),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> fetchListingAccessRequest({required String listingId}) async {
    return getMth(
      fetchListingAccessRequestUri(id: listingId),
      headers: apiHeaderWithToken,
    );
  }
  //
  // Future<dynamic> approveOrRejectListingTransactionRequest({
  //   required String transactionId,
  //   required String status,
  // }) async {
  //   return postMth(
  //     approveOrRejectListingTransactionRequestUri,
  //     headers: apiHeaderWithToken,
  //     body: {"transactionId": transactionId, "status": status},
  //   );
  // }

 Future<dynamic> approveOrRejectListingAccessRequest({
    required String transactionId,
    required String status,
    required String? amount,
    required String? roomNumber,
    required String startDate,
    required String endDate,
  }) async {
    return postMth(
      approveOrRejectListingAccessRequestUri,
      headers: apiHeaderWithToken,
      body:  status == 'reject' ? {
        "transactionId": transactionId, "status": status,
      }:

      {"transactionId": transactionId, "status": status,
        'amount': amount,
        'roomNumber': roomNumber,
        'startDate': startDate,
        'endDate': endDate
      },
    );
  }



 Future<dynamic> editTenancyInfo({
    required String transactionId,
    required String amount,
    required String roomNumber,
    required String startDate,
    required String endDate,
  }) async {
    return putMth(
      editTenancyInfoUri,
      headers: apiHeaderWithToken,
      body: {"transactionId": transactionId,
        'amount': amount,
        'roomNumber': roomNumber,
        'startDate': startDate,
        'endDate': endDate
      },
    );
  }


 Future<dynamic> removeTenant({
    required String transactionId,
    required String tenantId,

  }) async {
    return deleteMth(
      removeTenantUri,
      headers: apiHeaderWithToken,
      body: {
        "transactionId": transactionId,
        'tenantId': tenantId,
      },
    );
  }



}
