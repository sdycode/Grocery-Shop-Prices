import 'dart:math';

import 'package:flutter/material.dart';
import 'package:groceryshopprices/lib.dart';

void setGlobalDimensions(BuildContext context) {
  h = MediaQuery.of(context).size.height;
  w = MediaQuery.of(context).size.width;
  // printLog("build h w $h : $w");
}

setGlobalDimensionsForOrientation(BuildContext context,
    {Orientation orientation = Orientation.landscape}) {
  double minSize = min(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

  double maxSize = max(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

  if (orientation == Orientation.landscape) {
    h = minSize;
    w = maxSize;
  } else {
    w = minSize;
    h = maxSize;
  }
  printLog("sizes for $orientation : $w : $h");
}

void initialiseSizesForLandscape(BuildContext context) {
  setGlobalDimensionsForOrientation(context,
      orientation: Orientation.landscape);
}

void initialiseSizesForPortrait(BuildContext context) {
  setGlobalDimensionsForOrientation(context, orientation: Orientation.portrait);
}
