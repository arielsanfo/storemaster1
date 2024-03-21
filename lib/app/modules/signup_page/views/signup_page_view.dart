import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/modules/login_page/views/login_page_view.dart';
import '../controllers/signup_page_controller.dart';

// ignore: must_be_immutable
class SignupPageView extends GetView<SignupPageController> {
  SignupPageView({Key? key}) : super(key: key);

  var ctrl = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    ctrl.clean();
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: custom_Degrade(const Color.fromARGB(255, 120, 61, 221),
              Color.fromARGB(255, 21, 35, 157))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: Get.height / 20, right: Get.width / 10),
                child: Image.asset("assets/images/lock.png")),
            SizedBox(
              height: Get.height / 15,
            ),
            Container(
              height: Get.height / 2.5,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: white_Color, borderRadius: BorderRadius.circular(25)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 4,
                      child: Form(
                        key: ctrl.formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(
                                () => custom_TextFormField(
                                    ctrl.emailcontroller.value,
                                    Text("Email"),
                                    "Entrez votre Email",
                                    borderColor: white_Color),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => custom_TextFormField(
                                    ctrl.passwordcontroller.value,
                                    Text("Mots de passe"),
                                    "Entrez votre mots de passe",
                                    borderColor: white_Color),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    custom_Button(custom_Text("Crer", 20, color: white_Color),
                        Get.width / 2, () {
                      if (ctrl.formkey.currentState!.validate() == true) {
                        return controller.performSignUp();
                      }
                    }, true, shadows: true),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        custom_Text("Vous avez déja un compte ?", 15),
                        Spacer(),
                        custom_Button(
                            custom_Text("Se Conecter", 15,
                                color: primary_Color),
                            100, () {
                          Get.to(() => LoginPageView(),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 2000));
                        }, false, height: 20)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
