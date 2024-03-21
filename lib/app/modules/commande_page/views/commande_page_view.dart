import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/app/modules/home/views/home_view.dart';
import 'package:ArielSchool/main.dart';
// ignore: unused_import
import 'package:ArielSchool/objectbox.g.dart';

import '../controllers/commande_page_controller.dart';

// ignore: must_be_immutable
class CommandePageView extends GetView<CommandePageController> {
  CommandePageView({Key? key}) : super(key: key);

  var ctrl = Get.put(CommandePageController());
  Timer? _timer;
  IventaireStore inventaireController = IventaireStore(objectbox.store);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 145, 242, 236),
        appBar: AppBar(
          title: const Text('CommandePageView'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: Get.height * 0.80,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Column(
              children: [
                custom_Text("Nouvelle Commande", 18),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Color.fromARGB(255, 49, 49, 49),
                ),
                SizedBox(
                  height: 10,
                ),
                ctrl.produitChoisis.value.length != 0
                    ? Expanded(
                        // height: Get.height * 0.57,
                        child: Obx(() => ListView.builder(
                            itemCount: ctrl.produitChoisis.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProduitQuantite p =
                                  ctrl.produitChoisis.value[index];
                              //(p.produit.target!.prix_Vente);
                              double prixT =
                                  p.produit.target!.prix_Vente! * p.quantite!;
                              Padding(padding: EdgeInsets.all(20));
                              return Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    height: Get.height / 7,
                                    width: Get.width / 1.2,
                                    decoration: BoxDecoration(
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
                                            p.produit.target!.libele!, 20,
                                            fontWeight: FontWeight.bold),
                                        custom_Text(
                                            "Quantité : ${p.quantite} ", 18),
                                        custom_Text(
                                            "Montant : ${prixT} Fcfa", 18)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  custom_Icon(Icons.remove, ontap: () {
                                    ctrl.produitChoisis.value.remove(p);
                                    Get.to(CommandePageView());
                                  },
                                      color: white_Color,
                                      decoration: BoxDecoration(
                                          color: primary_Color,
                                          borderRadius:
                                              BorderRadius.circular(25)))
                                ],
                              );
                            })))
                    : Center(
                        child: custom_Text(
                            "Cliquer ci dessous pour ajouter un produit", 18,
                            align: TextAlign.center),
                      ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    custom_Button(
                      custom_Text("Ajouter un produit", 18,
                          color: primary_Color),
                      Get.width / 2,
                      () => {
                        if (ctrl.listeProduits.value.length == 0)
                          {
                            Messenger("Veuillez d'abord Crer un produit", true)
                                .display()
                          }
                        else
                          {
                            ctrl.qte.value = 1,
                            Get.defaultDialog(
                                title: "Ajouter un produit",
                                content: Container(
                                  width: Get.width,
                                  height: Get.height / 4,
                                  child: Column(
                                    children: [
                                      Obx(() {
                                        return Container(
                                            height: Get.height / 13,
                                            width: Get.width,
                                            child: CustomSelectProduit(
                                                options:
                                                    ctrl.listeProduits.value,
                                                selectedOption: ctrl
                                                    .listeProduits.value.first,
                                                onSelect: (value) {
                                                  ctrl.prodChoisi.value = value;
                                                  ctrl.choisi.value =
                                                      !ctrl.choisi.value;
                                                }));
                                      }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (ctrl.qte.value != 1) {
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
                                              () => custom_Text(
                                                  ctrl.qte.string, 22),
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          custom_Button(
                                              custom_Text("Annuler", 17,
                                                  color: white_Color,
                                                  fontWeight: FontWeight.bold),
                                              Get.width / 3, () {
                                            Get.back();
                                          }, true, shadows: true, height: 40),
                                          Spacer(),
                                          custom_Button(
                                              custom_Text("Valider", 17,
                                                  color: white_Color,
                                                  fontWeight: FontWeight.bold),
                                              Get.width / 3, () {
                                            //(ctrl.qte.string);
                                            print("object4");
                                            try {
                                              print("object2");
                                              ProduitQuantite p =
                                                  ProduitQuantite(
                                                quantite: ctrl.qte.value,
                                              );
                                              p.produit.target =
                                                  ctrl.prodChoisi.value;
                                              ctrl.produitChoisis.value.add(p);
                                              //   Get.back();
                                              Get.to(CommandePageView());

                                              Messenger("Produit ajouté", false)
                                                  .display();
                                            } catch (e) {
                                              print(e.toString());
                                              Messenger(e.toString(), true)
                                                  .display();
                                            }
                                          }, true, shadows: true, height: 40)
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          }
                      },
                      false,
                      height: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        custom_Button(
                            custom_Text("Annuler", 17,
                                color: white_Color,
                                fontWeight: FontWeight.bold),
                            Get.width / 3, () {
                          ctrl.produitChoisis.value.clear();
                          Get.back();
                        }, true, shadows: true, height: 40),
                        Spacer(),
                        custom_Button(
                            custom_Text("Valider", 17,
                                color: white_Color,
                                fontWeight: FontWeight.bold),
                            Get.width / 3, () async {
                          if (ctrl.produitChoisis.value.length != 0) {
                            try {
                              Commande c = Commande();
                              print("1");
                              c.dateDeCommande = DateTime.now();
                              print("2");
                              c.produitsEtDate
                                  .addAll(ctrl.produitChoisis.value);
                              print("3");
                              c.montantTotal = 0;
                              print("4");
                              ctrl.commandeController.ajouterCommande(c);
                              // ctrl.commandeController
                              //     .verifierProduitsEtAugmenterQuantite(c);
                              ctrl.commandeController
                                  .ajouterCommandeAInventaire(
                                      c,
                                      inventaireController
                                          .getAllIventaires()
                                          .first);

                              // for (var i = 0;
                              //     i <
                              //         inventaireController
                              //             .getAllIventaires()
                              //             .first
                              //             .produitsEtQuantite
                              //             .length;
                              //     i++) {
                              //   for (var j = 0;
                              //       j < c.produitsEtDate.length;
                              //       j++) {
                              //     if (inventaireController
                              //             .verifierProduitDansInventaire(c
                              //                 .produitsEtDate[j]
                              //                 .produit
                              //                 .target!
                              //                 .libele!) ==
                              //         true) {
                              //       ctrl.commandeController
                              //           .verifierProduitsEtAugmenterQuantite(c);

                              //       print(
                              //           "Le produit ${c.produitsEtDate[j].produit.target!.libele} existe, alors il a été mis a jours");
                              //       print(
                              //           "la nouvelle valeur est censé etre : ${ctrl.inventaireController.getAllIventaires().first.produitsEtQuantite.firstWhere((element) => element == c.produitsEtDate[j]).quantite!}");
                              //     } else {
                              //       var stock = inventaireController
                              //           .getAllIventaires()
                              //           .first;
                              //       stock
                              //         ..produitsEtQuantite
                              //             .add(c.produitsEtDate[j]);
                              //       inventaireController.modifierIventaire(stock);

                              //       print(
                              //           "le produit ${c.produitsEtDate[j].produit.target!.libele} n'existait pas, alors il a été ajouté");
                              //     }
                              //   }
                              // }
                              Get.back();
                              ctrl.produitChoisis.value.clear();
                              Get.to(() => HomeView());

                              Messenger("Commande ajouté avec Succès", false)
                                  .display();
                            } catch (e) {
                              Messenger(e.toString(), true).display();
                              print(e.toString());
                            }
                          } else {
                            Messenger("Ajouter au moins un produit", true)
                                .display();
                          }
                        }, true, shadows: true, height: 40)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _incrementCounter() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      ctrl.qte.value++;
    });
  }

  void _decrementCounter() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (ctrl.qte.value != 1) {
        ctrl.qte.value--;
      }
    });
  }

  void _stopCounter() {
    _timer?.cancel();
  }

  // ignore: unused_element
  _loadIntFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ctrl.inventaireID.value = prefs.getInt('inventaireIDKey') ?? 0;
    ctrl.inventaireFait.value = prefs.getBool('inventaireFait') ?? false;
    print(
        "lecture : la valeur de la l'inventaire faite est de ${ctrl.inventaireFait.value}");
  }

  // ignore: unused_element
  _saveIntToPrefs(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('inventaireIDKey', value);
    await prefs.setBool('inventaireFait', true);
    print(
        "insertion :la valeur de la l'inventaire faite est de ${ctrl.inventaireFait.value}");
  }
}
