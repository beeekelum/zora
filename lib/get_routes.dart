import 'package:get/get.dart';
import 'package:zora/auth/views/login.view.dart';
import 'package:zora/auth/views/register.view.dart';
import 'package:zora/home.view.dart';
import 'package:zora/profile/views/complete_profile.view.dart';
import 'package:zora/welcome_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/welcome_page', page: () => WelcomePage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/register/:user_type/view', page: () => RegisterPage()),
    GetPage(name: '/complete_profile', page: () => CompleteProfile()),
  ];
}
