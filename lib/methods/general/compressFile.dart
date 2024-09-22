// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:groceryshopprices/lib.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
// The parameter class to hold the file path and the compressed image path
import 'dart:io';

class CompressImageParams {
  String imgFilePath;
  String compressedImagePath;

  CompressImageParams(this.imgFilePath, this.compressedImagePath);
}

// This function will run inside the isolate
Future<CompressImageParams> compressImageInIsolate(
    CompressImageParams params) async {
  try {
    final imgFile = File(params.imgFilePath);
    final bytes = await imgFile.readAsBytes();
    final image = img.decodeImage(Uint8List.fromList(bytes));

    // Compress the image to reduce size
    final compressedImage =
        img.encodeJpg(image!, quality: 30); // Adjust quality as needed

    // Save the compressed image to a temporary directory

    final compressedFile = File(params.compressedImagePath);

    await compressedFile.writeAsBytes(compressedImage);

    params.compressedImagePath = compressedFile.path;

    return params;
  } catch (e) {
    printLog("Error during image compression: $e");
    return params; // Return original image path in case of error
  }
}

Future<File?> pickImage({bool gallery = true}) async {
  final pickedFile = await ImagePicker()
      .pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);

  if (pickedFile != null) {
    File _image = File(pickedFile.path);
    return _image;
  }
  return null;
}

Future<File> pickAndCompressImage(File imgFile) async {
  printLog('Image sizes before');
  final tempDir = await getTemporaryDirectory();
  final compressedImagePath =
      '${tempDir.path}/imgid_${DateTime.now().millisecondsSinceEpoch}_compressed_image.jpg';

  CompressImageParams params =
      CompressImageParams(imgFile.path, compressedImagePath);
  params = await compute(compressImageInIsolate, params);
  final orgImageSize = await (getFileSizeInMB(imgFile.path));
  File compressedFile = File(params.compressedImagePath);
  final compressedImageSize = await (getFileSizeInMB(compressedFile.path));

  printLog(
      'Image sizes in after { ${compressedImageSize.toStringAsFixed(1)} / ${orgImageSize.toStringAsFixed(1)} MB scale : ${(orgImageSize / compressedImageSize).toStringAsFixed(1)} } compressed and saved at: ');

  return compressedFile;
}

Future<double> getFileSizeInMB(String filePath) async {
  File file = File(filePath);
  int fileSizeInBytes = await file.length();
  double fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert bytes to MB
  return fileSizeInMB;
}
