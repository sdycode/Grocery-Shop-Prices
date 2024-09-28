import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:groceryshopprices/lib.dart';
import 'package:path/path.dart' hide context;

Future<bool> deleteImageFromFirebaseStorage(String link) async {
  try {
    // This is the path after 'o/' in the Firebase storage URL
    String filePath = link
        .replaceAll(
            "https://firebasestorage.googleapis.com/v0/b/grocery-shop-prices.appspot.com/o/",
            "")
        .replaceAll("%2F", "/");
    printLog("link ${filePath}");
    if (filePath.contains("?")) {
      filePath = filePath.split("?").first;
    }
    printLog("link ${filePath}");
    // 'groceryshopprices/subpath/imgid_1727513636382_compressed_image.jpg';
    // return false;
    // Get reference to the file in Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filePath);

    // Delete the file
    await ref.delete();
    printLog('Image deleted successfully.');
    return true;
  } catch (e) {
    printLog('Image deleted Error occurred while deleting the image: $e');
  }
  return false;
}

Future<String> uploadDocument(File? _photo,
    {BuildContext? context,
    String? subpath,
    ValueChanged<String>? uploadPostWhenImageAvailable,
    bool showAnySnackBar = true}) async {
  String url = "";
  if (_photo == null) return url;
  if (!(await internetAvaliable())) {
    if (showAnySnackBar) {
      triggerSnackbar("Please check internet connection");
    }

    return url;
  }
  final fileName = basename(_photo.path);
  final destination = '$appnameForFirebase/${subpath ?? "subpath"}/$fileName';

  try {
    final ref = FirebaseStorage.instance.ref(destination);
    UploadTask task = ref.putFile(_photo);
    printLog("imgLink task path ${task.snapshot.ref.fullPath}");
    try {
      final snapshot = await task.whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      if (downloadUrl.isNotEmpty && uploadPostWhenImageAvailable != null) {
        uploadPostWhenImageAvailable(downloadUrl);
      }
      // String downloadUrl = await task.snapshot.ref.getDownloadURL();
      printLog("imgLink upload $downloadUrl");

      return downloadUrl;
      // onTap(downloadUrl);
    } catch (e) {
      printLog("imgLink errore $e");
    }
  } catch (e) {
    print('error occured');
  }
  return url;
}
