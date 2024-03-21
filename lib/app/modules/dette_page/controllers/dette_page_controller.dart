import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/controllers/client_Controller.dart';
import 'package:ArielSchool/app/data/controllers/dette_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/main.dart';
import 'package:ArielSchool/app/data/modal.dart';

class DettePageController extends GetxController {
  var avanceController = TextEditingController().obs;
  Rx<bool> choisi = false.obs;
  Rx<Client> clientChoisi = Rx<Client>(Client(nom: "Anonyme", tel: ""));
  Rx<bool> clientChoix = false.obs;
  ClientStore clientController = ClientStore(objectbox.store);
  var clients = Rx<List<Client>>([]);
  var customerController = TextEditingController().obs;
  DetteStore detteController = DetteStore(objectbox.store);
  var dettes = Rx<List<Dette>>([]);
  final formKeyAvance = GlobalKey<FormState>();
  final formKeyCustomer = GlobalKey<FormState>();
  final formKeyGlobal = GlobalKey<FormState>();
  var listeProduits = Rx<List<Produit>>([]);
  Rx<Produit> prodChoisi = Rx<Produit>(Produit());
  var produitChoisis = Rx<List<ProduitQuantiteDate>>([]);
  ProduitStore produitController = ProduitStore(objectbox.store);
  Rx<int> qte = 1.obs;
  var searchController = TextEditingController().obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    final box = objectbox.store.box<Client>();
    clients.value = box.getAll();
    listeProduits.value = produitController.getAllProduitOrder();
    dettes.value = await detteController.getAllDettes();
    prodChoisi.value = listeProduits.value.first;
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> loadDettes() async {
    dettes.value = await detteController.getAllDettes();
  }
}
