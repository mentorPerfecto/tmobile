// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/rebirth.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/repository.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authViewModel = ChangeNotifierProvider((ref) => AuthViewModel());

class AuthViewModel extends ChangeNotifier {
  late SharedPreferences sharedPreferences;

  final TextEditingController _loginEmailController =
      TextEditingController(text: DummyData.emailAddress ?? '');
  final TextEditingController _loginPwdController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  final TextEditingController _forgotPwdEmailController = TextEditingController();

  ///final TextEditingController _pinCodeController = TextEditingController();

  String _pinCode = '';


  bool _loginObscurePass = true;
  bool _obscureOldPass = true;
  bool _obscureNewPass = true;
  bool _obscureConfirmNewPass = true;
  bool _obscureResetPass = true;
  bool _obscureResetConfirmPass = true;
  // bool _isSwitchingRole = false;

  bool get obscureResetPass => _obscureResetPass;
  bool get obscureResetConfirmPass => _obscureResetConfirmPass;
  bool _isResendingOTP = false;

  bool get isResendingOTP => _isResendingOTP;
  final authService = AuthBackend();

  final loginFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();
  final resetPassFormKey = GlobalKey<FormState>();
  final forgotPassFormKey = GlobalKey<FormState>();
  final pinFormKey = GlobalKey<FormState>();

