// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rebirth/rebirth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/repository.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final profileViewModel = ChangeNotifierProvider((ref) => ProfileViewModel());

class ProfileViewModel extends ChangeNotifier {
  final TextEditingController _verifyDOBController = TextEditingController();
  CustomButtonState _verifyDOBButtonState =
      CustomButtonState(buttonState: ButtonState.disabled, text: continueText);
  final TextEditingController _bvnNumberController = TextEditingController();
  CustomButtonState _verifyBVNButtonState =
      CustomButtonState(buttonState: ButtonState.disabled, text: verify);
  TextEditingController get bvnNumberController => _bvnNumberController;
  TextEditingController get verifyDOBController => _verifyDOBController;
  CustomButtonState get verifyDOBButtonState => _verifyDOBButtonState;
  CustomButtonState get verifyBVNButtonState => _verifyBVNButtonState;
  
  void updateSelectedDate(DateTime? picked) {
    DummyData.userDateOfBirth = picked;
    if (DummyData.userDateOfBirth != null) {
      _verifyDOBController.text = DateFormat('dd/MM/yyyy').format(DummyData.userDateOfBirth!);
    }
    notifyListeners();
    //TODO: Store the DummyDate.userDateOfBirth locally using shared preferences.
  }
  void updateVerifyBVNButtonState() {
    if (_bvnNumberController.text.isNotEmpty) {
      _verifyBVNButtonState = CustomButtonState(buttonState: ButtonState.idle, text: verify);
    } else {
      _verifyBVNButtonState = CustomButtonState(buttonState: ButtonState.disabled, text: verify);
    }
    notifyListeners();
  }
  void updateVerifyDOBButtonState() {
    if (_verifyDOBController.text.isNotEmpty) {
      _verifyDOBButtonState = CustomButtonState(buttonState: ButtonState.idle, text: continueText);
    } 
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  final profileService = ProfileBackend();
  final banksService = BankBackend();

  List<File?> driversLicenseFrontAndBckImage = [];
  List<File?> imageFrontAndBckImage = [];
  List<LandlordBankData> _landLordWithdrawalBanks = [];
  List<LandlordBankData> get landLordWithdrawalBanks => _landLordWithdrawalBanks;
  bool _isFetchingBanks = false;

  CustomButtonState _buttonSaveBankDetailsState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: createAccount,
  );

  CustomButtonState get buttonSaveBankDetailsState => _buttonSaveBankDetailsState;

  bool get isFetchingBanks => _isFetchingBanks;
  List<String> genderType = ['Male', "Female"];

  KycResponseStatus? kycResponseStatus;

  bool isFetchingProfile = false;
  bool _isSubmittingKYC = false;
  bool get isSubmittingKYC => _isSubmittingKYC;

  bool isDeletingBankAccountDetails = false;
  CustomButtonState _buttonSubmitKYCState = CustomButtonState(
    buttonState: ButtonState.idle,
    text: login,
  );

