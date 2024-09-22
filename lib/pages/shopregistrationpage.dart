import 'dart:io';

import 'package:groceryshopprices/lib.dart';

class ShopRegistrationPage extends StatefulWidget {
  const ShopRegistrationPage({super.key});

  @override
  State<ShopRegistrationPage> createState() => _ShopRegistrationPageState();
}

class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
  ShopModel? shopModel;
  TextEditingController nameC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController descrC = TextEditingController();

  List<File> images = [];
  bool showLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  Widget build(BuildContext context) {
    setupShopModel();
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
                    child: MultiSourceImageWidget(
                      defaultImgPath: "assets/appicon.png",
                      img: images.isNotEmpty ? images.first.path : "",
                      filePath: true,
                      size: w * 0.4,
                      roundRad: 20,
                      fit: BoxFit.contain,
                    ),
                  );
          }),
          gap10,
          lableAboveTextField("Shop Name*").alignLeft(),
          TextFieldBoxWidget(
            onChanged: (value) {
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
            hint: "Enter Description",
          ),
          "Register Shop".elButnStyle(
              onTap: () async {
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
              ignore: shopModel == null || showLoading)
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
