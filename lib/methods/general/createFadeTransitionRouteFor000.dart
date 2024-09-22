import 'package:flutter/material.dart';

Route createFadeTransitionRouteFor000(Widget destinationPage,
    {int transitionTimeInMillisec = 800}) {
  // Original function name: transitionFadeRouteForNavigation
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: transitionTimeInMillisec),
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 0;
      const double end = 1;
      const curve = Curves.ease;

      var tween =
          Tween<double>(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}

Future goToWithFadeTransitionFor000(
    BuildContext context, Widget destinationPage,
    {int transitionTimeInMillisec = 800}) async {
  // Original function name: navigateWithFadeTransitionToScreen
  return await Navigator.push(
      context,
      createFadeTransitionRouteFor000(destinationPage,
          transitionTimeInMillisec: transitionTimeInMillisec));
}

Future goToAndReplaceWithFadeTransitionFor000(
    BuildContext context, Widget destinationPage,
    {int transitionTimeInMillisec = 800}) async {
  // Original function name: navigateWithFReplacedFadeTransitionToScreen
  return await Navigator.pushReplacement(
      context,
      createFadeTransitionRouteFor000(destinationPage,
          transitionTimeInMillisec: transitionTimeInMillisec));
}
