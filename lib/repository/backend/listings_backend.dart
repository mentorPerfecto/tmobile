import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tampay/repository/services/api/api_service.dart';

class ListingsBackend extends ApiService {
  Future<dynamic> fetchListings({
    String? listingType,
    int? page = 1,
    String? minPrice,
    String? maxPrice,
    String? minBathrooms,
    String? maxBathrooms,
    String? maxBedrooms,
    String? minBedrooms,
    String? propertyType,
    String? city,
    String? state,
    String? address,
    String? title,
  }) async {
    return getMth(
      fetchListingsUri(
        page: page.toString(),
        listingType: listingType,
        minPrice: minPrice,
        minBathrooms: minBathrooms,
        maxBathrooms: maxBathrooms,
        maxBedrooms: maxBedrooms,
        minBedrooms: minBedrooms,
        propertyType: propertyType,
        city: city,
        address: address,
        state: state,
        title: title,
      ),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> fetchSingleListing({required String id}) async {
    return getMth(
      fetchSingleListingUri(id: id),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> fetchSingleListingWithCode({required String code}) async {
    return getMth(
      fetchSingleListingWithCodeUri(code: code),
      headers: apiHeaderWithToken,
      canShowToast: true,
    );
  }

  Future<dynamic> deleteListing({required String id}) async {
    return deleteMth(
      deleteListingUri(id: id),
      headers: apiHeaderWithToken,
    );
  }
  Future<dynamic> freezeOrUnfreezeListing({required String listingId}) async {
    return putMth(
      freezeOrUnfreezeListingUri(id: listingId),
      headers: apiHeaderWithToken,
      body: {
        '':''
      }
    );
  }

  Future<dynamic> fetchPersonalListing({
    int? page = 1,
  }) async {
    return getMth(
      fetchPersonalListingUri(page: page.toString()),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> fetchPersonalListingByRole({
    int? page = 1,
   required int role,
  }) async {
    return getMth(
      fetchListingByRoleUri(page: page.toString(), role: role.toString()),
      headers: apiHeaderWithToken,
    );
  }
  Future<dynamic> fetchPersonaUnverifiedListing({
    int? page = 1,
  }) async {
    return getMth(
      fetchPersonalUnverifiedListingUri(page: page.toString()),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> viewTenants() async {
    return getMth(
      viewTenantsUri,
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> viewTenantsByListingId({required String id}) async {
    return getMth(
      viewTenantsByListingIdUri(id: id),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> requestAccessToListing({required String listingId, required String tokenValue}) async {
    return postMth(
      requestAccessToListingUri,
      headers: apiHeaderWithToken,
      body: {
        'listingId': listingId,
        'tokenValue': tokenValue
      },
    );
  }

  Future<dynamic> createNewListing(
      {
      // required File image,
      required List<File?>? images,
      required String title,
      required String address,
      required String city,
      File? propertyDocument,
      required List<String> amenities,
      List<Map<String, dynamic>>? fees,
      // required String country,
      String? tags,
      required String listingType,
      required String propertySize,
      required String propertyType,
      required String description,
      required String? paymentPlan,
      required String state,
      required double price,
      required int totalUnits,
      required int availableUnits,
      required int parkInDuration,
      // required bool undertampayContract,
      // required String propertyContractType,
      int? bedrooms,
      int? bathrooms}) async {
    List<MultipartFile>? fileItems = [];

    if (images != null) {
      for (File? file in images) {
        if (file != null) {
          String fileName = file.path.split('/').last;
          fileItems.add(await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ));
        }
      }
    }
    String jsonFees = jsonEncode(fees);
    return uploadMth(
      createNewListingUri,
      data: propertyDocument != null?  FormData.fromMap({
        'title': title,
        'address': address,
        'description': description,
        'city': city,
        'state': state,
        'country': 'Nigeria',
        'tags': ['Gym', 'Wi-Fi'],
        'listingType': listingType.isNotEmpty ? listingType : 'rent',
        'propertyType': propertyType,
        'propertySize': propertySize,
        'price': price,
        'totalUnits': totalUnits,
        'availableUnits': availableUnits,
        // availableUnits,
        "amenities[]": amenities,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "paymentPlan": paymentPlan,
        // != 'one-time' ? paymentPlan:'one-time',
        "fee": jsonFees,
        'images': fileItems,
        'parkInDuration': parkInDuration,
      //  'propertyDocument': propertyDocument,
        // 'undertampayContract': undertampayContract,
        // 'propertyContractType': propertyContractType
        // 'parkInDate': '2024-05-05'
        'propertyDocument': await MultipartFile.fromFile(propertyDocument.path, filename: "propertyDocument.png"),
        // "agreedPercentage":null,
        // "durationOfManagement":null,
        // "propertyContractType":null,
        // "propertyCategory":null,
        // "propertySubcategory":null,
        // "rules":null,
        // "tenancyAgreement":null,
      }) :FormData.fromMap({
        'title': title,
        'address': address,
        'description': description,
        'city': city,
        'state': state,
        'country': 'Nigeria',
        'tags': ['Gym', 'Wi-Fi'],
        'listingType': listingType.isNotEmpty ? listingType : 'rent',
        'propertyType': propertyType,
        'propertySize': propertySize,
        'price': price,
        'totalUnits': totalUnits,
        'availableUnits': availableUnits,
        // availableUnits,
        "amenities[]": amenities,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "paymentPlan": paymentPlan,
        // != 'one-time' ? paymentPlan:'one-time',
        "fee": jsonFees,
        'images': fileItems,
        'parkInDuration': parkInDuration,
      }),
      headers: apiHeaderWithToken,
    );
  }

  Future<dynamic> updateListing(
      {
      required List<File?>? images,
      required String title,
      required String address,
      required String city,
      required List<dynamic> amenities,
      // List<Map<String, dynamic>>? fees,
      // required String country,
      // String? tags,
      // required String listingType,
      // required String propertySize,
      // required String propertyType,
      required String description,
      // required String? paymentPlan,
      required String state,
      required double price,
      // required int totalUnits,
      // required int availableUnits,
      // required int parkInDuration,
      // int? bedrooms,
      // int? bathrooms,
      required String id}) async {
    List<MultipartFile>? fileItems = [];

    if (images != null) {
      for (File? file in images) {
        if (file != null) {
          String fileName = file.path
              .split('/')
              .last;
          fileItems.add(await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ));
        }
      }

      // String jsonFees = jsonEncode(fees);
      return putMth(
          updateListingUri(id: id), headers: apiHeaderWithToken, body: {
        'title': title,
        'address': address,
        'description': description,
        'city': city,
        'state': state,
        'country': 'Nigeria',
        'tags': ['Gym', 'Wi-Fi'],
        // 'listingType': listingType.isNotEmpty ? listingType : 'rent',
        // 'propertyType': propertyType,
        // 'propertySize': propertySize,
        'price': price,
        // 'totalUnits': totalUnits,
        // 'availableUnits': availableUnits,
        "amenities[]": amenities,
        // "bedrooms": bedrooms,
        // "bathrooms": bathrooms,
        // "paymentPlan": paymentPlan,
        // != 'one-time' ? paymentPlan:'one-time',
        // "fee": jsonFees,
        'images': fileItems,
        // 'parkInDuration': parkInDuration,
      });
    }
  }


  Future<dynamic> fetchListingImage({required String uri}) async {
    return getMth(
      Uri.parse(uri),
      headers: apiHeaderWithToken,
    );
  }
}
