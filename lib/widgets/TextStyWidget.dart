// ignore_for_file: must_be_immutable

import 'package:groceryshopprices/lib.dart';

double get defaultFontSizeOf000Widget => w * 0.045;

class TextStyWidget extends StatelessWidget {
  final String text;
  final double? fontsize;
  final FontWeight fontweight;
  final Color color;
  final TextAlign align;
  final int maxLines;
  TextOverflow? overflow;
  TextStyle? font;
  String? fontFamily;
  bool? useGoogleFont;
  final bool? isUnderlined;
  bool? primary;
  FontStyle? fontStyle;
  Color? underLineColor;
  TextStyWidget({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.fontsize,
    this.fontweight = FontWeight.normal,
    this.overflow = TextOverflow.visible,
    this.font,
    this.isUnderlined,
    this.color = Colors.black,
    this.align = TextAlign.start,
    this.fontFamily,
    this.useGoogleFont = true,
    this.fontStyle = FontStyle.normal,
    this.underLineColor,
  });

  TextStyWidget.black({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.fontsize,
    this.fontweight = FontWeight.normal,
    this.font,
    this.isUnderlined,
    this.overflow = TextOverflow.visible,
    this.color = Colors.black,
    this.align = TextAlign.start,
    this.fontStyle = FontStyle.normal,
    this.useGoogleFont = true,
    this.fontFamily,
    this.underLineColor = Colors.black,
  });
  TextStyWidget.primary({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.fontsize,
    this.fontweight = FontWeight.normal,
    this.font,
    this.isUnderlined,
    this.overflow = TextOverflow.visible,
    this.color = DesignColor.primary,
    this.useGoogleFont = true,
    this.align = TextAlign.start,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.underLineColor = DesignColor.primary,
  });
  TextStyWidget.white({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.useGoogleFont = true,
    this.fontsize,
    this.fontweight = FontWeight.normal,
    this.font,
    this.overflow = TextOverflow.visible,
    this.isUnderlined,
    this.color = Colors.white,
    this.fontStyle = FontStyle.normal,
    this.align = TextAlign.start,
    this.fontFamily,
    this.underLineColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    TextStyle newfont =
        font ?? GoogleFonts.inter(fontStyle: fontStyle, fontWeight: fontweight);

    if (fontFamily != null) {
      font = TextStyle(fontFamily: fontFamily, fontStyle: fontStyle);
    }

    return Text(text,
        textAlign: align,
        maxLines: maxLines,
        style: font == null
            ? TextStyle(
                overflow: overflow,
                color: primary != null ? Colors.blue : color,
                fontSize: fontsize ?? defaultFontSizeOf000Widget,
                fontStyle: fontStyle,
                decorationColor: underLineColor,
                decoration:
                    isUnderlined == null ? null : TextDecoration.underline,
                fontWeight: fontweight)
            : newfont.copyWith(
                overflow: overflow,
                fontStyle: fontStyle,
                color: primary != null ? Colors.blue : color,
                decorationColor: underLineColor,
                decoration:
                    isUnderlined == null ? null : TextDecoration.underline,
                fontSize: fontsize ?? defaultFontSizeOf000Widget,
                fontWeight: fontweight));
  }
}
