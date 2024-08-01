import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    required this.fieldLabel,
    super.key,
    this.height,
    this.width,
    this.hint,
    this.controller,
    this.labelHint = '',
    this.spacing,
    this.suffixText,
    this.fontSize,
    this.textInputAction,
    this.keyboardType,
    this.initialValue,
    this.readOnly = false,
    this.padding,
    this.showSuffixIcon = true,
    this.showSuffixText = false,
    this.prefixIcon,
    this.password = false,
    this.trailing,
    this.inputFormatter,
    this.prefix,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.maxLines,
    this.isFilled = true,
    this.fillColor = AppColors.kOnyxBlack,
    // const Color(0xffF9F9F9),
    this.borderColor,
    this.validator,
    this.obscureInput = false,
    this.onObscureText,
    this.borderRadius = 12,
    this.maxlength,
    this.enabled = true,
    this.useForgotPass = false,
    this.onForgotPassTap,
    this.visibleField = true,
    this.borderWidth = 1.0,
    this.focusNode,
    this.showError = false,
    this.errorText,
    this.onChanged,
  });

  final String? hint;
  final String fieldLabel;
  final String labelHint;
  final String? suffixText;
  final double? spacing;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool readOnly;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool? password;
  final bool? showSuffixIcon;
  final bool? showSuffixText;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final Color? textColor;
  final double? fontSize;
  final int? maxLines;
  final double? borderWidth;
  final bool isFilled;
  final Color? fillColor;
  final Color? borderColor;
  final FormFieldValidator<String>? validator;

  final bool obscureInput;
  final void Function()? onObscureText;
  final double borderRadius;
  final int? maxlength;
  final bool useForgotPass;
  final bool enabled;
  final void Function()? onForgotPassTap;
  final bool visibleField;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final bool? showError;
  final String? errorText;
  final Function(String?)? onChanged;

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  // myFocusNode = focusNode;
  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    final myFocusNode = widget.focusNode;
    final theme = Theme.of(context);
    return Visibility(
      visible: widget.visibleField,
      // ignore: sized_box_for_whitespace
      child: Container(
        width: widget.width,
        height: widget.height,
        // padding: EdgeInsets.only(bottom: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            widget.fieldLabel.isNotEmpty ? Column(
              children: [
                      TextView(
                        text: widget.fieldLabel,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                const Gap(10),
              ],
            ) : const SizedBox.shrink(),
            TextFormField(

              onChanged: widget.onChanged,
              maxLength: widget.maxlength,
              inputFormatters: widget.inputFormatter,
              controller: widget.controller,
              textInputAction: widget.textInputAction,
              focusNode: myFocusNode,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w400,
                fontFamily: 'soraFont',
                fontSize: widget.fontSize ?? 14.spMin,
              ),
              keyboardType: widget.keyboardType,
              initialValue: widget.initialValue,
              textCapitalization: widget.textCapitalization,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              textAlign: widget.textAlign,
              maxLines: widget.maxLines ?? 1,
              validator: widget.validator,
              obscureText: widget.obscureInput,
              decoration: InputDecoration(
              //  label:
                border: widget.readOnly
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.kGrey400),
                        borderRadius: BorderRadius.circular(widget.borderRadius.r)),
                hintText: widget.hint,
                hintStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: widget.readOnly
                      ? AppColors.kSmokyBlue
                      : themeMode == ThemeMode.dark
                          ? AppColors.kGraphiteGray
                          : AppColors.kGrey400,
                  fontFamily: 'soraFont',
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: widget.prefixIcon,
                prefix: widget.prefix,
                suffixText: widget.showSuffixText! ? widget.suffixText : '',
                suffixIcon: widget.textAlign == TextAlign.center
                    ? null
                    : widget.showSuffixIcon!
                        ? Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Visibility(
                                visible: widget.password!,
                                child: GestureDetector(
                                  onTap: widget.onObscureText,
                                  child: SizedBox(
                                    height: 40.h,
                                    width: 45.w,
                                    // color: Colors.red,
                                    child: Icon(
                                      widget.obscureInput
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20.r,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.trailing != null,
                                child: widget.trailing ?? const SizedBox(),
                              ),
                            ],
                          )
                        : null,
                filled: widget.isFilled,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                fillColor: themeMode == ThemeMode.light ? AppColors.kGrey300 : widget.fillColor,
                enabledBorder: widget.readOnly
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),

                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                          color: themeMode == ThemeMode.dark
                              ? AppColors.kGrey400
                              : AppColors.kSnowWhite,
                        ),
                      ),
                  
                focusedBorder:   OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                      color: widget.readOnly ? AppColors.kOnyxBlack : AppColors.kPrimary1,
                      width: widget.borderWidth!.spMin),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: theme.colorScheme.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: theme.colorScheme.error),
                ),
                errorStyle: TextStyle(color: theme.colorScheme.error),
                errorMaxLines: 4,
              ),
            ),
            // if (myFocusNode.hasFocus)
            //   Text(
            //     // 'Hello',
            //     validatorOne.validateEmail(widget.controller!.text) ?? '',
            //     // widget.validators!.validateEmail(widget.controller!.text) ?? '',
            //     style: TextStyle(color: Colors.red),
            //   ),

            Gap(
              5.spMin,
            ),

            Visibility(
              visible: widget.useForgotPass,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.onForgotPassTap,
                  child: Text(
                    'Forgot Password?',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      fontFamily: soraFont,
                      fontSize: 12.spMin,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateText(
      String text, String? Function(String) validationFunction) {
    return validationFunction(text);
  }
}

///
///
///
///
