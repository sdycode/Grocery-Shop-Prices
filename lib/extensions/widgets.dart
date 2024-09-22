// ignore_for_file: deprecated_member_use

import 'package:groceryshopprices/lib.dart';

extension OnStringForWidget on String {
  Widget elButnStyle({
    required VoidCallback onTap,
    TextStyle? textStyle,
    bool fullWidth = true,
    bool enableBorder = false,
    Color? bgColor,
    bool flex = true,
    Color? textColor,
    double? fontsize,
    double? width,
    double vertPad = 8,
    double inneerVertPad = 14,
    double sidePad = 8,
    double borderRadius = 12,
    bool loading = false,
    Color splashColor = const Color.fromARGB(150, 253, 250, 250),
    bool fullRoundButton = false,
    Color? borderColor,
    double opacity = 0.5,
    bool ignore = false,
    EdgeInsetsGeometry? padding,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sidePad, vertical: vertPad),
      width: fullWidth ? (width ?? double.infinity) : null,
      child: ElevatedButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all(padding ?? EdgeInsets.zero),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // Splash color when button is pressed
                        return splashColor; // Change color and opacity as needed
                      }
                      // Splash color when button is not pressed
                      return transperent; //  Transparent splash color when button is not pressed
                    },
                  ),
                  shape: fullRoundButton
                      ? MaterialStateProperty.all(StadiumBorder(
                          side: BorderSide(
                              color: enableBorder
                                  ? borderColor ?? DesignColor.borderColor
                                  : borderColor ?? Colors.transparent)))
                      : MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                            color: enableBorder
                                ? borderColor ?? DesignColor.borderColor
                                : borderColor ?? Colors.transparent,
                          ),
                          borderRadius: borderRadius.circularBorder())),
                  foregroundColor:
                      ((textColor == null ? Colors.white : textColor)
                              .withOpacity(loading ? 0.6 : 1))
                          .materialColor(),
                  backgroundColor: enableBorder
                      ? (bgColor == null
                          ? transperent.materialColor()
                          : bgColor.materialColor())
                      : (bgColor == null
                          ? DesignColor.primary.materialColor()
                          : bgColor.materialColor())),
              onPressed: () {
                onTap();
              },
              child: loading
                  ? const CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ).applyVerticalPadding(padding: 8)
                  : Text(
                      this,
                      style: textStyle != null
                          ? textStyle.copyWith(
                              fontSize: fontsize ?? defaultFontSizeOf000Widget,
                              fontWeight: fontWeight)
                          : GoogleFonts.roboto(
                              fontSize: fontsize ?? defaultFontSizeOf000Widget,
                              fontWeight: fontWeight),
                    ).applyVerticalPadding(padding: inneerVertPad))
          .applyOpacityWithIgnore(ignore: ignore, opacity: opacity),
    );
  }

  Widget elButnStyleWithIcon({
    required VoidCallback onTap,
    Widget? leftIcon,
    Widget? rightIcon,
    bool fullWidth = true,
    bool enableBorder = false,
    Color? bgColor,
    bool flex = true,
    Color? textColor,
    double? fontsize,
    double? width,
    double vertPad = 8,
    double inneerVertPad = 14,
    double sidePad = 8,
    double borderRadius = 12,
    bool loading = false,
    Color splashColor = const Color.fromARGB(150, 255, 253, 253),
    bool fullRoundButton = false,
    Color? borderColor,
    double opacity = 0.5,
    bool ignore = false,
    EdgeInsetsGeometry? padding,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sidePad, vertical: vertPad),
      width: fullWidth ? (width ?? double.infinity) : null,
      child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(padding),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // Splash color when button is pressed
                        return splashColor; // Change color and opacity as needed
                      }
                      // Splash color when button is not pressed
                      return splashColor; //  Transparent splash color when button is not pressed
                    },
                  ),
                  shape: fullRoundButton
                      ? MaterialStateProperty.all(StadiumBorder(
                          side: BorderSide(
                              color: enableBorder
                                  ? bgColor ?? transperent
                                  : borderColor ?? Colors.transparent)))
                      : MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                            color: enableBorder
                                ? bgColor ?? transperent
                                : borderColor ?? Color(0xff999999),
                          ),
                          borderRadius: borderRadius.circularBorder())),
                  foregroundColor:
                      ((textColor == null ? Colors.white : textColor)
                              .withOpacity(loading ? 0.6 : 1))
                          .materialColor(),
                  backgroundColor: (bgColor == null
                      ? transperent.materialColor()
                      : bgColor.materialColor())),
              onPressed: () {
                onTap();
              },
              child: loading
                  ? const CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ).applyVerticalPadding(padding: 8)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (leftIcon != null) leftIcon,
                        Text(
                          this,
                          style: GoogleFonts.roboto(
                              fontSize: fontsize ?? defaultFontSizeOf000Widget,
                              fontWeight: fontWeight),
                        ).applyVerticalPadding(padding: inneerVertPad),
                        if (rightIcon != null) rightIcon,
                      ],
                    ))
          .applyOpacityWithIgnore(ignore: ignore, opacity: opacity),
    );
  }

  Widget elButnStyleBorderedButton({
    required VoidCallback onTap,
    bool fullWidth = true,
    bool flex = true,
    bool noBorder = false,
    bool fullRoundButton = false,
    double? fontsize,
    double? width,
    double vertPad = 8,
    double inneerVertPad = 0,
    double inneerSidePad = 0,
    double sidePad = 8,
    Color? overlayColor,
    Color? bgColor,
    Color? textColor,
    Color? borderColor,
    bool loading = false,
    double opacity = 0.5,
    bool ignore = false,
    Widget? leftIcon,
    Widget? rightIcon,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sidePad, vertical: vertPad),
      width: fullWidth ? (width ?? double.infinity) : null,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: inneerVertPad)),
            overlayColor: MaterialStateProperty.all(overlayColor),
            backgroundColor: (bgColor ?? Colors.transparent).materialColor(),
            shape: fullRoundButton
                ? MaterialStateProperty.all(StadiumBorder(
                    // borderRadius: 8.circularBorder(),
                    side: BorderSide(
                        color: noBorder
                            ? Colors.transparent
                            : borderColor ?? DesignColor.primary)))
                : MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: 8.circularBorder(),
                    side: BorderSide(
                        color: noBorder
                            ? Colors.transparent
                            : borderColor ?? DesignColor.primary)))),
        child: loading
            ? const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ).applyVerticalPadding(padding: 8)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leftIcon != null) leftIcon,
                  TextStyWidget(
                    text: this,
                    fontsize: fontsize ?? defaultFontSizeOf000Widget,
                    fontweight: fontWeight,
                    color: textColor ?? DesignColor.primary,
                  ),
                  if (rightIcon != null) rightIcon,
                ],
              ).applySymmetricPadding(
                vertical: inneerVertPad, horizontal: inneerSidePad),
      ).applyOpacityWithIgnore(ignore: ignore, opacity: opacity),
    );
  }

  Widget elTextButton({required VoidCallback onTap, double? fontsize}) {
    return TextButton(
        onPressed: onTap,
        child: TextStyWidget.black(
          text: this,
          fontsize: fontsize ?? w * 0.045,
          fontweight: FontWeight.w500,
        ));
  }
}
