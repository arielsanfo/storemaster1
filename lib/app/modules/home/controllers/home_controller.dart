import 'package:ArielSchool/app/modules/specialite_page/views/specialite_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modalWidget.dart';
import 'package:ArielSchool/app/modules/commande_page/views/commande_page_view.dart';
import 'package:ArielSchool/app/modules/dette_page/views/dette_page_view.dart';
import 'package:ArielSchool/app/modules/inventaire_page/views/inventaire_page_view.dart';
// import 'package:ArielSchool/app/modules/login_page/views/login_page_view.dart';

import 'package:ArielSchool/app/modules/produit_page/views/produit_page_view.dart';

import 'package:ArielSchool/main.dart';

import '../../signup_page/views/signup_page_view.dart';

class HomeController extends GetxController {
  var seachController = TextEditingController().obs;
  ProduitStore produitController = ProduitStore(objectbox.store);
  IventaireStore inventaireController = IventaireStore(objectbox.store);

  List<HomeButton> menuItem = [
    HomeButton(
        id: 1,
        title: "Administration",
        urlImage: "assets/images/g6.jpg",
        actions: () {
          Get.to(() => CommandePageView(),
              transition: Transition.leftToRight,
              duration: Duration(milliseconds: 1000));
        }),
    HomeButton(
        id: 2,
        title: "Etudiants",
        urlImage: "assets/images/et3.png",
        actions: () {
          Get.to(() => ProduitPageView(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 1500));
        }),
    HomeButton(
        id: 3,
        title: "Inventaires",
        urlImage: "assets/images/inventaire.png",
        actions: () {
          Get.to(() => InventairePageView(),
              transition: Transition.topLevel,
              duration: Duration(milliseconds: 1500));
        }),
    HomeButton(
        id: 4,
        title: "Dettes/payements",
        urlImage: "assets/images/g2.jpg",
        actions: () {
          Get.to(() => DettePageView(),
              transition: Transition.circularReveal,
              duration: Duration(milliseconds: 1500));
        }),
    HomeButton(
        id: 5,
        title: "Apropos",
        urlImage: "assets/images/g4.jpg",
        actions: () {
          Get.to(() => SignupPageView(),
              transition: Transition.circularReveal,
              duration: Duration(milliseconds: 1000));
        }),
    HomeButton(
        id: 6,
        title: "Nos specialites",
        urlImage: "assets/images/g3.jpg",
        actions: () {
          Get.to(() => specialite(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 1000));
        }),
  ];

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
}
