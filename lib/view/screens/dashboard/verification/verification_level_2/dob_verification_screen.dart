import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';



class DateOfBirthVerificationScreen extends ConsumerWidget {
  DateOfBirthVerificationScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    var profileProvider = ref.watch(profileViewModel);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBars.mainAppBar(
          context,
       
          text: verifyAccountTextInCaps,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  fieldLabel: dateOfBirth,
                  hint: dateOfBirthFormat,
                  controller: profileProvider.verifyDOBController,
                  onTap: () async {
                    FocusScope.of(context)
                        .requestFocus(FocusNode()); // To prevent keyboard from appearing
                    await _selectDate(context, profileProvider);
                    profileProvider.updateVerifyDOBButtonState();
                  },
                  

                ),
                DefaultButtonMain(
                  color: AppColors.kPrimary1,
                  buttonState: profileProvider.verifyDOBButtonState.buttonState,
                  text: profileProvider.verifyDOBButtonState.text,
                  onPressed: () {
                    navigatePush(context, BVNVerificationScreen());
                  },
                )
              ],
            ),
          ),
        ));
        
  }
  Future<void> _selectDate(BuildContext context, ProfileViewModel profileProvider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DummyData.userDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    profileProvider.updateSelectedDate(picked);
  }
 
}
