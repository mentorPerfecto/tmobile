import 'dart:io';

import 'package:tampay/config/app_configs.dart';
import 'package:tampay/model/local/dummy_data.dart';

// https://musicalminds-be.onrender.com
class ApiConstants {
  // final persist = Persist();
  final String scheme = 'https';
  final String host = apiUrlHost!;
  final int receiveTimeout = 3000;
  final int sendTimeout = 2000;
  final String googlePlacesApiKey = "AIzaSyBmmJDKJshf79zx5eh71HwC7DaXep7s1LI";
  // final String apiVersion = '/v1';

  // final api = 'api';
  final version = 'v1';
  final authPath = 'auth';
  final userPath = 'user';

  Uri get signUpUri => Uri(
      scheme: scheme, host: host, path: '$version/$authPath/$userPath/signup');

  Uri get loginUri => Uri(
      scheme: scheme, host: host, path: '$version/$authPath/$userPath/signin');

  Uri get sendOTPUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/send-otp');

  // Uri get changePasswordUri =>
  //     Uri(scheme: scheme, host: host, path: '$version/$authPath/$userPath/change-password');

  Uri get verifyEmailUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/verify-email');

  Uri get resetPasswordUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/reset-password');
  Uri get changePasswordUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/change-password');

  Uri get getProfileUri =>
      Uri(scheme: scheme, host: host, path: '$version/profile/user');

  // Uri get fetchListingsUri => Uri(scheme: scheme, host: host, path: '$version/listing/user');
  //
  //

