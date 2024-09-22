import 'package:get/get.dart';

extension FormatStrings on String {
  String formatFirebasePath() {
    // List of disallowed characters in Firebase paths
    final RegExp disallowedChars = RegExp(r'[.#$/\[\]~*#?]');

    // Replace disallowed characters with underscore
    return this.replaceAll(disallowedChars, '_');
  }

  String replaceSpacesEithUnderScore() {
    return this.trim().replaceAll(" ", "_");
  }

  String formatSpacesAndForFirebasePath() {
    return this.replaceSpacesEithUnderScore().formatFirebasePath();
  }
}
