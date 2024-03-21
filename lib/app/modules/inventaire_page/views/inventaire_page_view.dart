import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produitQte_Controller.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';
import '../controllers/inventaire_page_controller.dart';

// ignore: must_be_immutable
class InventairePageView extends GetView<InventairePageController> {
  InventairePageView({Key? key}) : super(key: key);
  ProduitQuantiteStore produitQuantiteStore =
      ProduitQuantiteStore(objectbox.store);
  IventaireStore inventaireStore = IventaireStore(objectbox.store);
  ProduitStore produitController = ProduitStore(objectbox.store);
  final inventaireEnCours = Iventaire().obs;
  var ctrl = Get.put(InventairePageController());
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_Color,
        title: const Text('Inventaire'),
        centerTitle: true,
        actions: [
          Container(
            child: InkWell(
                onTap: () {},
                child: custom_Icon(Icons.calendar_month, color: white_Color)),
          ),
          Container(
            decoration: BoxDecoration(
                color: white_Color, borderRadius: BorderRadius.circular(20)),
            child: InkWell(
                onTap: () {
                  if (ctrl.produitController.getAllProduit().length == 0) {
                    Messenger("Veuillez Crer un produit d'abord", true)
                        .display();
                  } else {
                    _loadIntFromPrefs();
                    Get.bottomSheet(
                        isDismissible: false,
                        Container(
                            height: Get.height / 1.2,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: white_Color,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Center(
                              child: custom_Button(
                                  custom_Text("Démmarer", 20,
                                      color: white_Color),
                                  Get.width / 2, () async {
                                demarrerInventaire();
                              }, true, shadows: true),
                            )));
                  }
                },
                child: custom_Icon(Icons.add, color: primary_Color)),
          ).paddingAll(12),
        ],
      ),
      body: Container(
          color: white_Color,
          padding: EdgeInsets.all(20),
          child: ctrl.updateInventaireList() == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: primary_Color,
                  strokeWidth: 8,
                )) // Affichez un indicateur de progression pendant le chargement des données
              : ListView.builder(
                  itemCount:
                      ctrl.inventaireController.getAllIventaires().length,
                  itemBuilder: ((context, index) {
                    Iventaire v =
                        ctrl.inventaireController.getAllIventaires().first;
                    double montant = ctrl.inventaireController
                        .calculerMontantTotalInventaire(v);

                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(10),
                      width: Get.width,
                      height: Get.height,
                      decoration: BoxDecoration(
                        color: white_Color,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: custom_Text(
                                "Inventaire du ${v.dateDeDecompte!.day}-${v.dateDeDecompte!.month}-${v.dateDeDecompte!.year} à ${v.dateDeDecompte!.hour}h:${v.dateDeDecompte!.minute}min",
                                20,
                                fontWeight: FontWeight.w600,
                                align: TextAlign.center),
                          ),
                          Divider(
                            height: 5,
                            color: black_Color,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          custom_Text(
                            "Montant Total: ${montant}  Fcfa",
                            20,
                          ),
                          Divider(
                            height: 5,
                            color: black_Color,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          custom_Text("Details :", 17),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: Get.height * 0.65,
                            child: ListView.builder(
                                itemCount: v.produitsEtQuantite.length,
                                itemBuilder: (context, index) {
                                  ProduitQuantite p =
                                      v.produitsEtQuantite[index];
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.all(10),
                                    height: Get.height / 7,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: white_Color,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(3, 3))
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: primary_Color)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        custom_Text(
                                            p.produit.target!.libele ?? "", 20,
                                            fontWeight: FontWeight.bold),
                                        custom_Text(
                                            "Quantité : ${p.quantite} ", 18),
                                        custom_Text(
                                            "Montant : ${p.produit.target!.prix_Vente! * p.quantite!} Fcfa",
                                            18)
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }))),
    );
  }

  _loadIntFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ctrl.inventaireID.value = prefs.getInt('inventaireIDKey') ?? 0;
    ctrl.inventaireFait.value = prefs.getBool('inventaireFait') ?? false;
    print(
        "lecture : la valeur de la l'inventaire faite est de ${ctrl.inventaireFait.value}");
  }

  _saveIntToPrefs(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('inventaireIDKey', value);
    await prefs.setBool('inventaireFait', true);
    print(
        "insertion :la valeur de la l'inventaire faite est de ${ctrl.inventaireFait.value}");
  }

  void showProductDetails(List<Produit> produits, int index) async {
    ctrl.qte.value = 0;
    if (index >= produits.length) {
      try {
        inventaireEnCours.value.dateDeDecompte = DateTime.now();

        _loadIntFromPrefs();
        if (ctrl.inventaireFait.value == false) {
          int idInventaire =
              await inventaireStore.ajouterIventaire(inventaireEnCours.value);
          _saveIntToPrefs(idInventaire);
          print("l'id du nouveau inventaire est : $idInventaire");
        } else {
          Iventaire? i =
              await inventaireStore.getIventaireById(ctrl.inventaireID.value);
          i!.dateDeDecompte = DateTime.now();
          i.produitsEtQuantite.clear();
          print("la taille du tableau est de ${i.produitsEtQuantite.length}");
          i.produitsEtQuantite
              .addAll(inventaireEnCours.value.produitsEtQuantite);
          print(
              "la taille du tableau  vaux maintenant ${i.produitsEtQuantite.length}");
          inventaireStore.modifierIventaire(i);

          print("l'id de l'invetaire qui a ete mis a jour est : ${i.id}");
        }

        Get.back();
        Messenger("Inventaire terminée", false).display();
      } catch (e) {
        Messenger(e.toString(), true).display();
      }
      return;
    }

    Produit p = produits[index];
    Get.bottomSheet(
      isDismissible: false,
      Container(
        height: Get.height / 1.5,
        width: Get.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: white_Color,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(95, 0, 0, 0),
                  offset: Offset(4, 4),
                  blurRadius: 7)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            custom_Text("Inventaire en Cours ...", 20),
            Divider(
              height: 5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 25,
            ),
            custom_Text(p.libele!, 26, fontWeight: FontWeight.bold),
            Divider(
              height: 5,
              color: black_Color,
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: Get.height / 14,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: primary_Color)),
              child: custom_Text("Prix: ${p.prix_Vente} Fcfa", 22),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: Get.height / 14,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: primary_Color)),
              child: Row(
                children: [
                  custom_Text(
                      "Date d'expiration : ${p.date_Exp!.day}-${p.date_Exp!.month}-${p.date_Exp!.year}",
                      22),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (ctrl.qte.value > 0) {
                        ctrl.qte.value--;
                      }
                    },
                    child: Listener(
                      onPointerDown: (_) {
                        // Commence à incrémenter lorsque le bouton est enfoncé
                        _decrementCounter();
                      },
                      onPointerUp: (_) {
                        // Arrête d'incrémenter lorsque le bouton est relâché
                        _stopCounter();
                      },
                      child: custom_Icon(
                        Icons.arrow_left,
                        color: primary_Color,
                        size: 60,
                      ),
                    ),
                  ),
                  Obx(
                    () => custom_Text(ctrl.qte.string, 42),
                  ),
                  InkWell(
                    onTap: () {
                      ctrl.qte.value++;
                    },
                    child: Listener(
                      onPointerDown: (_) {
                        // Commence à incrémenter lorsque le bouton est enfoncé
                        _incrementCounter();
                      },
                      onPointerUp: (_) {
                        // Arrête d'incrémenter lorsque le bouton est relâché
                        _stopCounter();
                      },
                      child: custom_Icon(
                        Icons.arrow_right,
                        color: primary_Color,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              child: custom_Button(
                  custom_Text("Suivant", 20, color: white_Color), Get.width / 2,
                  () async {
                print("etape 1");

                ProduitQuantite produitQuantite =
                    ProduitQuantite(quantite: ctrl.qte.value);
                print("etape 2");
                produitQuantite.produit.target = p;
                print("etape 3");
                await produitQuantiteStore
                    .ajouterProduitQuantite(produitQuantite);
                print("etape 4");
                inventaireEnCours.value.produitsEtQuantite.add(produitQuantite);
                Get.back();
                showProductDetails(produits, index + 1);
              }, true, shadows: true),
            ),
          ],
        ),
      ),
    );
  }

  void demarrerInventaire() async {
    print("1");
    List<Produit> produits = await produitController.getAllProduit();
    print("2");

    showProductDetails(produits, 0); // Commencez par le premier produit

    print("4");
    ctrl.listeInventaire.value =
        await ctrl.inventaireController.getAllIventaires();
  }

  void _incrementCounter() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      ctrl.qte.value++;
    });
  }

  void _decrementCounter() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (ctrl.qte.value > 0) {
        ctrl.qte.value--;
      }
    });
  }

  void _stopCounter() {
    _timer?.cancel();
  }
}
