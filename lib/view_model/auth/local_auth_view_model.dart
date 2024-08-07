import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final localAuthViewModel =
    ChangeNotifierProvider((ref) => LocalAuthViewModel());

class LocalAuthViewModel extends ChangeNotifier {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState _supportState = SupportState.unknown;
  SupportState get supportState => _supportState; // bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool get isAuthenticating => _isAuthenticating;
  String get authorized => _authorized;
  // final CustomButtonState _localAuthButtonState = CustomButtonState(buttonState: ButtonState.idle, text: "Authenticate");
  // CustomButtonState? get localAuthButtonState => _localAuthButtonState;

  Future<void> initLocalAuth() async {
    auth.isDeviceSupported().then(
      (bool isSupported) {
        _supportState =
            isSupported ? SupportState.supported : SupportState.unsupported;
      },
    );
    notifyListeners();
  }
  // Future<void> _checkBiometrics(bool mounted) async {
  //   late bool canCheckBiometrics;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     canCheckBiometrics = false;
  //     logger.w(e);
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //  /// _canCheckBiometrics = canCheckBiometrics;
  //   notifyListeners();
  // }
  //
  // Future<void> _getAvailableBiometrics(bool mounted) async {
  //   late List<BiometricType> availableBiometrics;
  //   try {
  //     availableBiometrics = await auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     availableBiometrics = <BiometricType>[];
  //     logger.w(e);
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   _availableBiometrics = availableBiometrics;
  // }

  //
  // Future<void> _authenticate(bool mounted) async {
  //   bool authenticated = false;
  //   try {
  //     _isAuthenticating = true;
  //     _authorized = 'Authenticating';
  //     notifyListeners();
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //       ),
  //     );
  //     _isAuthenticating = false;
  //     notifyListeners();
  //   } on PlatformException catch (e) {
  //     logger.w(e);
  //     _isAuthenticating = false;
  //     _authorized = 'Error - ${e.message}';
  //     notifyListeners();
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  //   notifyListeners();
  //
  // }

  Future<void> authenticateWithBiometrics(context, bool mounted) async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      notifyListeners();
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerlogger.w (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      _isAuthenticating = false;
      _authorized = 'Authenticating';
      notifyListeners();
    } on PlatformException catch (e) {
      logger.w(e);
      _isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      notifyListeners();
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;

    if(authenticated){
      navigateReplace(context, const DashBoardScreen());
      showToast(msg: "Welcome back", isError: !authenticated);
    }

    notifyListeners();
  }

  // Future<void> _cancelAuthentication() async {
  //   await auth.stopAuthentication();
  //   _isAuthenticating = false;
  //   notifyListeners();
  // }

}
