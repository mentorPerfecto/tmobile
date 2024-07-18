import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/config/app_strings.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/repository.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/auth/signup/create_password_screen.dart';

final registrationViewModel = ChangeNotifierProvider((ref) => RegistrationViewModel());

class RegistrationViewModel extends ChangeNotifier {
  final authService = AuthBackend();
  final registrationFormKey = GlobalKey<FormState>();
  final registerationCreatePasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _bvnNumberController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPwdController = TextEditingController();
  final TextEditingController _registerConfirmPwdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _refCodeController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  CustomButtonState _buttonRegisterState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: continueText,
  );

  CustomButtonState _buttonRegisterStateCreatePassword = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: createAccount,
  );

  CustomButtonState _verifyBVNButtonState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: verify,
  );

  bool _obscurePasswordText = true;
  bool _obscureConfirmPwdText = true;

  TextEditingController get bvnNumberController => _bvnNumberController;
  TextEditingController get registerEmailController => _registerEmailController;
  TextEditingController get registerPwdController => _registerPwdController;
  TextEditingController get userNameController => _userNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get registerConfirmPwdController => _registerConfirmPwdController;
  // TextEditingController get firstNameController => _firstNameController;
  // TextEditingController get lastNameController => _lastNameController;
  TextEditingController get refCodeController => _refCodeController;
  CustomButtonState get buttonRegisterState => _buttonRegisterState;
  CustomButtonState get buttonRegisterStateCreatePassword => _buttonRegisterStateCreatePassword;
  CustomButtonState get verifyBVNButtonState => _verifyBVNButtonState;
  bool get obscurePasswordText => _obscurePasswordText;

  bool get obscureConfirmPwdText => _obscureConfirmPwdText;

  void togglePwdVisibility() {
    _obscurePasswordText = !_obscurePasswordText;
    notifyListeners();
  }

  void toggleConfirmPwdVisibility() {
    _obscureConfirmPwdText = !_obscureConfirmPwdText;
    notifyListeners();
  }

  void updateRegisterButtonState() {
    if (
        // _firstNameController.text.isNotEmpty &
        //     _lastNameController.text.isNotEmpty &
        _registerEmailController.text.isNotEmpty &
            _userNameController.text.isNotEmpty &
            _phoneNumberController.text.isNotEmpty) {
      _buttonRegisterState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: continueText,
      );
    } else {
      _buttonRegisterState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: continueText,
      );
    }
    notifyListeners();
  }

  void updateVerifyBVNButtonState() {
    if (_bvnNumberController.text.isNotEmpty) {
      _verifyBVNButtonState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: verify,
      );
    } else {
      _verifyBVNButtonState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: verify,
      );
    }
    notifyListeners();
  }

  void updateRegisterButtonCreatePasswordState() {
    if (_registerPwdController.text.isNotEmpty & _registerConfirmPwdController.text.isNotEmpty) {
      _buttonRegisterStateCreatePassword = CustomButtonState(
        buttonState: ButtonState.idle,
        text: createAccount,
      );
    } else {
      _buttonRegisterStateCreatePassword = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: createAccount,
      );
    }
    notifyListeners();
  }

  Future<void> userRegistration(BuildContext context) async {
    if (registrationFormKey.currentState!.validate()) {
      registrationFormKey.currentState!.save();

      navigatePush(context, const CreatePasswordScreen());
      // try {
      //   _buttonRegisterState = CustomButtonState(
      //     buttonState: ButtonState.loading,
      //     text: createAccount,
      //   );
      //   notifyListeners();
      //   await authService
      //       .signUp(
      //     email: _registerEmailController.text,
      //     password: _registerPwdController.text,
      //     firstName: _firstNameController.text,
      //     lastName: _lastNameController.text,
      //     referral: _refCodeController.text,
      //   )
      //       .then((value) async {
      //     if (value != null) {
      //       // print(value['status'].toString());
      //       //   final decodeResponse = jsonDecode(value.toString());
      //       final decodeResponse = value;
      //       logger.w(decodeResponse);
      //       if (value['status'].toString() == 'true') {
      //         _buttonRegisterState = CustomButtonState(
      //           buttonState: ButtonState.idle,
      //           text: createAccount,
      //         );
      //
      //         showToast(
      //           msg: value['data'].toString(),
      //           isError: false,
      //         );
      //         DummyData.emailAddress = _registerEmailController.text.toString();
      //         notifyListeners();
      //         navigatePush(
      //             context,
      //             EmailVerificationScreen(
      //               title: emailCheck,
      //               subTitle: sentOTPUserEmail,
      //               pwd: _registerPwdController.text.toString(),
      //               email: _registerEmailController.text.toString(),
      //             ));
      //       } else if (value['status'].toString() == 'status') {
      //         notifyListeners();
      //       } else {
      //         showToast(
      //           msg: value['data'].toString(),
      //           isError: true,
      //         );
      //       }
      //     }
      //   }).whenComplete(() {
      //     _buttonRegisterState = CustomButtonState(
      //       buttonState: ButtonState.idle,
      //       text: createAccount,
      //     );
      //     notifyListeners();
      //   });
      // } catch (e, s) {
      //   showToast(
      //     msg: somethingWentWrong,
      //     isError: true,
      //   );
      //   logger
      //     ..i(checkErrorLogs)
      //     ..e(s);
      // }
    }
  }
}