  TextEditingController _documentNumberController = TextEditingController();
  TextEditingController get nextOfKinFirstNameController => _nextOfKinFirstNameController;
  final TextEditingController _nextOfKinFirstNameController = TextEditingController();
  final TextEditingController _nextOfKinLastNameController = TextEditingController();
  final TextEditingController _nextOfKinPhoneNoController = TextEditingController();
  final TextEditingController _nextOfKinEmailController = TextEditingController();
  final TextEditingController _nextOfKinRelationController = TextEditingController();
  final TextEditingController _driverLicenseController = TextEditingController();
  final TextEditingController _ninLicenseController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _validatePasswordControllers = TextEditingController();
  TextEditingController get validatePasswordControllers => _validatePasswordControllers;
  final TextEditingController _firstNameController =
      TextEditingController(text: DummyData.firstName ?? '');
  final TextEditingController _lastNameController =
      TextEditingController(text: DummyData.lastName ?? '');
  final TextEditingController _emailAddressController =
      TextEditingController(text: DummyData.emailAddress ?? '');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: DummyData.phoneNumber ?? '');

  final bvnFormKey = GlobalKey<FormState>();
  final driverFormKey = GlobalKey<FormState>();
  final ninFormKey = GlobalKey<FormState>();
  final intlPassportFormKey = GlobalKey<FormState>();

  final nokFormKey = GlobalKey<FormState>();

  final bool _validatePassword = true;
  bool get validatePassword => _validatePassword;
  bool _showBanks = false;
  bool get showBanks => _showBanks;
  bool _isLoadingVerifiedBanks = false;
  bool get isLoadingVerifiedBanks => _isLoadingVerifiedBanks;
  String _accountName = accountNameText;
  String? _bankName;
  String? _bankCode;
  String? _gender;

  String? get gender => _gender;
  UserResponseModel? _profileData;

  UserResponseModel? get profileData => _profileData;
  File? driversLicenceImageFront;
  File? driversLicenceImageBack;

  File? ninImageFront;
  File? ninImageBack;

  File? intlPassportImageFront;
  File? intlPassportImageBack;

  File? proofOfOwnership;

  List<String> identificationType = [
    bvn,
    driversLicense,
    nin,
    internationalPassport,
  ];

  List<Map<String, dynamic>> identificationTypeNew = [
    {
      'title': bvn,
      'id': bvnCamelCase,
    },
    {
      'title': driversLicense,
      'id': driversLicenseCamelCase,
    },
    {
      'title': nin,
      'id': ninCamelCase,
    },
    {
      'title': internationalPassport,
      'id': intlPassportCamelCase,
    },
  ];

  String? _documentType;
  String? get documentType => _documentType;
  String get accountName => _accountName;
  String? get bankName => _bankName;
  String? get bankCode => _bankCode;
  TextEditingController get accountNumberController => _accountNumberController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get documentNumberController => _documentNumberController;
  TextEditingController get driverLicenseController => _driverLicenseController;
  TextEditingController get ninLicenseController => _ninLicenseController;
  CustomButtonState get buttonSubmitKYCState => _buttonSubmitKYCState;
  bool isBankAccountNumberAdded = false;
  BankAccountValidatedResponse? validatedUserResponse;
  BanksData? userBankData;

  bool _isUpdatingUserProfile = false;
  bool get isUpdatingUserProfile => _isUpdatingUserProfile;

  bool _isAddingBankDetails = false;
  bool get isAddBankDetails => _isAddingBankDetails;

  bool _isFetchingLandlordBanks = true;
  List<BanksData> _listOfBanks = [];
  List<BanksData> get bankList => _listOfBanks;

  double _uploadProgress = 0.0;
  bool _showUploadIndicator = false;

  double get uploadProgress => _uploadProgress;
  bool get showUploadIndicator => _showUploadIndicator;

  String? validateInput() {
    if (_documentNumberController.text.length >= 8) {
      return 'Must be 11 digits';
    } else {}

    notifyListeners();
    return null;
  }

  changeIdType(String? value) {
    _documentType = value!;
    validateInput();
    notifyListeners();
  }

  getGender(String? value) {
    _gender = value!;
    notifyListeners();
  }

  void newBankName(String newBankName) {
    _bankName = newBankName;

    notifyListeners();
  }

  void getBankCode(String bank) {
    for (int i = 0; i <= _listOfBanks.length - 1; i++) {
      if (bank == _listOfBanks[i].name) {
        _bankCode = _listOfBanks[i].code;
        notifyListeners();
      }
    }
  }

  void changeShowBanks(bool value) {
    _showBanks = value;
    logger.t(_showBanks);
    notifyListeners();
  }

  void copyToClipBoard(context, {required String value}) {
    Clipboard.setData(
      ClipboardData(text: value.toString()),
    );
    showToast(msg: "Copied '$value' to clipboard", isError: false);
  }

  ///Method to update user profile
  Future<void> updateUserProfile(BuildContext context, showContactInfo) async {
    _isUpdatingUserProfile = true;
    notifyListeners();
    try {
      await profileService
          .updateUserProfile(
        firstname: _firstNameController.text.toString(),
        lastName: _lastNameController.text.toString(),
        phoneNumber: _phoneNumberController.text.toString(),
        gender: UtilFunctions.capitalizeAllWord(_gender ?? profileData!.gender.toString()),
        showContactInfo: showContactInfo ?? profileData!.showContactInfo,
      )
          .then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());

          if (decodedResponse['status'].toString() == 'true') {
            showToast(
              msg: decodedResponse['message'].toString(),
              isError: false,
            );
            _isUpdatingUserProfile = false;
            notifyListeners();
          } else if (value['status'].toString() == 'false') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
            _isUpdatingUserProfile = false;
            notifyListeners();
          }
        }
      }).whenComplete(() {
        _isUpdatingUserProfile = false;
        notifyListeners();
      });
    } catch (e, s) {
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

//Method to delete user profile.
  Future<void> deleteUserProfile(BuildContext context) async {
    try {
      _isUpdatingUserProfile = true;
      notifyListeners();
      await profileService.deleteProfile().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());

          if (decodedResponse['status'].toString() == 'true') {
            _validatePasswordControllers.clear();
            showToast(
              msg: decodedResponse['message'].toString(),
              isError: false,
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('Email');
            await prefs.remove('Password');
            await prefs.remove('accessToken');
            await Future.delayed(const Duration(seconds: 2));

            WidgetRebirth.createRebirth(context: context);

            _isUpdatingUserProfile = false;
            notifyListeners();
          } else if (value['status'].toString() == 'false') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );

            _isUpdatingUserProfile = false;
            notifyListeners();
          }
        }
      }).whenComplete(() {
        _isUpdatingUserProfile = false;
        notifyListeners();
      });
    } catch (e, s) {
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  ///Method for fetching user banks.
  Future<dynamic> fetchAllNigerianBanks() async {
    _isFetchingBanks = true;
    try {
      await banksService.fetchAllBanks().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());
          if (decodedResponse['status'].toString() == 'true') {
            var resBody = decodedResponse as Map<String, dynamic>;
            _listOfBanks =
                (resBody["data"]["data"]).map<BanksData>((e) => BanksData.fromJson(e)).toList();
          }

          _isFetchingBanks = false;
          notifyListeners();
        }
      }).onError((error, stackTrace) {
        logger
          ..e(error)
          ..e(stackTrace);
      });
    } catch (e) {
      logger.e(e);
    }
  }

  ///Method to add user bank account number
  Future<void> addUserAccountNumber(BuildContext context) async {
    _isAddingBankDetails = true;
    notifyListeners();
    try {
      _buttonSaveBankDetailsState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: createAccount,
      );
      notifyListeners();
      await banksService
          .addBankAccountNumber(
        accountNumber: _accountNumberController.text.toString(),
        accountName: _accountName,
        bankName: _bankName ?? "",
        bankCode: _bankCode ?? "",
      )
          .then((value) async {
        if (value != null) {
          // final decodedResponse = jsonDecode(value.toString());

          if (value['status'].toString() == 'true') {
            // showToast(
            //   msg: value['message'].toString(),
            //   isError: false,
            // );

            _isAddingBankDetails = false;
            await fetchLandlordsBanks();
            navigateBack(context);
            _buttonSaveBankDetailsState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: createAccount,
            );
            notifyListeners();
          } else if (value['status'].toString() == 'false') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
            _isAddingBankDetails = false;
            _buttonSaveBankDetailsState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: createAccount,
            );
            notifyListeners();
          }
        }
      }).whenComplete(() {
        _isAddingBankDetails = false;
        _buttonSaveBankDetailsState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: createAccount,
        );
        notifyListeners();
      });
    } catch (e, s) {
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  ///Method for fetching landlords withdrawal banks.
  Future<dynamic> fetchLandlordsBanks() async {
    try {
      await banksService.fetchLandlordsBanks().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());

          if (decodedResponse['status'].toString() == 'true') {
            _landLordWithdrawalBanks =
                (decodedResponse['data'] as List).map((e) => LandlordBankData.fromJson(e)).toList();

            _isFetchingLandlordBanks = false;

            logger.f(_landLordWithdrawalBanks);
            notifyListeners();
          }
          _isFetchingLandlordBanks = false;
          notifyListeners();
        }
      }).onError((error, stackTrace) {
        logger
          ..e(error)
          ..e(stackTrace);
      });
    } catch (e) {
      logger.e(e);
    }
  }

  ///Method for validating user banks.
  Future<dynamic> validateUserBankAccount() async {
    _isLoadingVerifiedBanks = true;
    _buttonSaveBankDetailsState = CustomButtonState(
      buttonState: ButtonState.disabled,
      text: login,
    );
    notifyListeners();
    try {
      await banksService
          .validateCustomerBankAccount(
        accountNumber: _accountNumberController.text.toString(),
        bankCode: _bankCode ?? "",
      )
          .then((value) async {
        if (value != null) {
          if (value['data']['status'].toString() == 'true') {
            validatedUserResponse = BankAccountValidatedResponse.fromJson(value['data']['data']);
            _accountName = validatedUserResponse!.accountName!;
            _buttonSaveBankDetailsState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: login,
            );
            notifyListeners();
            showToast(
              msg: value['data']['message'].toString(),
              isError: false,
            );
          } else if (value['data']['status'].toString() == 'false') {
            showToast(
              msg: value['data']['message'].toString(),
              isError: true,
            );
            _accountName = accountNameNotFound.toUpperCase();
            _buttonSaveBankDetailsState = CustomButtonState(
              buttonState: ButtonState.disabled,
              text: login,
            );
            notifyListeners();
          }
          _isLoadingVerifiedBanks = false;
          notifyListeners();
        }
      }).onError((error, stackTrace) => null);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deleteBankAccountDetails(
    BuildContext context,
  ) async {
    try {
      isDeletingBankAccountDetails = true;
      notifyListeners();
      await banksService.deleteBankAccountNumber().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());

          if (decodedResponse['status'].toString() == 'true') {
            fetchLandlordsBanks();
            // validatePasswordControllers.clear();
            showToast(
              msg: decodedResponse['message'].toString(),
              isError: false,
            );
            // await getPersonalProperties(context);
            // await getAllProperties(context);
            isDeletingBankAccountDetails = false;
            // await navigateReplace(context, const DashBoardScreen());
            notifyListeners();
          }
        }
      }).whenComplete(() {
        isDeletingBankAccountDetails = false;
        fetchLandlordsBanks();
        notifyListeners();
      });
    } catch (e, s) {
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  ///Method for Submitting KYC
  Future<void> submitExtendedValidation(BuildContext context, listingId) async {
    _isSubmittingKYC = true;
    try {
      _buttonSubmitKYCState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: login,
      );
      notifyListeners();
      await profileService
          .submitExtendValidation(
        listingId: listingId,
        attachments: proofOfOwnership,
      )
          .then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());
          logger.t(decodedResponse['status'] == true);
          if (decodedResponse['status'] == true) {
            await navigateReplace(
                context,
                SuccessScreen(
                    infoText: decodedResponse['message'].toString(),
                    newPage: const DashBoardScreen(
                      setIndex: 2,
                    ),
                    navigateButtonText: continueText));

            clearKYCData();
            _buttonSubmitKYCState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: login,
            );
            _isSubmittingKYC = false;
            notifyListeners();
            // fetchKYC(context);
          } else {
            _isSubmittingKYC = false;

            showToast(
              msg: decodedResponse['message'].toString(),
              isError: false,
            );
          }

          notifyListeners();
        }
      }).whenComplete(() async {
        _isSubmittingKYC = false;

        _buttonSubmitKYCState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: login,
        );
        // fetchKYC(context);
        notifyListeners();
      });
    } catch (e, s) {
      // showToast(
      //   msg: somethingWentWrong,
      //   isError: true,
      // );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  Future<void> submitKYC(BuildContext context, listingId, token) async {
    _isSubmittingKYC = true;
    try {
      _buttonSubmitKYCState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: login,
      );
      notifyListeners();
      await profileService
          .submitKYC(
              fullName: '${DummyData.lastName} ${DummyData.firstName}',
              documentType: _documentType.toString(),
              attachments: imageFrontAndBckImage,
              documentNumber: _documentNumberController.text.toString(),
              listingId: listingId,
              token: token,
              nextOfKinFirstName: _nextOfKinFirstNameController.text.toString(),
              nextOfKinLastName: _nextOfKinLastNameController.text.toString(),
              nextOfKinPhoneNumber: _nextOfKinPhoneNoController.text.toString(),
              nextOfKinEmail: _nextOfKinEmailController.text.toString(),
              nextOfKinRelationship: _nextOfKinRelationController.text.toString())
          .then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());
          logger.t(decodedResponse['status'] == true);
          if (decodedResponse['status'] == true) {
            if (decodedResponse['status'] == true) {
              await navigateReplace(
                  context,
                  SuccessScreen(
                      infoText: decodedResponse['message'].toString(),
                      newPage: const DashBoardScreen(
                        setIndex: 4,
                      ),
                      navigateButtonText: continueText));

              clearKYCData();
            }
            _isSubmittingKYC = false;
            notifyListeners();
            // navigateReplace(context, const DashBoardScreen());
            // fetchKYC(context);
          } else {
            _isSubmittingKYC = false;

            showToast(
              msg: decodedResponse['message'].toString(),
              isError: false,
            );
          }

          notifyListeners();
        }
      }).whenComplete(() async {
        _isSubmittingKYC = false;

        _buttonSubmitKYCState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: login,
        );
        // fetchKYC(context);
        notifyListeners();
      });
    } catch (e, s) {
      // showToast(
      //   msg: somethingWentWrong,
      //   isError: true,
      // );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  // Future<KycResponseStatus?> fetchKYC(BuildContext context) async {
  //   try {
  //     await profileService.fetchKYCStatus().then((value) async {
  //       if (value != null) {
  //         final decodedResponse = jsonDecode(value.toString());
  //         if (decodedResponse['status'].toString() == 'true') {
  //           kycResponseStatus = KycResponseStatus.fromJson(decodedResponse);
  //           notifyListeners();
  //         }
  //       }
  //       notifyListeners();
  //     }).whenComplete(() {
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     // showToast(
  //     //   msg: somethingWentWrong,
  //     //   isError: true,
  //     // );
  //     // logger
  //     //   ..i(checkErrorLogs)
  //     //   ..e(s);
  //   }
  //   return kycResponseStatus;
  // }

  ///Method for Picking Multiple Image
  pickImageAsList() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    notifyListeners();
    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      driversLicenseFrontAndBckImage.add(File(pickedFile.path));
      notifyListeners();
      logger.i('Image Path $driversLicenseFrontAndBckImage');
    } else {}
  }

  /// Method to pick Single Image from gallery
  Future<File?> pickSingleImageOne() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    notifyListeners();

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      notifyListeners();
      logger.f('Image Path $imageFile');
      //final bytes = imageFile.readAsBytesSync().lengthInBytes;
      //final kb = bytes / 1024;
      // logger.t("${kb}KB");
      // logger.i("${kb}KB");
      // log(imageFile.toString());

      return imageFile; // Return the picked file
    }

    return null; // Return null if no image is picked
  }

  Future<File?> updateDriverLicenceFrontImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      driversLicenceImageFront = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateDriverLicenceBackImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      driversLicenceImageBack = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateNinFrontImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      ninImageFront = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateNinBackImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      ninImageBack = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateIntlPassportFrontImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      intlPassportImageFront = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateIntlPassportBackImage() async {
    final pickedImage = await pickSingleImageOne();
    if (pickedImage != null) {
      intlPassportImageBack = pickedImage;
      notifyListeners();
    }
    return null;
  }

  Future<File?> updateProofOfOwnershipImage() async {
    final pickedImage = await pickSingleImageOne();

    if (pickedImage != null) {
      proofOfOwnership = pickedImage;
      notifyListeners();
    }
    return null;
  }

  void updateDocumentType(String docType) {
    _documentType = docType;
    notifyListeners();
  }

  Future<void> updateDocumentNumberController() async {
    _documentNumberController = TextEditingController();
    notifyListeners();
  }

  Future<void> clearKYCData() async {
    _documentNumberController = TextEditingController();
    driversLicenceImageFront = null;
    driversLicenceImageBack = null;

    ninImageFront = null;
    ninImageBack = null;

    intlPassportImageFront = null;
    intlPassportImageBack = null;

    proofOfOwnership = null;
    nextOfKinFirstNameController.clear();
    nextOfKinLastNameController.clear();
    nextOfKinEmailController.clear();
    nextOfKinPhoneNoController.clear();
    nextOfKinRelationController.clear();
    notifyListeners();
  }

  void updateImageFrontAndBack(frontImage, backImage) {
    imageFrontAndBckImage = [frontImage, backImage];
    notifyListeners();
  }

  Future<void> updateProfilePhoto(BuildContext context) async {
    try {
      await profileService.uploadProfileAvatar(
        context,
        onSendProgress: (int sent, int total) {
          /// In the code snippet provided, `final progress = sent / total * 1;` is calculating the
          /// progress percentage of the file upload.
          final progress = (sent / total) * 0.1;
          //
          _showUploadIndicator = true;
          _uploadProgress = progress;
          notifyListeners();

          // logger.d(
          //   'progress: ${progress.toStringAsFixed(1)}% ($sent/$total)',
          // );
        },
      ).then((dynamic value) async {
        /// Once the file upload is complete, the response is decoded using `jsonDecode`.
        /// The `profileData` object is then updated with the new profile photo URL from the response. Finally, the `notifyListeners` method is called to notify any listeners that the profile data has changed.
        ///
        /// Overall, the `updateProfilePhoto` method handles the file upload, updates the profile data with the new photo URL, and notifies listeners of the change.

        // final decodeResponse = jsonDecode(value.toString());
        // profileData!.data!.profilePhoto =
        // decodeResponse['data']['profilePhoto'] as String;
        await loadData(context);
        notifyListeners();
      }).whenComplete(() {
        // hide progress indicator when
        //upload is complete
        _showUploadIndicator = false;
        // notifyListeners();
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<UserResponseModel?> loadData(BuildContext context) async {
    isFetchingProfile = true;
    notifyListeners();
    try {
      await profileService.getProfileData().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());

          if (decodedResponse['status'].toString() == 'true') {
            _profileData = UserResponseModel.fromJson(decodedResponse['data']);
            DummyData.lastName = _profileData?.lastName.toString();
            DummyData.firstName = _profileData?.firstName.toString();
            DummyData.phoneNumber = _profileData?.phoneNumber ?? "";
            notifyListeners();
            // log(DummyData.phoneNumber.toString());
            // _gender =  _profileData!.gender.toString();
          } else {
            navigateReplace(context, const DashBoardScreen());
          }
        }
        isFetchingProfile = false;
        notifyListeners();
      }).whenComplete(() {
        notifyListeners();
      });
    } catch (e) {
      // showToast(
      //   msg: e.toString(),
      //   isError: true,
      // );
    }

    return _profileData;
  }

  bool get isFetchingLandlordBanks => _isFetchingLandlordBanks;

  Future<void> initPage() async {
    _accountNumberController = TextEditingController();
    _accountName = accountNameText;
    notifyListeners();
  }

  void updateSaveBankButtonState() {
    if (_accountNumberController.text.length < 10 || _bankCode!.isNotEmpty) {
      _buttonSaveBankDetailsState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: login,
      );
    } else {
      _buttonSaveBankDetailsState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: login,
      );
    }
    notifyListeners();
  }

  // String getInitials(String name) {
  //   List<String> nameParts = name.split(' ');
  //   String initials = '';
  //   for (String part in nameParts) {
  //     initials += part[0];
  //   }
  //   return initials.toUpperCase();
  // }

  String getInitials({required String firstName, required String lastName}) {
    String initials = '';
    return initials += firstName[0] + lastName[0].toUpperCase();
  }

  TextEditingController get nextOfKinLastNameController => _nextOfKinLastNameController;

  TextEditingController get nextOfKinPhoneNoController => _nextOfKinPhoneNoController;

  TextEditingController get nextOfKinEmailController => _nextOfKinEmailController;

  TextEditingController get nextOfKinRelationController => _nextOfKinRelationController;
}
