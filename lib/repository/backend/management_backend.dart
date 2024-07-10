import 'package:tampay/repository/services/api/api_service.dart';

class ManagementBackend extends ApiService {
  Future<dynamic> fetchBackgroundCheckStatus() async {
    return getMth(
      fetchBackgroundCheckUri,
      headers: apiHeaderWithToken,
      canShowToast: false
    );
  }
  Future<dynamic> fetchTenantTokenCheckStatus({required String listingId}) async {
    return getMth(
        fetchTenantTokenCheckStatusUri(listingId: listingId),
      headers: apiHeaderWithToken,
      canShowToast: false
    );
  }


  Future<dynamic> submitExistingTenantValidation({
    required String listingId,
  }) async {
    return postMth(
      existingVerificationUri,
      body: {
        "listingId": listingId,
      },
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> bgCheckPayment({
    required String listingId,
    required String numberOfTenants,
  }) async {
    return postMth(
      backgroundCheckPaymentUri,
      headers: apiHeaderWithToken,
      body: {
        "listingId": listingId,
        "numberOfTenants": int.parse(numberOfTenants),
      },
    );
  }


  Future<dynamic> generateListingTokenWithDate({
    required String listingId,
    required String noOfTenants,
  }) async {
    return postMth(
      generateTokenWithDateUri,
      headers: apiHeaderWithToken,
      body: {
        'listingId': listingId,
        'numberOfTenants': noOfTenants,
      },
    );
  }


  Future<dynamic> generateBgCheckToken({
    required String listingId,
    required String tenantId,

  }) async {
    return postMth(
      generateBgCheckTokenUri,
      headers: apiHeaderWithToken,
      body: {
        'listingId': listingId,
        'tenantId': tenantId,
      },
    );
  }



}
