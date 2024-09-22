import 'package:groceryshopprices/lib.dart';

deleteShop(String shopId) async {
  allShopsMap.remove(shopId);
  allMYShopsMap.remove(shopId);
  FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shops")
      .child(shopId)
      .remove();
}

requstShopToJoin(
  ShopModel shop,
) async {
  if (validEmailId.isNotEmpty) {
    shop.requestedCameIds.add(validEmailId);
    shop.requestedCameIds = shop.requestedCameIds.toSet().toList();
    await addShop(shop);
  }
}

addShop(ShopModel shop) async {
  final ref = FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shops")
      .child(shop.id);
  await ref.update(shop.toMap());
}

Future<ShopModel?> getShop(String id) async {
  final snap = await FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shops")
      .child(id)
      .get();
  try {
    Map? map = snap.value as Map?;
    if (map != null) {
      ShopModel shop = ShopModel.fromMap(map);
      bool amI = amIPartOfThisShop(shop);
      if (amI) {
        allMYShopsMap[shop.id] = shop;
      }
      allShopsMap[shop.id] = shop;
      return shop;
    }
  } catch (e) {}
  printLog("e");
  return null;
}

Stream<String> getAllShopsStream() {
  return FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("shops")
      .onValue
      .map((ev) {
    ev.snapshot.children.forEach((sn) {
      try {
        Map? map = sn.value as Map?;
        if (map != null) {
          ShopModel shop = ShopModel.fromMap(map);
          bool amI = amIPartOfThisShop(shop);
          if (amI) {
            allMYShopsMap[shop.id] = shop;
          }
          allShopsMap[shop.id] = shop;
        }
      } catch (e) {
        printLog("err $e");
      }
    });
    printLog(" ev.snapshot.children ${ev.snapshot.children.length}");

    if (myCustomUser != null && myCustomUser!.currentShopId != null) {
      setCurrentShopId(myCustomUser!.currentShopId!);
    } else {
      if (getCurrentShopId() == null && allMYShopsMap.isNotEmpty) {
        setCurrentShopId(allMYShopsMap.values.first.id);
        if (myCustomUser != null) {
          myCustomUser!.currentShopId = allMYShopsMap.values.first.id;
          updateCustomUser(myCustomUser!);
        }
      }
    }

    return "";
  });
}
