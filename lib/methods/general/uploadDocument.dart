import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:groceryshopprices/lib.dart';
import 'package:path/path.dart' hide context;

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
  final destination = '$appnameForFirebase/${subpath??"subpath"}/$fileName';

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
