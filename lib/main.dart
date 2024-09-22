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
