import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override 
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void clean() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  void performLogin() {
    print("login progess");
  }
}
