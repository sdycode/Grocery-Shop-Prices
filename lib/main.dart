import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryshopprices/lib.dart';
import 'package:groceryshopprices/pages/startloginpage.dart';
import 'package:groceryshopprices/providers/updateProvider.dart';

void main() async {
  // Started
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(RoutesWidget());  return;
  await SharedPref.init().then((value) {});

  try {
    await Firebase.initializeApp();
    FirebaseDatabase.instance.setPersistenceEnabled(true);

    printLog("firebase init success $validUID");
  } catch (e) {
    printLog("firebase init error $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UpdateProvider())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade100),
          useMaterial3: true,
        ),
        home: Builder(builder: (context) {
          setGlobalDimensions(context);
          loadMyUser();
          getAllShopsStream();
          // if(isValidUser)

          return isValidUser
              ? ShopListPage(
                  allowBack: false,
                )
              : StartLoginPage();
        }),
      ),
    );
  }
}
/*
export 'package:short_extensions/short_extensions.dart';
export 'package:image_picker/image_picker.dart';
export 'dart:convert';

export 'dart:math';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:provider/provider.dart';
export 'package:firebase_database/firebase_database.dart';
export 'package:flutter/services.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';

export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
*/