// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_if_null_operators

import 'package:groceryshopprices/lib.dart';

class TextFieldBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final List<Widget>? emailValidatorSuffixIcon;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<bool>? showPasswordToggled;
  final TextInputType? textInputType;
  final int? maxLengths;
  final int? maxLines;
  final bool showEyeButton;
  final bool showPass;
  final List<TextInputFormatter>? inputFormatters;
  final bool withPrimaryBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final bool enableRoundStadiumBorder;
  final double bottomPad;
  final bool validate;
  final String errorText;
  final EdgeInsets? contentPadding;
  final Color? bgColor;
  final Color? cursorColor;
  final Color? hintColor;
  final double? vertpad;
  final Color? textColor;
  final Color? normalBorderColor;
  final Color? focusedBorderColor;
  final bool defaultBorder;
  final bool clearTextAtSuffix;
  final VoidCallback? onCleared;
  const TextFieldBoxWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.emailValidatorSuffixIcon,
    this.onSubmitted,
    this.showPasswordToggled,
    this.textInputType,
    this.maxLengths,
    this.maxLines,
    this.showEyeButton = false,
    this.showPass = true,
    this.inputFormatters,
    this.withPrimaryBorder = true,
    this.suffixIcon,
    this.prefixIcon,
    this.autofillHints,
    this.focusNode,
    this.enableRoundStadiumBorder = false,
    this.bottomPad = 12,
    this.validate = false,
    this.errorText = "",
    this.contentPadding,
    this.bgColor,
    this.cursorColor,
    this.hintColor,
    this.vertpad,
    this.textColor,
    this.normalBorderColor,
    this.focusedBorderColor,
    this.defaultBorder = false,
    this.clearTextAtSuffix = true,
    this.onCleared,
  }) : super(key: key);
  TextFieldBoxWidget.onlyDigit({
    Key? key,
    required this.controller,
    required this.hint,
    this.showPasswordToggled,
    this.onChanged,
    this.textInputType = TextInputType.number,
    this.maxLengths,
    this.onSubmitted,
    this.maxLines,
    this.showEyeButton = false,
    this.showPass = true,
    this.inputFormatters,
    this.withPrimaryBorder = true,
    this.autofillHints,
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.emailValidatorSuffixIcon,
    this.enableRoundStadiumBorder = false,
    this.bottomPad = 12,
    this.validate = false,
    this.errorText = "",
    this.contentPadding,
    this.bgColor,
    this.cursorColor,
    this.hintColor,
    this.vertpad,
    this.textColor,
    this.normalBorderColor,
    this.focusedBorderColor,
    this.defaultBorder = false,
    this.clearTextAtSuffix = true,
    this.onCleared,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPassword = showEyeButton && showPass;
    return StatefulBuilder(builder: (context, state) {
      // printLog("isValidEmail ${controller.text}");
      return TextField(
              focusNode: focusNode,
              autofillHints: autofillHints ?? [],
              inputFormatters: inputFormatters,
              maxLength: maxLengths,
              maxLines: maxLines ?? 1,
              controller: controller,
              keyboardType: textInputType,
              onChanged: (d) {
                if (onChanged != null) {
                  onChanged!(d);
                }
                state(() {});

                if (emailValidatorSuffixIcon != null) {
                  state(() {});
                }
              },
              onSubmitted: (d) {
                printLog("onSaved $d");
                if (onSubmitted != null) {
                  onSubmitted!(d);
                }
              },
              style: TextStyle(
                  color: textColor ?? DesignColor.primary,
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.w500),
              cursorColor: cursorColor ?? DesignColor.primary,
              // Color(0xffAE0000),
              obscureText: showEyeButton && !showPassword,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  errorMaxLines: 3,
                  errorText: validate ? errorText : null,
                  // suffix: suffixIcon ?? null,
                  hintText: hint,
                  hintStyle: TextStyle(
                      color: hintColor ?? DesignColor.hint,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: bgColor ?? DesignColor.white,
                  enabled: true,
                  enabledBorder: defaultBorder
                      ? null
                      : OutlineInputBorder(
                          borderSide: withPrimaryBorder
                              ? roundBorderStyle.borderSide
                              : BorderSide(
                                  color:
                                      normalBorderColor ?? DesignColor.primary),
                          borderRadius: (enableRoundStadiumBorder ? 100 : 12)
                              .circularBorder()),
                  focusedBorder: defaultBorder
                      ? null
                      : OutlineInputBorder(
                          borderSide: withPrimaryBorder
                              ? roundFocusedBorderStyle.borderSide
                              : BorderSide(
                                  color: focusedBorderColor ??
                                      DesignColor.primary),
                          borderRadius: (enableRoundStadiumBorder ? 100 : 12)
                              .circularBorder()),
                  prefixIcon: prefixIcon,
                  suffixIcon: clearTextAtSuffix
                      ? BouncingBtn.fast(
                          child: Icon(
                            Icons.close,
                            color: DesignColor.red,
                            size: 20,
                          ),
                          onTap: () {
                            controller.clear();
                            state(() {});
                            if (onCleared != null) {
                              onCleared!();
                            }
                          })
                      : suffixIcon != null
                          ? suffixIcon
                          : (emailValidatorSuffixIcon != null &&
                                  emailValidatorSuffixIcon!.length > 1)
                              ? (isValidEmail(controller.text.trim())
                                  ? emailValidatorSuffixIcon![0]
                                  : emailValidatorSuffixIcon![1])
                              : showEyeButton
                                  ? IconButton(
                                      onPressed: () {
                                        showPassword = !showPassword;
                                        if (showPasswordToggled != null) {
                                          showPasswordToggled!(showPassword);
                                        }
                                        state(() {});
                                      },
                                      icon: Icon(
                                        showPassword
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        color: DesignColor.primary,
                                      ))
                                  : null
                  // enabledBorder: primaryBorderStyle.copyWith(
                  //     borderSide: BorderSide(width: 0.6, color: DesignColor.hint)),
                  // border: primaryBorderStyle.copyWith(
                  //     borderSide:
                  //         BorderSide(width: 0.6, color: DesignColor.hint)
                  //         )
                  ))
          .applySymmetricPadding(horizontal: 0, vertical: vertpad ?? 8)
          .applyBottomPadding(padding: bottomPad);
    });
  }
}