  Uri fetchListingsUri({
    required String page,
    String? listingType,
    String? minPrice,
    String? maxPrice,
    String? minBathrooms,
    String? maxBathrooms,
    String? maxBedrooms,
    String? minBedrooms,
    String? propertyType,
    String? city,
    String? address,
    String? state,
    String? title,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user',
        queryParameters: {
          'limit': '5',
          'page': page,
          'listingType': listingType,
          'minPrice': minPrice ?? '',
          'maxPrice': maxPrice ?? '',
          'minBathrooms': minBathrooms ?? '',
          'maxBathrooms': maxBathrooms ?? '',
          'maxBedrooms': maxBedrooms ?? '',
          'minBedrooms': minBedrooms ?? '',
          'propertyType': propertyType ?? '',
          'city': city ?? '',
          'address': address ?? '',
          'state': state ?? '',
          'title': title ?? '',
        },
      );

  // Uri fetchSearchListingsUri({
  //   required String page,
  //   required String listingType,
  // }) =>
  //     Uri(
  //       scheme: scheme,
  //       host: host,
  //       path: '$version/listing/user',
  //       queryParameters: {
  //         'limit': '10',
  //         'page': page,
  //         'listingType': listingType,
  //       },
  //     );

  // Uri fetchPersonalListingUri({
  //   required String page,
  // }) =>
  //     Uri(
  //       scheme: scheme,
  //       host: host,
  //       path: '$version/listing/user/my-listings',
  //       queryParameters: {
  //         'limit': '10',
  //         'page': page,
  //       },
  //     );

  Uri fetchPersonalListingUri({
    required String page,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/my-listings',
        queryParameters: {
          'limit': '10',
          'page': page,
          'status': 'verified'
        },
      );

  Uri fetchPersonalUnverifiedListingUri({
    required String page,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/my-listings',
        queryParameters: {
          'limit': '10',
          'page': page,
          'status': 'unverified'
        },
      );

  Uri fetchListingByRoleUri({
    required String page,
    required String role,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/listings-by-role',
        queryParameters:    role != "2" ?
        {
          'limit': '10',
          'page': page,
          'role': role,
        } :
        {
          'limit': '10',
          'page': page,
          'role': role,
          'status': "verified",
        },
      );

  Uri get createNewListingUri =>
      Uri(scheme: scheme, host: host, path: '$version/listing/user');

  // Uri get submitKYCUri =>
  //     Uri(scheme: scheme, host: host, path: '$version/kyc/$userPath/submit');
  //
  // Uri get fetchKYCStatusUri =>
  //     Uri(scheme: scheme, host: host, path: '$version/kyc/$userPath/status');

  Uri get createTrxRecordUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/user/create-record');

  Uri get updateUserProfileUri =>
      Uri(scheme: scheme, host: host, path: '$version/profile/user');
  Uri get deleteUserProfileUri =>
      Uri(scheme: scheme, host: host, path: '$version/profile/user');
  Uri get setTransactionPinUri => Uri(
      scheme: scheme, host: host, path: '$version/$authPath/$userPath/set-pin');
  Uri get resetTransactionPinUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/reset-pin');
  Uri get switchUserRoleUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/$authPath/$userPath/switch-role');

  Uri get addBankAccountNumberUri =>
      Uri(scheme: scheme, host: host, path: '$version/payment/user/add-bank');

  Uri get fetchAllBanksUri =>
      Uri(scheme: scheme, host: host, path: '$version/payment/user/banks');
  // Uri get checkTransactionPinStateUri =>
  //     Uri(scheme: scheme, host: host, path: '$version/auth/user/is-pin-set');

  Uri get validateCustomerBankAccountUri => Uri(
      scheme: scheme, host: host, path: '$version/payment/user/validate-bank');

  Uri get fetchLandlordsBankAccountDetailsUri => Uri(
      scheme: scheme, host: host, path: '$version/payment/user/bank-details');
  // Uri get sendFundToAnotherWalletUri => Uri(scheme: scheme, host: host, path: '$version/transaction/user/transfer');

  Uri get deleteBankAccountNumberUri => Uri(
      scheme: scheme, host: host, path: '$version/payment/user/delete-bank');
  Uri get createWithdrawalRequestUri =>
      Uri(scheme: scheme, host: host, path: '$version/withdrawal/landlord');
  Uri get rentAPropertyUri =>
      Uri(scheme: scheme, host: host, path: '$version/transaction/listing');
  Uri get viewTenantsUri => Uri(
      scheme: scheme, host: host, path: '$version/misc/landlord/view-tenants');

  Uri get approveOrRejectListingTransactionRequestUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/landlord/listing/approve-reject');


  Uri get approveOrRejectListingAccessRequestUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/user/listing/access-requests/approve-reject');


  Uri get editTenancyInfoUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/user/listing/edit-tenancy-info');


  Uri get removeTenantUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/user/listing/remove-tenant');

  Uri get backgroundCheckPaymentUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/user/background-check');


Uri get extendedValidationUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/listing/user/extended-validation')


;Uri get tenantVerificationUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/listing/user/tenant-verification');

Uri get existingVerificationUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/listing/user/existing-verification');



  Uri get requestAccessToListingUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/transaction/listing/request-access');
  Uri get generateTokenWithDateUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/listing/$userPath/generate-tokens');


  Uri get generateBgCheckTokenUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/misc/landlord/background-check/generate-tokens');


  Uri get fetchBackgroundCheckUri => Uri(
      scheme: scheme,
      host: host,
      path: '$version/misc/landlord/background-check');
  Uri get walletBalanceUri =>  Uri(scheme: scheme, host: host, path: '$version/wallet/user/balance');

  Uri trxHistoryUri({
    required String page,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path:
            '$version/transaction/user/history',
        queryParameters: {
          'limit': '20',
          'page': page,
        },
      );

  Uri fetchTenantTokenCheckStatusUri({
    required String listingId,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path:
            '$version/listing/user/tokens/$listingId',
      );

  Uri fetchSingleListingUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/$id',
      );

  Uri fetchSingleListingWithCodeUri({
    required String code,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/code/$code',
      );

  Uri viewTenantsByListingIdUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/misc/landlord/view-tenants/$id',
      );

  Uri fetchListingRentalRequestUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/transaction/user/listing/$id',
      );
  Uri fetchListingAccessRequestUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/transaction/user/listing/access-requests/$id',
      );

  Uri updateListingUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/$id',
      );

  Uri deleteListingUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/$id',
      );

  Uri freezeOrUnfreezeListingUri({
    required String id,
  }) =>
      Uri(
        scheme: scheme,
        host: host,
        path: '$version/listing/user/freeze/$id',
      );

  //
  // Uri  getEmployersUri ({ required String page, required String searchString}) => Uri(
  //   scheme: scheme,
  //   host: host,
  //   path: 'ew-admin/organization',
  //   queryParameters: {'limit': '20', 'page': page, 'search': searchString},
  // );
  //

  // static final token = Provider((ref) => ref.watch(regViewModelProvider).token);
//*! can be modified
  Map<String, String> apiHeader = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: '*/*',
  };

  Map<String, String> apiHeaderWithToken = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: '*/*',
    HttpHeaders.authorizationHeader: DummyData.accessToken != null ? 'Bearer ${DummyData.accessToken}': "",
  };

  var termsOfSServicesUrl = 'https://gettampay.com/terms-of-service';
  var privacyPolicyUrl = 'https://gettampay.com/privacy-policy';
  var faqsUrl = 'https://gettampay.com/faqs';
  var aboutUrl = 'https://gettampay.com/about';

  // Map<String, String> apiHeaderWithToken(String token) {
  //   return {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  // }
}
