import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/controllers/commande_Controller.dart';
import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produitQte_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';

class CommandePageController extends GetxController {
  CommandeStore commandeController = CommandeStore(objectbox.store);
  final formKeyAvance = GlobalKey<FormState>();
  final formKeyCustomer = GlobalKey<FormState>();
  final formKeyGlobal = GlobalKey<FormState>();
  var listeProduits = Rx<List<Produit>>([]);
  Rx<Produit> prodChoisi = Rx<Produit>(Produit());
  var produitChoisis = Rx<List<ProduitQuantite>>([]);
  ProduitQuantiteStore produitQteController =
      ProduitQuantiteStore(objectbox.store);
  IventaireStore inventaireController = IventaireStore(objectbox.store);
  ProduitStore produitController = ProduitStore(objectbox.store);
  Rx<int> qte = 1.obs;
  Rx<int> inventaireID = 0.obs;
  Rx<bool> inventaireFait = false.obs;
  var searchController = TextEditingController().obs;
  Rx<bool> choisi = false.obs;
  var listeInventaire = Rx<List<Iventaire>>([]);

  @override
  void onInit() async {
    super.onInit();
    listeInventaire.value = await inventaireController.getAllIventaires();
    listeProduits.value = await produitController.getAllProduitOrder();
    prodChoisi.value = listeProduits.value.first;
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
