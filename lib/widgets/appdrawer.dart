import 'package:groceryshopprices/lib.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateProvider up = context.getProvider();
    List<String> options = [
      isValidUser ? "Logout" : "Login",
    ];
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (validEmailId.isNotEmpty)
              TextStyWidget.primary(
                text: validEmailId,
                fontweight: FontWeight.w600,
                maxLines: 4,
              ).applySymmetricPadding(),
            ...List.generate(options.length, (i) {
              return BouncingBtn.fast(
                  child: TextStyWidget.black(
                    text: options[i],
                    fontsize: w * 0.05,
                    fontweight: FontWeight.w700,
                  ).applySymmetricPadding(horizontal: 20, vertical: 8),
                  onTap: () {
                    onTap(context, i);
                  });
            }),
            if (allMYShopsMap.isNotEmpty)
              ExpansionTile(
                title: TextStyWidget.black(
                  text: "Shops",
                  fontsize: w * 0.05,
                  fontweight: FontWeight.w700,
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: allMYShopsMap.length,
                      itemBuilder: (c, i) {
                        return ShopCheckCard(
                          shopIds:
                              allMYShopsMap.values.map((e) => e.id).toList(),
                          shop: allMYShopsMap.values.toList()[i],
                        );
                      })
                ],
              ),
            RequestCameListWidget()
          ],
        ).verticalScrollable(),
      ),
    );
  }

  onTap(BuildContext context, int i) async {
    switch (i) {
      case 0:
        if (isNOTValidUser) {
          exitOrAttemptExit(context);
          goToReplaceWithTransitionToScreen(context, StartLoginPage());
          return;
        }
        await showYesNoAlertDialog(context,
            noBgColor: DesignColor.primary,
            confirmMessage: "Do you really want to sign out?",
            onYesClicked: () async {
          await FirebaseAuth.instance.signOut();
          myCustomUser = null;

          exitOrAttemptExit(context);
          goToReplaceWithTransitionToScreen(context, StartLoginPage());
        });

        break;
      default:
    }
  }
}

class ShopCheckCard extends StatelessWidget {
  final ShopModel shop;
  final List<String> shopIds;
  const ShopCheckCard({
    Key? key,
    required this.shop,
    required this.shopIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateProvider up = context.getProvider();
    printLog("currentShopId ${myCustomUser != null}");
    return InkWell(
      onTap: () {
        goToScreenFor000(context, ShopDetailsPage(shop: shop));
      },
      onLongPress:
          (validEmailId.isNotEmpty && shop.primaryGmail == validEmailId)
              ? () async {
                  showYesNoAlertDialog(context,
                      confirmMessage: "Do you want to delete this shop?",
                      onYesClicked: () {
                    deleteShop(shop.id);
                  });
                }
              : null,
      child: Card(
        shape: 20.roundedCardShape(),
        child: Row(
          children: [
            // if (shop.images.isNotEmpty)
            //   CachedImageWidget(
            //       image: shop.images.first, width: w * 0.15, height: w * 0.15),
            if (shop.images.isNotEmpty)
              MultiSourceImageWidget(
                img: shop.images.first,
                size: w * 0.24,
                roundRad: 12,
              ).applyPadding(),
            Column(
              children: [
                TextStyWidget.black(
                  text: shop.name,
                  maxLines: 4,
                  fontweight: FontWeight.w700,
                ),
                "Edit".elButnStyle(
                    onTap: () {
                      exitOrAttemptExit000(context);
                      goToScreenFor000(context, ShopRegistrationPage(shop: shop));
                    },
                    sidePad: 12,
                    inneerVertPad: 2,
                    vertPad: 4),
              ],
            ).expandIfNeeded(),
            if (shopIds.length > 1)
              BouncingBtn.fast(
                child: Icon(currentShopId == shop.id
                        ? Icons.check_box
                        : Icons.check_box_outline_blank)
                    .applyPadding(padding: 12),
                onTap: () {
                  if (myCustomUser != null) {
                    if (myCustomUser!.currentShopId != shop.id) {
                      myCustomUser!.currentShopId = shop.id;
                      SharedPref.setString("currentShopId", shop.id);
                    }
                    up.update();
                  }
                },
              )
                  .applyOpacityWithIgnore(ignore: myCustomUser == null)
                  .applyRightPadding()
          ],
        ),
      ),
    );
  }
}

class RequestCameListWidget extends StatelessWidget {
  const RequestCameListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: getAllShopsStream(),
        builder: (context, snapshot) {
          return Column(
            children: [
              ...allMYShopsMap.values.map((shop) {
                Set<String> set = {};

                set.addAll(shop.requestedCameIds);
                if (set.isEmpty) {
                  return SizedBox();
                }
                return Card(
                  shape: 12.roundedCardShape(),
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (set.isNotEmpty)
                        Row(
                          children: [
                            if (shop.images.isNotEmpty)
                              MultiSourceImageWidget(
                                img: shop.images.first,
                                size: w * 0.24,
                                roundRad: 8,
                              ),
                            // TextStyWidget.primary(text: "Join Requests in shop")
                            //     .applyPadding(),
                            TextStyWidget.primary(
                              text: shop.name,
                              fontweight: FontWeight.w700,
                              fontsize: w * 0.045,
                              maxLines: 4,
                            ).applyPadding(),
                          ],
                        ).applyPadding(),
                      ...set.map((emailid) {
                        return Card(
                          shape: 12.roundedCardShape(),
                          elevation: 8,
                          child: Row(
                            children: [
                              TextStyWidget.black(
                                text: emailid,
                                maxLines: 4,
                                fontsize: w * 0.045,
                                fontweight: FontWeight.w500,
                              ).applyPadding().expandIfNeeded(),
                              "Accept".elButnStyle(
                                  onTap: () {
                                    shop.requestedCameIds.remove(emailid);
                                    shop.gmailIds.add(emailid);
                                    addShop(shop);
                                  },
                                  sidePad: 4,
                                  inneerVertPad: 0,
                                  vertPad: 2,
                                  fullWidth: false)
                            ],
                          ),
                        );
                      }).toList()
                    ],
                  ).applyPadding(),
                );
              }).toList(),
            ],
          );
        });
  }
}
