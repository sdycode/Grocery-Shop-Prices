// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:groceryshopprices/lib.dart';

class ShopRegistrationPage extends StatefulWidget {
  final ShopModel? shop;
  const ShopRegistrationPage({
    Key? key,
    this.shop,
  }) : super(key: key);

  @override
  State<ShopRegistrationPage> createState() => _ShopRegistrationPageState();
}

class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
  ShopModel? shopModel;
  TextEditingController nameC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController descrC = TextEditingController();
  ShopModel? shop;
  List<File> images = [];
  bool showLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  updateFieldsForExistingShop() {
    if (shop != null) {
      if (nameC.text.isNotEmpty) {
        shop!.name = nameC.text.trim();
        shop!.description = descrC.text.trim();
        shop!.city = cityC.text.trim();
      }
    }
  }

  setupShopModel() async {
    if (nameC.text.isNotEmpty &&
        images.isNotEmpty &&
        isValidUser &&
        validUser.email != null &&
        validUser.email!.isNotEmpty) {
      shopModel = ShopModel(
          id: "id",
          name: nameC.text,
          images: [],
          primaryGmail: validUser.email ?? "",
          ownerUid: validUID,
          gmailIds: [],
          requestedCameIds: []);
    }
  }

  bool loadingForImg = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shop = widget.shop;
    if (shop != null) {
      nameC.text = shop!.name;
      descrC.text = shop!.description;
      cityC.text = shop!.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shop == null) {
      setupShopModel();
    } else {
      updateFieldsForExistingShop();
    }
    printLog("ee ${shop != null} ${shop!.images.isNotEmpty} }");
    return Scaffold(
      appBar: appBarWidget(context: context, text: "Register Shop"),
      body: Column(
        children: [
          gap10,
          StatefulBuilder(builder: (context, state) {
            return loadingForImg
                ? CircularProgressIndicator.adaptive()
                    .placeInContainer(w * 0.4, w * 0.4)
                : BouncingBtn.fast(
                    onTap: () async {
                      await openSheet(
                        context,
                        (value) {
                          images.insert(0, value);
                          state(() {
                            loadingForImg = false;
                          });
                          setState(() {});
                        },
                        () {
                          state(() {
                            loadingForImg = true;
                          });
                        },
                      );
                    },
                    child: ((shop != null && shop!.images.isNotEmpty) &&
                            images.isEmpty)
                        ? CachedImageWidget(
                            image: shop!.images.first,
                            width: w * 0.4,
                            height: w * 0.4,
                            radius: 20,
                            fit: BoxFit.cover,
                          )
                        : MultiSourceImageWidget(
                            defaultImgPath: "assets/appicon.png",
                            img: images.isNotEmpty ? images.first.path : "",
                            filePath: true,
                            size: w * 0.4,
                            roundRad: 20,
                            fit: BoxFit.cover,
                          ),
                  );
          }),
          gap10,
          lableAboveTextField("Shop Name*").alignLeft(),
          TextFieldBoxWidget(
            onChanged: (value) {
              setState(() {});
            },
            onCleared: () {
              setState(() {});
            },
            normalBorderColor: transperent,
            withPrimaryBorder: false,
            controller: nameC,
            hint: "Enter Shop Name",
          ),
          lableAboveTextField("City").alignLeft(),
          TextFieldBoxWidget(
            onChanged: (value) {
              setState(() {});
            },
            onCleared: () {
              setState(() {});
            },
            normalBorderColor: transperent,
            withPrimaryBorder: false,
            controller: cityC,
            hint: "Enter City Name",
          ),
          lableAboveTextField("Description").alignLeft(),
          TextFieldBoxWidget(
            normalBorderColor: transperent,
            withPrimaryBorder: false,
            controller: descrC,
            onChanged: (value) {
              setState(() {});
            },
            onCleared: () {
              setState(() {});
            },
            hint: "Enter Description",
          ),
          (shop != null ? "Update" : "Register Shop").elButnStyle(
              onTap: () async {
                if (shop != null) {
                  if (await noInternetAvailable()) {
                    showNoInternetDialog(context);
                  }

                  String link = "";
                  if (images.isNotEmpty) {
                    link = await uploadDocument(images.first,
                        subpath: shopModel!.id);
                  }
                  if (link.isNotEmpty) {
                    shop!.images.insert(0, link);
                  }
                  await addShop(shop!);
                  triggerSnackbar("Shop details updated");

                  return;
                }
                if (shopModel != null) {
                  setState(() {
                    showLoading = true;
                  });
                  List<String> imageLinks = [];
                  await Future.forEach(images, (img) async {
                    String link =
                        await uploadDocument(img, subpath: shopModel!.id);
                    if (link.isNotEmpty) {
                      imageLinks.add(link);
                    }
                  });
                  if (imageLinks.isNotEmpty) {
                    String id = "shopid_${uniqueId}";
                    shopModel = shopModel!.copyWith(
                      id: id,
                      images: imageLinks,
                    );
                    printLog("id ${id}");
                    await addShop(shopModel!);
                  }

                  clearAll();
                  setState(() {
                    showLoading = false;
                  });
                }
              },
              loading: showLoading,
              ignore: shop != null
                  ? (nameC.text.isEmpty)
                  : shopModel == null || showLoading)
        ],
      ).verticalScrollable().applySymmetricPadding(),
    );
  }

  clearAll() {
    shopModel = null;
    nameC.clear();
    cityC.clear();
    descrC.clear();
  }
}

Future openSheet(BuildContext context, ValueChanged<File>? imgPicked,
    VoidCallback? update) async {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: 20.circularBorder()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        exitOrAttemptExit(context);
                        takeAndAddImage(
                            gallery: false,
                            imgPicked: imgPicked,
                            update: update);
                      },
                      icon: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            size: w * 0.12,
                            color: DesignColor.primary,
                          ),
                          TextStyWidget.primary(text: "Camera")
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        exitOrAttemptExit(context);
                        takeAndAddImage(
                            gallery: true,
                            imgPicked: imgPicked,
                            update: update);
                      },
                      icon: Column(
                        children: [
                          Icon(
                            Icons.photo,
                            size: w * 0.12,
                            color: DesignColor.primary,
                          ),
                          TextStyWidget.primary(text: "Gallery")
                        ],
                      ),
                    ),
                  ],
                ).applyVerticalPadding(padding: 20),
              ),
            ],
          );
        });
      });
}

takeAndAddImage(
    {bool gallery = true,
    ValueChanged<File>? imgPicked,
    VoidCallback? update}) async {
  File? tempimgFile = await pickImage(gallery: gallery);
  if (tempimgFile != null) {
    if (update != null) {
      update();
    }
    File compresed = await pickAndCompressImage(tempimgFile);

    if (imgPicked != null) {
      imgPicked(compresed);
    }
  }
}
