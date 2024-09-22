import 'dart:async';

import 'package:groceryshopprices/lib.dart';
import 'package:uuid/uuid.dart';

DateTime get nowDTime => DateTime.now();
int get getCurrentTimeE => DateTime.now().millisecondsSinceEpoch;
const double leftRightPad = 12;
late double w = 200;
late double h = 200;
const appnameForFirebase = "groceryshopprices";
const appname = "Kirana Shop";
int random(int len) => Random().nextInt(len);
String get uniqueId =>
    "${Uuid().v1().replaceAll('-', '_').replaceAll(' ', '_')}_${Random().nextInt(500)}";
const String defaultProflieIconPath = Pictures.avt000;

double get profileImgSize => w * 0.3;
Widget get homePage => Homepage();
FirebaseAuth get auth => FirebaseAuth.instance;

User get validUser => auth.currentUser!;
bool get isValidUser => auth.currentUser != null;
bool get isValidUserPhoto =>
    auth.currentUser != null && auth.currentUser!.photoURL != null;
String get validEmailId => isValidUser ? validUser.email ?? "" : "";
String? get userPhotoUrl => auth.currentUser!.photoURL;
bool get isNOTValidUser => !isValidUser;
String get validUID =>
    isValidUser ? auth.currentUser!.uid : notAuthinticatedUniqueId;
bool get isGuestUser => auth.currentUser != null && validUser.isAnonymous;
String get notAuthinticatedUniqueId =>
    SharedPref.pref.getString("nonuserid") ?? uniqueId;

setUpUniqueUserIdForNonAuthincatedCustomUser() {
  if (SharedPref.pref.getString("nonuserid") == null) {
    SharedPref.pref.setString("nonuserid", uniqueId);
  }
}

/// app realted
const String rupee = "₹";
String get username => auth.currentUser == null
    ? ""
    : (auth.currentUser != null && auth.currentUser!.displayName != null)
        ? auth.currentUser!.displayName!
        : "Guest";
ShopModel? myShopModel;
String get todayDate => nowDTime.toDayMonthYearUnderscore();
String get currentShopId =>
    (myCustomUser != null && myCustomUser!.currentShopId != null)
        ? myCustomUser!.currentShopId!
        : "";
CustomUser? myCustomUser;
StreamController<String> usernameStreamController =
    StreamController<String>.broadcast();
StreamController<String> userPhotoStreamController =
    StreamController<String>.broadcast();
Map<String, List<String>> itemIdsMap = {};
Map<String, CustomUser> allProfileEntitiesMap = {};
Map<String, ShopModel> allShopsMap = {};
Map<String, ShopModel> allMYShopsMap = {};
bool amIOwnerOfThisShop(ShopModel shop) {
  if (validEmailId.isEmpty) {
    return false;
  }
  return (shop.primaryGmail == validEmailId);
}

bool amIPartOfThisShop(ShopModel shop) {
  if (validEmailId.isEmpty) {
    return false;
  }
  return (validEmailId.isNotEmpty &&
      (shop.primaryGmail == validEmailId ||
          shop.gmailIds.contains(validEmailId)));
}

bool isMyRequestPending(ShopModel shop) {
  printLog("validEmailId ${validEmailId}");
  if (validEmailId.isEmpty) {
    return true;
  }
  return (validEmailId.isNotEmpty &&
      (shop.requestedCameIds.contains(validEmailId)));
}
