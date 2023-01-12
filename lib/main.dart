import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/controllers/bindings/authBinding.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
      0XFFA56FF8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      <int, Color>{
        50: Color(0xFFFBF8FF), //10%
        100: Color(0xFFF6F1FF), //20%
        200: Color(0xFFE9DBFE), //30%
        300: Color(0xFFDBC4FD), //40%
        400: Color(0xFFC09BFB), //50%
        500: Color(0xFFA56FF8), //60%
        600: Color(0xFF9363DD), //70%
        700: Color(0xFF634395), //80%
        800: Color(0xFF4B3270), //90%
        900: Color(0xFF302148) //100%
      });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        theme: ThemeData(
            scaffoldBackgroundColor: whiteColor,
            textTheme: const TextTheme(
                bodyMedium: TextStyle(fontFamily: 'JosefinSans')),
            primarySwatch: Palette.kToDark),
        home: HomePage());
  }
}
