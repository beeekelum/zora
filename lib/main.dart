import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zora/auth/auth.controller.dart';
import 'package:zora/auth/auth.service.dart';
import 'package:zora/auth/model/user_obj.model.dart';
import 'package:zora/get_routes.dart';
import 'package:zora/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthController authController = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User>.value(value: FirebaseAuth.instance.authStateChanges()),
        ],
        child: StreamProvider<UserObject>.value(
        value: AuthService().user,
    child:  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZORA',
      theme: ThemeData(
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Calibri'),
      // home: WelcomePage(),
      initialRoute: '/welcome_page',
      getPages: AppRoutes.routes,
    ),
    ),);
  }
}
