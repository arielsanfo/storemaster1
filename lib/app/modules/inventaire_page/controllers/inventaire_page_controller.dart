import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';

class InventairePageController extends GetxController {
  var quantiteController = TextEditingController().obs;
  ProduitStore produitController = ProduitStore(objectbox.store);
  IventaireStore inventaireController = IventaireStore(objectbox.store);
  Rx<int> qte = 0.obs;
  Rx<bool> inventaireFait = false.obs;
  Rx<int> inventaireID = 0.obs;
  var listeInventaire = Rx<List<Iventaire>>([]);
  @override
  void onInit() async {
    super.onInit();
    updateInventaireList();
  }

  Future<void> updateInventaireList() async {
    listeInventaire.value = await inventaireController.getAllIventaires();
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
