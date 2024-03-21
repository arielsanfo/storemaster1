import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  var emailcontroller = TextEditingController().obs;
  var passwordcontroller = TextEditingController().obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
    emailcontroller.value.clear();
    passwordcontroller.value.clear();
  }

  void clean() {
    emailcontroller.value.clear();
    passwordcontroller.value.clear();
  }

  void performSignUp() {
    print("signUp progess");
  }
}
