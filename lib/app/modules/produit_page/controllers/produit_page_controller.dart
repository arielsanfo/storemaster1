

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';

class ProduitPageController extends GetxController {
  ProduitStore produitController = ProduitStore(objectbox.store);
  var searchController = TextEditingController();
  var libelleController = TextEditingController();
  var prixController = TextEditingController();
  var telController = TextEditingController();
  var specialiteController = TextEditingController();
  var sexeController = TextEditingController();
  // var dateController = TextEditingController();
  // var dateNaissanceController = TextEditingController();
  DateTime? dateNaissance;
  DateTime? dateExpiration;
  RxList<Produit> produitsDispo = <Produit>[].obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    dateExpiration = DateTime.now();
    produitsDispo.addAll(produitController.getAllProduit());
  }

  void disposer() {
    libelleController.clear();
    prixController.clear();
    telController.clear();
    specialiteController.clear();
    sexeController.clear();
    // dateNaissanceController.clear();
    dateNaissance = DateTime.now();
    dateExpiration = DateTime.now();
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

enum Options { modifier, supprimer }
