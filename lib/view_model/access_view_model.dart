//
//
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tampay/config/app_strings.dart';
// import 'package:tampay/repository/backend/listings_backend.dart';
// import 'package:tampay/src/utils.dart';
//
// final accessViewModel = ChangeNotifierProvider((ref) => AccessViewModel());
//
// class AccessViewModel extends ChangeNotifier {
//
//   List<PListingsData> personalListings = [];
//   bool _canLoadMoreListings = true;
//   bool get canLoadMoreListings => _canLoadMoreListings;
//   PersonalListingsResponse? personalListingResponse;
//   int _listingPage = 2;
//   int get listingPage => _listingPage;
//   bool isGettingPersonalListings = true;
//   final listingService = ListingsBackend();
//
//   void _setCanLoadMoreListings({required bool status}) {
//     _canLoadMoreListings = status;
//     notifyListeners();
//   }
//
//   ///Method to get personal properties
//   Future<void> getPersonalProperties(
//       BuildContext context,
//   {required int role}
//       ) async {
//     try {
//       await listingService.fetchPersonalListingByRole( role: role).then((value) async {
//         if (value != null) {
//           final decodedResponse = jsonDecode(value.toString());
//
//           // if (decodedResponse['status'].toString() == 'true') {
//           //   // showToast(
//           //   //   msg: decodedResponse['message'].toString(),
//           //   //   isError: false,
//           //   // );
//           //
//           //   personalListings =
//           //       PersonalListingsResponse.fromJson(decodedResponse).data!.listings!.toList();
//           //
//           //   isGettingPersonalListings = false;
//           //   notifyListeners();
//           // }
//
//           if (decodedResponse['status'].toString() == 'true') {
//             personalListingResponse = PersonalListingsResponse.fromJson(decodedResponse);
//             personalListings = personalListingResponse!.data!.listings!.toList();
//             notifyListeners();
//             // check page count if its more than one, on every successful data fetch
//             _setCanLoadMoreListings(
//                 status: int.parse(personalListingResponse!.data!.lastPage.toString()) > 1);
//           }
//         }
//       }).whenComplete(() {
//         isGettingPersonalListings = false;
//         notifyListeners();
//       });
//     } catch (e, s) {
//       logger
//         ..i(checkErrorLogs)
//         ..e(s);
//     }
//   }
//
//   Future<dynamic> getMoreListings( {required int role}) async {
//     await listingService.fetchPersonalListingByRole(page: _listingPage, role: role).then((value) {
//       if (value != null) {
//         final decodedResponse = jsonDecode(value.toString());
//
//         if (decodedResponse['status'].toString() == 'true') {
//           personalListingResponse = PersonalListingsResponse.fromJson(decodedResponse);
//           personalListings.addAll(personalListingResponse!.data!.listings!.toList());
//           notifyListeners();
//           if (int.parse(personalListingResponse!.data!.lastPage.toString()) > _listingPage) {
//             _listingPage++;
//             _setCanLoadMoreListings(status: true);
//           } else {
//             _setCanLoadMoreListings(status: false);
//           }
//         }
//         // check page count if its more than one, on every successful data fetch
//         // update page count on every successful data fetch
//       }
//     }).onError((error, stackTrace) {
//       logger
//         ..e(error)
//         ..e(stackTrace);
//     });
//   }
//
//
// }