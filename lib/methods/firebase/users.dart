import 'package:groceryshopprices/lib.dart';

Future updateCustomUser(CustomUser customUser) async {
  // printLog(      "users.uid ${customUser.uid} : ${customUser.name} img ${customUser.photoUrl}");

  final ref = FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("users")
      .child(customUser.uid);
  await ref.update(customUser.toMap());
}

registerNewUserIfNeeded(User user) async {
  CustomUser? customUser = await getCustomUser(user.uid);
  if (customUser == null) {
    await addCustomUser(user);
  }
}

Future addCustomUser(User user) async {
  CustomUser customUser = CustomUser(
      uid: user.uid,
      name: user.displayName ?? "Guest",
      photoUrl: user.photoURL ?? Pictures.random000ProfIcon,
      emailId: user.email ?? "",
      joinedShopIds: []);
  if (customUser.uid.trim().isEmpty) {
    return;
  }
  await updateCustomUser(customUser);
}

Future<CustomUser?> getCustomUser(String uid) async {
  final snap = await FirebaseDatabase.instance
      .ref()
      .child(appnameForFirebase)
      .child("users")
      .child(uid)
      .get();
  try {
    Map? map = snap.value as Map?;
    if (map != null) {
      CustomUser user = CustomUser.fromMap(map);
      return user;
    }
  } catch (e) {}

  return null;
}

loadMyUser() async {
  if (isValidUser) {
    myCustomUser = await getCustomUser(validUID);
    if (myCustomUser != null &&
        myCustomUser!.currentShopId != null &&
        myCustomUser!.currentShopId!.isNotEmpty) {
      setCurrentShopId(myCustomUser!.currentShopId!);
    }
  }
  printLog("ididdi ${getCurrentShopId()}");
}
