import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zora/auth/auth.service.dart';
import 'package:zora/auth/signin_enum.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  RxBool isLogged = false.obs;
  TextEditingController emailController;
  TextEditingController passwordController;
  AuthService _authService;
  Rx<User> user = Rx<User>();

  AuthController() {
    _authService = AuthService();
  }

  @override
  void onReady() async {
    ever(user, handleAuthChanged);
    user.value = await _authService.getCurrentUser();
    user.bindStream(_authService.onAuthChanged());
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // super.onInit();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  handleAuthChanged(user) {
    if (user == null) {
      Get.toNamed("/welcome_page");
    } else {
      Get.offAndToNamed("/home");
    }
  }

  handleSignIn(SignInType type, TextEditingController emailController,
      TextEditingController passwordController) async {
    if (type == SignInType.EMAIL_PASSWORD) {
      if (emailController.text == "" || passwordController.text == "") {
        Get.snackbar("Error", "Empty email or password");
        return;
      }
    }
    Get.snackbar("Signing in ...", "loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 15));
    try {
      if (type == SignInType.EMAIL_PASSWORD) {
        await _authService.signInWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.message, actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Close'),
        ),
      ]);
      print(e);
    }
  }

  handleGoogleSignIn(SignInType type) async {
    Get.snackbar("Signing in ...", "loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 15));
    try {
      if (type == SignInType.GOOGLE) {
        await _authService.signInWithGoogle();
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.message, actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Close'),
        ),
      ]);
      print(e);
    }
  }

  handleSignUp(
    TextEditingController emailController,
    TextEditingController passwordController,
      String userType
  ) async {
    if (emailController.text == "" || passwordController.text == "") {
      Get.snackbar(
        "Error",
        "Empty email or password",
      );
      return;
    }

    Get.snackbar("Signing Up", "Loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    try {
      await _authService.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        userType
      );
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.message, actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Close"),
        ),
      ]);
      print(e);
    }
  }

  handleSignOut() {
    _authService.signOut();
  }
}