  CustomButtonState _buttonLoginState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: login,
  );

  CustomButtonState _buttonVerifyState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: continueText,
  );

  CustomButtonState _buttonChangePwdState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: continueText,
  );

  CustomButtonState _buttonForgotPWdState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: login,
  );

  TextEditingController get loginEmailController => _loginEmailController;
  TextEditingController get loginPwdController => _loginPwdController;
  TextEditingController get oldPasswordController => _oldPasswordController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmNewPasswordController => _confirmNewPasswordController;

  TextEditingController get forgotPwdEmailController => _forgotPwdEmailController;

  bool get loginObscurePass => _loginObscurePass;
  bool get obscureOldPass => _obscureOldPass;
  bool get obscureNewPass => _obscureNewPass;
  bool get obscureConfirmPass => _obscureConfirmNewPass;
  CustomButtonState? get buttonLoginState => _buttonLoginState;

  CustomButtonState? get buttonVerifyState => _buttonVerifyState;
  CustomButtonState? get buttonForgotPWdState => _buttonForgotPWdState;
  CustomButtonState? get buttonChangePwdState => _buttonChangePwdState;

  toggleOldPassVisibility() {
    _obscureOldPass = !_obscureOldPass;
    notifyListeners();
  }

  toggleNewPassVisibility() {
    _obscureNewPass = !_obscureNewPass;
    notifyListeners();
  }

  toggleConfirmPassVisibility() {
    _obscureConfirmNewPass = !_obscureConfirmNewPass;
    notifyListeners();
  }

  toggleLoginPwdVisibility() {
    _loginObscurePass = !_loginObscurePass;
    notifyListeners();
  }

  toggleResetConfirmPwdVisibility() {
    _obscureResetConfirmPass = !_obscureResetConfirmPass;
    notifyListeners();
  }


  void updateVerifyButtonState(String value) {
    _pinCode = value;
    notifyListeners();

    if (_pinCode.length < 6) {
      _buttonVerifyState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: login,
      );
    } else {
      _buttonVerifyState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: login,
      );
    }
    notifyListeners();
  }

  void clearPinCodeAndResetVerifyButtonState() {
    _pinCode = "";
    _buttonVerifyState = CustomButtonState(
      buttonState: ButtonState.disabled,
      text: login,
    );
    
  }

  void updateButtonLoginState() {
    if (_loginEmailController.text.isNotEmpty & _loginPwdController.text.isNotEmpty) {
      _buttonLoginState = CustomButtonState(buttonState: ButtonState.idle);
    }
    notifyListeners();
  }

  void updateCreateNewPassButtonState() {
    if (_newPasswordController.text.isNotEmpty & _confirmNewPasswordController.text.isNotEmpty) {
      _buttonChangePwdState = CustomButtonState(buttonState: ButtonState.idle);
    }
    notifyListeners();
  }

  void updatePassResetButtonState() {
    if (_forgotPwdEmailController.text.isNotEmpty) {
      _buttonForgotPWdState = CustomButtonState(buttonState: ButtonState.idle);
    }
    notifyListeners();
  }

  Future<void> userLogin(BuildContext context) async {
    try {
      _buttonLoginState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: login,
      );
      notifyListeners();
      await authService
          .signInAdmin(
        email: _loginEmailController.text.toLowerCase(),
        password: _loginPwdController.text,
      )
          .then((value) async {
        if (value != null) {
          if (value['status'].toString() == 'true') {
            logger.t(value['data']['token'].toString());
            _buttonLoginState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: login,
            );

            if (value['data']['verifyOtp'].toString() == '1') {
              DummyData.emailAddress = _loginEmailController.text.toString();
              notifyListeners();
              // navigatePush(
              //     context,
              //     EmailVerificationScreen(
              //       title: verifyEmail,
              //       subTitle: enterEmailCodeForEmailVerification,
              //       email: _loginEmailController.text.toString(),
              //       pwd: _loginPwdController.text.toString(),
              //     ));
            } else {
              showToast(
                msg: 'Login successful',
                isError: false,
              );

              DummyData.emailAddress = _loginEmailController.text;
              DummyData.password = _loginPwdController.text;
              await saveUserEmail(_loginEmailController.text);
              await getUserEmail();
              await saveAccessToken(value['data']['token'].toString());
              await getAccessToken();
              await saveAppTme();
              await saveUserPassword(_loginPwdController.text);
              await getUserPassword();

              WidgetRebirth.createRebirth(context: context);

              // await ProfileViewModel().loadData(context).then((value) async {
              //   if (value != null) {
              //     DummyData.firstName = value.firstName.toString();
              //     DummyData.lastName = value.lastName.toString();
              //     DashboardViewModel().setBottomBarItem(context, 0).then((value) async => await navigateReplace(context, const DashBoardScreen()));
              //
              //   }
              // });
              // notifyListeners();
            }
          }
        }
      }).whenComplete(() {
        _buttonLoginState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: login,
        );
        notifyListeners();
      });
    } catch (e, s) {
      showToast(
        msg: somethingWentWrong,
        isError: true,
      );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  Future<void> callForgotPwd(BuildContext context) async {
    try {
      _buttonForgotPWdState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: resetPass,
      );
      notifyListeners();
      await authService
          .sendAndResendOTP(
        email: _forgotPwdEmailController.text.toLowerCase(),
      )
          .then((value) async {
        if (value != null) {
          if (value['status'].toString() == 'true') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
            _buttonForgotPWdState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: resetPass,
            );

            DummyData.emailAddress = _forgotPwdEmailController.text.toString();
            notifyListeners();
            // navigatePush(
            //     context,
            //     EmailVerificationScreen(
            //       title: verifyEmail,
            //       subTitle: enterEmailCodeStart,
            //       isForgotPassword: true,
            //       pwd: '',

            //       email: _forgotPwdEmailController.text.toString(),
            //     ));
          } else if (value['status'].toString() == 'error') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
            notifyListeners();
          }
        }
      }).whenComplete(() {
        _buttonForgotPWdState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: resetPass,
        );
        notifyListeners();
      });
    } catch (e, s) {
      showToast(
        msg: somethingWentWrong,
        isError: true,
      );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  Future<bool> resendOTP(BuildContext context, {required String email}) async {
    bool resentOTP = false;
    try {
      _isResendingOTP = true;
      notifyListeners();
      await authService
          .sendAndResendOTP(
        email: email,
      )
          .then((value) async {
        if (value != null) {
          if (value['status'].toString() == 'true') {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
          } else {
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
          }
          _isResendingOTP = false;
          resentOTP = value['status'];
          notifyListeners();
        }
      }).whenComplete(() {
        _isResendingOTP = false;
        notifyListeners();
      });
    } catch (e, s) {
      showToast(
        msg: somethingWentWrong,
        isError: true,
      );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
    return resentOTP;
  }

  Future<void> userAutoLogin(BuildContext context,
      {required String email, required String password}) async {
    logger.f(email);
    logger.f(password);
    try {
      _buttonLoginState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: login,
      );
      notifyListeners();
      await authService
          .signInAdmin(
        email: email.toLowerCase(),
        password: password,
      )
          .then((value) async {
        if (value != null) {
          if (value['status'].toString() == 'true') {
            _buttonLoginState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: login,
            );

            if (value['data']['verifyOtp'].toString() == '1') {
              DummyData.emailAddress = email.toLowerCase();
              notifyListeners();
              // navigatePush(
              //     context,
              //     EmailVerificationScreen(
              //       title: verifyEmail,
              //       subTitle: enterEmailCodeForEmailVerification,
              //       email: email.toLowerCase(),
              //       pwd: password,
              //     ));
            } else {
              DummyData.emailAddress = email.toLowerCase();
              DummyData.password = password;
              await saveUserEmail(email.toLowerCase());
              await getUserEmail();
              await saveAccessToken(value['data']['token'].toString());
              await getAccessToken();
              await saveAppTme();
              await saveUserPassword(password);
              await getUserPassword();
              await ProfileViewModel().loadData(context).then((value) async {
                if (value != null) {
                  DummyData.firstName = value.firstName.toString();
                  DummyData.lastName = value.lastName.toString();
                }
              });
              notifyListeners();
              await navigateReplace(context, const DashBoardScreen());
            }
          } else {
            navigatePush(context, const DashBoardScreen());
          }
        } else {
          navigatePush(context, const DashBoardScreen());
        }
      });
    } catch (e, s) {
      navigatePush(context, const DashBoardScreen());
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }

  Future<void> verifyFPwdEmail(context,
      {required String email, required String pwd, bool isForgotPassword = false}) async {
    if (isForgotPassword) {
      // navigatePush(context, const VerifyEmailScreen());
    } else {
      try {
        _buttonVerifyState = CustomButtonState(
          buttonState: ButtonState.loading,
          text: continueText,
        );
        notifyListeners();
        await authService
            .verifyEmail(
          email: email.toLowerCase(),
          otp: _pinCode.toString(),
        )
            .then((value) async {
          logger.f(value);
          if (value != null) {
            if (value['status'].toString() == 'true') {
              _buttonVerifyState = CustomButtonState(
                buttonState: ButtonState.idle,
                text: continueText,
              );
              //
              await saveUserEmail(email.toLowerCase());
              await getUserEmail();
              await saveAccessToken(value['data'].toString());
              await getAccessToken();
              await saveAppTme();
              await saveUserPassword(pwd.toLowerCase());
              await getUserPassword();

              WidgetRebirth.createRebirth(context: context);

              // Navigator.of(context).pushAndRemoveUntil(
              //   // the new route
              //   MaterialPageRoute(
              //       builder: (BuildContext context) => const SuccessScreen(
              //             infoText: emailSuccessfullyVerified,
              //             newPage: SignInScreen(
              //               backBtnVisibility: false,
              //             ),
              //             navigateButtonText: continueText,
              //           )),
              //
              //   // this function should return true when we're done removing routes
              //   // but because we want to remove all other screens, we make it
              //   // always return false
              //   (Route route) => false,
              // );
            } else if (value['status'].toString() == 'false') {
              showToast(
                msg: value['message'].toString(),
                isError: false,
              );
              notifyListeners();
            }
          }
        }).whenComplete(() {
          _buttonVerifyState = CustomButtonState(
            buttonState: ButtonState.idle,
            text: continueText,
          );
          notifyListeners();
        });
      } catch (e, s) {
        showToast(
          msg: somethingWentWrong,
          isError: true,
        );
        logger
          ..i(checkErrorLogs)
          ..e(s);
      }
    }
  }


  Future<void> changePwd(context, {required int setIndex}) async {
    try {
      _buttonChangePwdState = CustomButtonState(
        buttonState: ButtonState.loading,
        text: continueText,
      );
      notifyListeners();
      await authService
          .changePassword(
              oldPassword: _oldPasswordController.text, newPassword: _newPasswordController.text)
          .then((value) async {
        if (value != null) {
          if (value['status'].toString() == 'true') {
            _buttonChangePwdState = CustomButtonState(
              buttonState: ButtonState.idle,
              text: continueText,
            );
            navigatePush(
              context,
              SuccessScreen(
                  infoText: "Your password have been reset",
                  newPage: DashBoardScreen(
                    setIndex: setIndex,
                  ),
                  navigateButtonText: "Go Back To Menu"),
            );
            showToast(
              msg: value['message'].toString(),
              isError: false,
            );
          } else if (value['status'].toString() == 'false') {
            showToast(
              msg: value['message'].toString(),
              isError: true,
            );
            notifyListeners();
          }
        }
      }).whenComplete(() {
        _buttonChangePwdState = CustomButtonState(
          buttonState: ButtonState.idle,
          text: continueText,
        );
        notifyListeners();
      });
    } catch (e, s) {
      showToast(
        msg: somethingWentWrong,
        isError: true,
      );
      logger
        ..i(checkErrorLogs)
        ..e(s);
    }
  }


  saveUserEmail(localUserEmail) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Email", localUserEmail);
    logger.i("saved Email Address ${DummyData.emailAddress}");
  }

  saveUserPassword(localPassword) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Password", localPassword);
    logger.i("saved Password");
  }

  getUserEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DummyData.emailAddress = sharedPreferences.getString("Email");
    logger.i("get  Email Address ${DummyData.emailAddress}");
  }

  getUserPassword() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DummyData.password = sharedPreferences.getString("Password");
    logger.i("get Password ${DummyData.password}");
  }

  saveAccessToken(accessToken) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", accessToken);
    logger.i("saved accessToken");
  }

  saveRefreshToken(refreshToken) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("refreshToken", refreshToken);
    logger.i("saved refreshToken");
  }

  Future<void>saveAppTme() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("firstTimeOnApp", false);
    logger.i("saved firstTimeOnApp");
  }

  getAccessToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DummyData.accessToken = sharedPreferences.getString("accessToken");
    log("get accessToken : ${DummyData.accessToken}");
    return sharedPreferences.getString("accessToken");
  }

  Future<void> initPage() async {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }
}
