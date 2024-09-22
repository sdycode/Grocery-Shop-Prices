import 'package:flutter/material.dart';
import 'package:groceryshopprices/lib.dart';

BoxShadow get boxShadow => const BoxShadow(
    offset: Offset(0, 2), blurRadius: 4, spreadRadius: 2, color: Colors.grey);
BoxShadow get boxShadowSecondary => BoxShadow(
    offset: const Offset(0, 3),
    blurRadius: 2,
    spreadRadius: 1,
    color: DesignColor.secondary);

BorderRadiusGeometry topBorder =
    const BorderRadius.vertical(top: Radius.circular(30));
BoxDecoration get rent000BoxDecoration => BoxDecoration(
    color: DesignColor.primaryFaint,
    borderRadius: 12.circularBorder(),
    border: Border.all(color: DesignColor.tertiary2, width: 2));

BoxDecoration get rent000WHITEBoxDecoration => BoxDecoration(
    color: DesignColor.white,
    borderRadius: 12.circularBorder(),
    border: Border.all(color: DesignColor.tertiary2, width: 2));
OutlineInputBorder roundBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: DesignColor.primaryFaint, width: 1),
  borderRadius: 100.circularBorder(),
);
OutlineInputBorder roundFocusedBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: DesignColor.primary, width: 1),
  borderRadius: 100.circularBorder(),
);
OutlineInputBorder primaryBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: DesignColor.primaryFaint, width: 1.5),
  borderRadius: 12.circularBorder(),
);

Gradient get primaryGradient => const RadialGradient(
      radius: 0.9,
      colors: [Color(0xffFF6533), Color(0xff9E2B2B)],
    );

Gradient get auctionButtonGradient1 => const LinearGradient(
    colors: [Color(0xffDC4545), Color(0xffFED609)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft);

Gradient get auctionButtonGradient2 => const LinearGradient(colors: [
      Color.fromARGB(255, 26, 166, 10),
      Color.fromARGB(255, 167, 247, 93),
    ], begin: Alignment.topRight, end: Alignment.bottomLeft);
Gradient auctionButtonGradient1Light = const LinearGradient(colors: [
  Color.fromARGB(255, 243, 143, 143),
  Color.fromARGB(255, 246, 235, 179)
], begin: Alignment.topRight, end: Alignment.bottomLeft);
Gradient get auctionButtonPrimaryGradient => const LinearGradient(colors: [
      Color(0xff29527E),
      Color(0xff011E40),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
ShapeBorder bottomSheetShape({double rad = 40}) => RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(rad)));
ShapeBorder bottomSheetShap = const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(40)));

/// splash overlay color
MaterialStateProperty<Color?>? overlayColor(Color color,
    {bool isDark = false}) {
  Color themeColor = isDark ? Colors.black : Colors.white;
  return MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        // Splash color when button is pressed
        return (Color.lerp(color, themeColor, 0.4) ?? themeColor)
            .withAlpha(150); // Change color and opacity as needed
      }
      // Splash color when button is not pressed
      return (themeColor).withAlpha(
          50); //  Transparent splash color when button is not pressed
    },
  );
}
