import 'package:groceryshopprices/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;
  static Future init() async {
    pref = await SharedPreferences.getInstance();
    setUpUniqueUserIdForNonAuthincatedCustomUser();
  }

  static setString(String key, String value) {
    pref.setString(key, value);
  }

  static String getString(String key, String value) {
    return pref.getString(
          key,
        ) ??
        value;
  }

  static setInt(String key, int value) {
    pref.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return pref.getInt(
          key,
        ) ??
        defaultValue;
  }

  static setDouble(String key, double value) {
    pref.setDouble(key, value);
  }

  static double getDoubleValue(String key, String value) {
    return pref.getDouble(
          key,
        ) ??
        0.0;
  }

  static bool isOnboardDone() {
    return pref.getBool("onboard") ?? false;
  }

  static bool isOnboardRemaining() {
    return !isOnboardDone();
  }

  static void setOnboardDone({bool done = true}) {
    pref.setBool("onboard", done);
  }

  static double biggest() {
    return pref.getDouble("biggest") ?? 0;
  }

  static double shortest() {
    return pref.getDouble("shortest") ?? 0;
  }

  static bool isSizeInitialisationRequired() {
    bool sizeRequired = (biggest() <= 0 || shortest() <= 0);
    // printLog("build sizeRequired $sizeRequired");
    h = biggest();
    w = shortest();
    return sizeRequired;
  }

  static setbiggest(double value) {
    pref.setDouble("biggest", value);
  }

  static setshortest(double value) {
    pref.setDouble("shortest", value);
  }

  static setScreenSizes(BuildContext context) {
    printLog(
        "setScreenSizes called build ------------------------------------- ------------");
    double big = max(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    double small = min(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    h = big;
    w = small;
    setbiggest(big);
    setshortest(small);
  }
}

String getLocalImage() {
  if (validUID.isEmpty) {
    return "";
  }

  return SharedPref.pref.getString(
        validUID,
      ) ??
      "";
}

setCurrentShopId(String id) {
  SharedPref.setString("currentShopId", id);
}

String? getCurrentShopId() {
  return SharedPref.pref.getString("currentShopId");
}
