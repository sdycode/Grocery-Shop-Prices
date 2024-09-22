// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:groceryshopprices/lib.dart';

class ShopListPage extends StatefulWidget {
  final bool allowBack;
  const ShopListPage({
    Key? key,
    this.allowBack = false,
  }) : super(key: key);

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  final GlobalKey<ScaffoldState> sckey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isValidUser &&
          getCurrentShopId() != null &&
          getCurrentShopId()!.isNotEmpty) {
        ShopModel? shop = await getShop(getCurrentShopId()!);
        if (shop != null) {
          {
            try {
              if (mounted) {
                goToScreenFor000(context, ShopDetailsPage(shop: shop));
              }
            } catch (e) {}
          }
        }
        // return ShopDetailsPage(shop: shop);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return widget.allowBack;
      },
      child: Scaffold(
        key: sckey,
        endDrawer: AppDrawer(),
        appBar: appBarWidget(
            context: context,
            text: "Shops",
            enforceExit: false,
            backButton: widget.allowBack,
            trailingIcon: BouncingBtn.fast(
                child: Icon(
                  Icons.menu,
                  size: 25,
                ),
                onTap: () {
                  sckey.currentState!.openEndDrawer();
                }).applyPadding()),
        body: Column(
          children: [
            StreamBuilder<String>(
                stream: getAllShopsStream(),
                builder: (_, snap) {
                  if (allShopsMap.isEmpty) {
                    return Center(
                      child: TextStyWidget.black(text: "No Shops"),
                    );
                  }

                  // return FlutterLogo();
                  return ListView.builder(
                      itemCount: allShopsMap.length,
                      itemBuilder: (c, i) {
                        return ShopCard(
                          shop: allShopsMap.values.toList()[i],
                        );
                      });
                }).expandIfNeeded(),
            "Register New Shop".elButnStyle(onTap: () {
              goToScreenFor000(context, ShopRegistrationPage());
            }),
          ],
        ).applySymmetricPadding(),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final ShopModel shop;
  const ShopCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                size: w * 0.16,
                roundRad: 12,
              ).applyPadding(),
            TextStyWidget.black(
              text: shop.name,
              maxLines: 4,
              fontweight: FontWeight.w700,
            ).expandIfNeeded(),
            CircleAvatar(
                    radius: 8,
                    backgroundColor: amIOwnerOfThisShop(shop)
                        ? Colors.green
                        : (amIPartOfThisShop(shop) ? Colors.blue : Colors.red))
                .applyPadding()
          ],
        ),
      ),
    );
  }
}
