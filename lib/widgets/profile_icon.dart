// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:groceryshopprices/lib.dart';

class ProfileIcon extends StatelessWidget {
  final double size;
  final bool withUserNameLetter;
  final bool isCircular;
  final bool singleColorIcon;
  final BoxFit fit;
  final double padding;
  final Color? color;

  const ProfileIcon({
    Key? key,
    this.size = 25,
    this.withUserNameLetter = false,
    this.isCircular = true,
    this.singleColorIcon = false,
    this.fit = BoxFit.contain,
    this.padding = 0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printLog("localphoto ${getLocalImage()}");
    return StreamBuilder<String>(
        stream: userPhotoStreamController.stream.asBroadcastStream(),
        builder: (c, snap) {
          String photoFromStream = snap.hasData ? snap.data! : "";
          // printLog(              "photo ${(isValidUser && isValidUserPhoto ? userPhotoUrl! : "dd")}");
          // printLog(              "photoFromStream $photoFromStream :${snap.hasData}  : ph ${userPhotoUrl!} ph");
          if (photoFromStream.isNotEmpty) {
            return MultiSourceImageWidget(
              localFileImg: getLocalImage().isNotEmpty,
              img: photoFromStream,
              size: size,
              color: color,
              isCircular: isCircular,
              defaultImgPath: defaultProflieIconPath,
              singleColorIcon: (photoFromStream == defaultProflieIconPath) ||
                  singleColorIcon,
            );
          }

          return MultiSourceImageWidget(
            localFileImg: getLocalImage().isNotEmpty,
            img: getLocalImage().isNotEmpty
                ? getLocalImage()
                : isValidUser && isValidUserPhoto
                    ? userPhotoUrl!
                    : "",
            size: size,
            padding: padding,
            isCircular: isCircular,
            defaultImgPath: defaultProflieIconPath,
            color: color,
            singleColorIcon:
                (photoFromStream == defaultProflieIconPath) || singleColorIcon,
          );
        });
  }
}

class MultiSourceImageWidget extends StatelessWidget {
  final String img;
  final String? defaultImgPath;
  final double size;
  final bool isCircular;
  final double roundRad;
  final BoxFit fit;
  final double padding;
  final Color? color;
  final bool singleColorIcon;
  final bool localFileImg;
  final File? imgFile;
  final Size? rectSize;
  final bool filePath;
  const MultiSourceImageWidget({
    Key? key,
    required this.img,
    this.defaultImgPath,
    required this.size,
    this.isCircular = false,
    this.roundRad = 0,
    this.fit = BoxFit.cover,
    this.padding = 0,
    this.color,
    this.singleColorIcon = false,
    this.localFileImg = false,
    this.imgFile,
    this.rectSize,
    this.filePath = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((localFileImg && img.isNotEmpty) || imgFile != null || filePath) {
      return Image.file(
        imgFile != null
            ? imgFile!
            : File(
                img,
              ),
        width: rectSize != null ? rectSize?.width : size,
        height: rectSize != null ? rectSize?.height : size,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            defaultImgPath ?? "",
            width: rectSize != null ? rectSize?.width : size,
            height: rectSize != null ? rectSize?.height : size,
            fit: fit,
          );
        },
      ).clipRounded(
        radius: isCircular ? size : roundRad,
      );
    }
    // printLog("mg.co ${img.contains('assets/')} : $img ");
    if (img.contains("assets/")) {
      return Image.asset(
        img,
        width: rectSize != null ? rectSize?.width : size,
        height: rectSize != null ? rectSize?.height : size,
        fit: fit,
        color: img == defaultProflieIconPath
            ? color
            : singleColorIcon
                ? color
                : null,

        // color ?? null,
        errorBuilder: (context, error, stackTrace) {
          // printLog("mg.coerr  $defaultImgPath ");
          return SquareImgWidget(
            img: defaultImgPath ?? Pictures.avt000,
            size: size,
            fit: defaultImgPath == null ? BoxFit.contain : fit,
            color: defaultImgPath == null
                ? color
                : img == defaultProflieIconPath
                    ? (color ?? DesignColor.secondary)
                    : singleColorIcon
                        ? (color ?? DesignColor.secondary)
                        : null,
          ).clipRounded(
            radius: isCircular ? size : roundRad,
          );
        },
      )
          .clipRounded(
            radius: isCircular ? size : roundRad,
          )
          .applyPadding(padding: padding);
    }
    // printLog("imgcache [${img}] : $singleColorIcon");
    return CachedImageWidget(
      padding: padding,
      image: img,
      width: size,
      height: size,
      fit: fit,
      radius: isCircular ? size : roundRad,
      errorWidget: Image.asset(
        img,
        width: size,
        height: size,
        fit: fit,
        color: img.isEmpty
            ? color
            : img == defaultProflieIconPath
                ? color
                : singleColorIcon
                    ? color
                    : null,
        errorBuilder: (context, error, stackTrace) {
          return SquareImgWidget(
            img: defaultImgPath ?? Pictures.avt000,
            size: size,
            fit: defaultImgPath == null ? BoxFit.contain : fit,
            color: img.isEmpty
                ? color
                : defaultImgPath == null
                    ? color
                    : img == defaultProflieIconPath
                        ? (color ?? DesignColor.secondary)
                        : singleColorIcon
                            ? (color ?? DesignColor.secondary)
                            : null,
          ).clipRounded(
            radius: isCircular ? size : roundRad,
          );
        },
      ).clipRounded(
        radius: isCircular ? size : roundRad,
      ),
    );
  }
}
