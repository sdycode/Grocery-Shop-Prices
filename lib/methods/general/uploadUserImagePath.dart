// import 'dart:io';

// import 'package:groceryshopprices/lib.dart';

 
// Future uploadUserImagePath(String userPhoto) async {
//   printLog("photo 0 called $userPhoto");

//   if (userPhoto.isNotEmpty &&
//       userPhoto.contains("assets/") &&
//       myUsePro363Entity != null) {
//     myUsePro363Entity!.photoUrl = userPhoto;
//     updateUsePro363Entity(myUsePro363Entity!);
//   }
//   if (auth.currentUser != null) {
//     printLog("photo 1");
//     await auth.currentUser!.updatePhotoURL(userPhoto);
//     printLog("photo 2");

//     printLog("photo 3");

//     printLog(
//         " auth.currentUser!.photoURL != null ${auth.currentUser!.photoURL ?? "nophot"}");
//     // if (auth.currentUser != null && auth.currentUser!.photoURL != null) {}
//   }
// }

// unSetLocalImg() {
//   SharedPref.pref.setString(validUID, "");
// }

// void saveProfileImgToLocal(File? file) async {
//   if (validUID.isEmpty) {
//     return;
//   }
//   if (file != null) {
//     SharedPref.pref.setString(validUID, file.path);
//   }
// }

// String getLocalImage() {
//   if (validUID.isEmpty) {
//     return "";
//   }

//   return SharedPref.pref.getString(
//         validUID,
//       ) ??
//       "";
// }
