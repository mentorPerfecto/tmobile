import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';



class DateOfBirthVerificationScreen extends ConsumerWidget {
  DateOfBirthVerificationScreen({Key? key}) : super(key: key);
  final _dobFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    var profileProvider = ref.watch(profileViewModel);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBars.mainAppBar(
          context,
          backgroundColor: theme.scaffoldBackgroundColor,
          arrowBackColor: theme.colorScheme.primary,
          text: verifyAccountTextInCaps,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextField(
                  fieldLabel: dateOfBirth,
                  hint: dateOfBirthFormat,
                  // controller: provider.userNameController,
                  // validator: (value) => Validators().validateEmptyTextField(value),
                  // onChanged: (p0) {
                  //   provider.updateRegisterButtonState();
                  // },
                ),
                DefaultButtonMain(
                  color: AppColors.kPrimary1,
                  onPressed: () {
                    navigatePush(context, BVNVerificationScreen());
                  },
                )
              ],
            ),
          ),
        ));
  }
}
