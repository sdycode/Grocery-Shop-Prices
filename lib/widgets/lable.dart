 import 'package:groceryshopprices/lib.dart';

Widget mainTitleInAnyPage(
  String text, {
  double? fontsize,
}) {
  return TextStyWidget.black(
    text: text,
    fontsize: fontsize ?? w * 0.056,
    fontweight: FontWeight.w700,
  );
}

Widget lableAboveTextField(String text) {
  return TextStyWidget.black(
    text: text,
    fontsize: w * 0.045,
    fontweight: FontWeight.w500,
  );
}
