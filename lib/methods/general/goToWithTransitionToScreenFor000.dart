import 'package:short_extensions/short_extensions.dart';

Future goToWithTransitionToScreenFor000(
    BuildContext context, Widget page) async {
  // Original function name: navigateWithTransitionToScreen
  return await Navigator.push(context, createSlideTransitionRoute(page));
}

Future goToReplaceWithTransitionToScreenFor000(
    BuildContext context, Widget page,
    {bool replace = true}) async {
  // Original function name: navigateReplaceWithTransitionToScreen
  if (replace) {
    return await Navigator.pushReplacement(
        context, createSlideTransitionRoute(page));
  } else {
    goToWithTransitionToScreenFor000(context, page);
  }
}
