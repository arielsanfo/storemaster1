import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/data/controllers/client_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';
import '../controllers/dette_page_controller.dart';

// ignore: must_be_immutable
class DettePageView extends GetView<DettePageController> {
  DettePageView({Key? key}) : super(key: key);

  ClientStore clientController = ClientStore(objectbox.store);
  var ctrl = Get.put(DettePageController());

  Timer? _timer;

  Container myBottomSheet() {
    return Container(
      height: Get.height / 1.2,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Color.fromARGB(255, 180, 226, 238),
            Color.fromARGB(143, 69, 221, 210),
          ]),
          color: white_Color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                custom_Text("Nouvelle dette", 18),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 2,
                  color: Color.fromARGB(255, 49, 49, 49),
                ),
                SizedBox(
                  height: 10,
                ),
                custom_Text("Choisir l'etudiant :", 20),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ctrl.clients.value.length == 0
                          ? custom_Text("Aucun Etudiant disponible", 16)
                          : Obx(() {
                              return CustomSelectClient(
                                  options: ctrl.clients.value,
                                  selectedOption: ctrl.clients.value.first,
                                  onSelect: (value) {
                                    ctrl.clientChoix.value =
                                        !ctrl.clientChoix.value;
                                    ctrl.clientChoisi.value = value;
                                  });
                            }),
                      Spacer(),
                      custom_Button(
                          custom_Text("Ajouter", 16, color: primary_Color),
                          Get.width / 5,
                          height: 30,
                          () => {
                                Get.defaultDialog(
                                    title: "Ajouter un Etudiant",
                                    content: Container(
                                      width: Get.width / 1.2,
                                      height: Get.height / 8,
                                      decoration: BoxDecoration(
                                          color: white_Color,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Column(
                                        children: [
                                          Form(
                                            key: ctrl.formKeyCustomer,
                                            child: custom_TextFormField(
                                                ctrl.customerController.value,
                                                custom_Text("Etudiant", 16),
                                                "Entrer le nom du nouveau Etudiant"),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              custom_Button(
                                                  custom_Text("Annuler", 17,
                                                      color: white_Color),
                                                  Get.width / 3, () {
                                                ctrl.customerController.value
                                                    .clear();
                                                Get.back();
                                              }, true, height: 30),
                                              Spacer(),
                                              custom_Button(
                                                  custom_Text("Valider", 17,
                                                      color: white_Color),
                                                  Get.width / 3, () {
                                                if (ctrl.formKeyCustomer
                                                        .currentState!
                                                        .validate() ==
                                                    true) {
                                                  Client c = Client(
                                                      nom: ctrl
                                                          .customerController
                                                          .value
                                                          .text,
                                                      tel: "");
                                                  try {
                                                    clientController
                                                        .ajouterClient(c);
                                                    Get.back();
                                                    ctrl.clients.value.add(c);
                                                    ctrl.customerController
                                                        .value
                                                        .clear();
                                                    Get.back();
                                                    Get.reload();
                                                    Messenger(
                                                            "Etudiant ajouté avec Succes",
                                                            false)
                                                        .display();
                                                  } catch (e) {
                                                    Messenger(
                                                            e.toString(), true)
                                                        .display();
                                                  }
                                                }
                                              }, true, height: 30),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              },
                          false)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: Get.height / 5,
                  child: ctrl.produitChoisis.value.length != 0
                      ? ListView.builder(
                          itemCount: ctrl.produitChoisis.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProduitQuantiteDate p =
                                ctrl.produitChoisis.value[index];
                            // (p.produit.target!.prix_Vente);
                            double prixT =
                                p.produit.target!.prix_Vente! * p.quantite!;
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
                                      custom_Text(p.produit.target!.libele!, 20,
                                          fontWeight: FontWeight.bold),
                                      custom_Text(
                                          "Niveau : ${p.quantite} ", 18),
                                      custom_Text("Montant : ${prixT} Fcfa", 18)
                                    ],
                                  ),
                                ),
                                Spacer(),
                                custom_Icon(Icons.remove, ontap: () {
                                  ctrl.produitChoisis.value.remove(p);
                                  Get.back();
                                  Get.bottomSheet(myBottomSheet());
                                },
                                    color: white_Color,
                                    decoration: BoxDecoration(
                                        color: primary_Color,
                                        borderRadius:
                                            BorderRadius.circular(25)))
                              ],
                            );
                          })
                      : Center(
                          child: custom_Text(
                              "Cliquer ci dessous pour ajouter un Etudiant", 18,
                              align: TextAlign.center),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                custom_Button(
                  custom_Text("Ajouter un Etudiant", 18, color: primary_Color),
                  Get.width / 2,
                  () => {
                    if (ctrl.listeProduits.value.length == 0)
                      {
                        Messenger("Veuillez ajouter un  Etudiant", true)
                            .display()
                      }
                    else
                      {
                        ctrl.qte.value = 1,
                        Get.defaultDialog(
                            title: "Ajouter un Etudiant",
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
                                            options: ctrl.listeProduits.value,
                                            selectedOption:
                                                ctrl.listeProduits.value.first,
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
                                          () =>
                                              custom_Text(ctrl.qte.string, 22),
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
                                          // if (ctrl.choisi == false) {
                                          //   print("object 1");
                                          //   ctrl.prodChoisi.value =
                                          //       ctrl.listeProduits.value.first;
                                          //   print("object 1");
                                          // }
                                          print("object2");
                                          ProduitQuantiteDate p =
                                              ProduitQuantiteDate(
                                                  quantite: ctrl.qte.value,
                                                  date: DateTime.now());
                                          p.produit.target =
                                              ctrl.prodChoisi.value;
                                          ctrl.produitChoisis.value.add(p);

                                          Get.back();
                                          Get.back();
                                          Get.bottomSheet(myBottomSheet());
                                          Messenger("Etudiant ajouté", false)
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
                            color: white_Color, fontWeight: FontWeight.bold),
                        Get.width / 3, () {
                      ctrl.produitChoisis.value.clear();
                      Get.back();
                    }, true, shadows: true, height: 40),
                    Spacer(),
                    custom_Button(
                        custom_Text("Valider", 17,
                            color: white_Color, fontWeight: FontWeight.bold),
                        Get.width / 3, () async {
                      if (ctrl.produitChoisis.value.length != 0) {
                        try {
                          //("1");
                          Dette d = Dette();
                          //("2");
                          // if (ctrl.clientChoix == false) {
                          //   ctrl.clientChoisi.value = ctrl.clients.value.first;
                          //   //("30");
                          // }
                          //("3");
                          d.client.target = ctrl.clientChoisi.value;
                          //("4");
                          d.produitsEtQteEtDate
                              .addAll(ctrl.produitChoisis.value);
                          //("5");
                          d.avance = 0;
                          //("6");
                          d.montantTotal =
                              ctrl.detteController.calculerMontantTotalDette(d);
                          //("7");
                          ctrl.detteController.ajouterDette(d);
                          Get.back();
                          ctrl.dettes.value.add(d);
                          Get.back();
                          Messenger("Dette ajouté avec Succès", false)
                              .display();
                        } catch (e) {
                          Messenger(e.toString(), true).display();
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
    );
  }

  ListView listerDette() {
    return ListView.builder(
        itemCount: ctrl.dettes.value.length,
        itemBuilder: (context, index) {
          Dette d = ctrl.dettes.value[index];
          return Container(
            margin: EdgeInsets.only(bottom: 25),
            height: Get.height / 2.5,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                 gradient: LinearGradient(colors: [
                                  const Color.fromARGB(255, 127, 197, 255),
                                  Color.fromARGB(255, 196, 243, 255),
                                  Color.fromARGB(143, 99, 255, 94),
                                ]),
                borderRadius: BorderRadius.circular(25),
                color: white_Color,
                boxShadow: [
                  BoxShadow(
                      color: red_Color, offset: Offset(4, 4), blurRadius: 10)
                ]),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        custom_Text(d.client.target!.nom!, 23,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        custom_Text(
                            "T: ${ctrl.detteController.calculerMontantTotalDette(d)}",
                            18),
                        Spacer(),
                        custom_Text("A: ${d.avance ?? 0}", 18),
                        Spacer(),
                        custom_Text(
                            "R: ${ctrl.detteController.calculerMontantTotalDette(d) - d.avance!}",
                            18),
                      ],
                    ))
                  ],
                ),
                Divider(
                  height: 5,
                  color: Color.fromARGB(255, 52, 52, 52),
                ),
                Row(
                  children: [
                    custom_Icon(Icons.shopping_bag,
                        color: primary_Color,
                        padding: EdgeInsets.only(right: 10)),
                    custom_Text("Etudiant :", 20)
                  ],
                ),
                Expanded(
                  child: afficherProduitDette(d),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    custom_Button(
                        custom_Text('Avancer', 16, color: white_Color),
                        Get.width / 4,
                        () => Get.defaultDialog(
                              title: "",
                              content: avancerDette(),
                              cancel: custom_Button(
                                custom_Text("Annuler", 16,
                                    color: primary_Color),
                                Get.width / 4,
                                () => Get.back(),
                                false,
                                height: 30,
                              ),
                              confirm: custom_Button(
                                  custom_Text("Confirmer", 16,
                                      color: primary_Color),
                                  Get.width / 4, () {
                                if (ctrl.formKeyAvance.currentState!
                                        .validate() ==
                                    true) {
                                  d.avance = d.avance! +
                                      double.parse(
                                          ctrl.avanceController.value.text);

                                  if (double.parse(
                                          ctrl.avanceController.value.text) <=
                                      0) {
                                    Messenger("Entrez une valeur superieur a 0",
                                            true)
                                        .display();
                                  } else {
                                    try {
                                      ctrl.detteController.modifierDette(d);
                                      ctrl.dettes.value.remove(d);

                                      Get.back();
                                      ctrl.dettes.value.add(d);
                                      Get.back();
                                      Messenger(
                                              "L'avance a bien été prise en compte",
                                              false)
                                          .display();
                                    } catch (e) {
                                      Messenger(e.toString(), true).display();
                                    }
                                  }
                                }
                              }, false, height: 30),
                            ),
                        true,
                        height: 30),
                    custom_Button(
                      custom_Text("Ajouter", 18, color: white_Color),
                      Get.width / 4,
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
                                contentPadding: EdgeInsets.all(5),
                                title: "Ajouter un produit",
                                content: ajouterProduitADetteExistante(d))
                          }
                      },
                      true,
                      height: 30,
                    ),
                    custom_Button(
                        custom_Text('Regler', 16, color: white_Color),
                        Get.width / 4,
                        () => Get.defaultDialog(
                              title: "Avertissement !",
                              content: avertissementAvantReglage(),
                              cancel: custom_Button(
                                custom_Text("Annuler", 16,
                                    color: primary_Color),
                                Get.width / 4,
                                () => Get.back(),
                                false,
                                height: 30,
                              ),
                              confirm: custom_Button(
                                  custom_Text("Confirmer", 16,
                                      color: primary_Color),
                                  Get.width / 4, () {
                                Get.back();

                                ctrl.dettes.value.remove(d);
                                ctrl.detteController.supprimerDette(d.id!);
                                Get.back();
                              }, false, height: 30),
                            ),
                        true,
                        height: 30),
                  ],
                ),
              ],
            ),
          );
        });
  }

  ListView afficherProduitDette(Dette d) {
    return ListView.builder(
        itemCount: d.produitsEtQteEtDate.length,
        itemBuilder: (context, index) {
          ProduitQuantiteDate p = d.produitsEtQteEtDate[index];
          double m = p.produit.target!.prix_Vente! * p.quantite!;
          return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            height: Get.height / 7,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: primary_Color)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                custom_Text(p.produit.target!.libele!, 20,
                    fontWeight: FontWeight.bold),
                custom_Text("Niveau : ${p.quantite}", 16),
                custom_Text("Scolarite : ${m} Fcfa", 16),
                custom_Text(
                    "Date : ${p.date!.day}-${p.date!.month}-${p.date!.year} ${p.date!.hour}:${p.date!.minute}",
                    16)
              ],
            ),
          );
        });
  }

  Container avertissementAvantReglage() {
    return Container(
      height: Get.height / 12,
      width: Get.width,
      child: custom_Text("Vous confirmez que cette dette a été reglé ?", 18,
          align: TextAlign.center),
    );
  }

  Container ajouterProduitADetteExistante(Dette d) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Container(
            height: Get.height / 13,
            width: Get.width,
            child: CustomSelectProduit(
                options: ctrl.listeProduits.value,
                selectedOption: ctrl.listeProduits.value.first,
                onSelect: (value) {
                  ctrl.prodChoisi.value = value;
                  ctrl.choisi.value = !ctrl.choisi.value;
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  () => custom_Text(ctrl.qte.string, 22),
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
                      color: white_Color, fontWeight: FontWeight.bold),
                  Get.width / 3, () {
                Get.back();
              }, true, shadows: true, height: 40),
              Spacer(),
              custom_Button(
                  custom_Text("Valider", 17,
                      color: white_Color, fontWeight: FontWeight.bold),
                  Get.width / 3, () {
                try {
                  if (ctrl.choisi == false) {
                    ctrl.prodChoisi.value = ctrl.listeProduits.value.first;
                  }
                  ProduitQuantiteDate p = ProduitQuantiteDate(
                      quantite: ctrl.qte.value, date: DateTime.now());
                  p.produit.target = ctrl.prodChoisi.value;
                  d.produitsEtQteEtDate.add(p);
                  try {
                    ctrl.detteController.modifierDette(d);
                    ctrl.dettes.value.remove(d);
                    Get.back();
                    ctrl.dettes.value.add(d);
                    Get.back();

                    Messenger("Etudiant ajouté", false).display();
                  } catch (e) {
                    Messenger(e.toString(), true).display();
                  }
                } catch (e) {
                  Messenger(e.toString(), true).display();
                }
              }, true, shadows: true, height: 40)
            ],
          )
        ],
      ),
    );
  }

  Container avancerDette() {
    return Container(
      height: Get.height / 7,
      width: Get.width,
      child: Form(
        key: ctrl.formKeyAvance,
        child: custom_TextFormField(ctrl.avanceController.value,
            custom_Text("Avance", 18), "Entrez le montant de l'avance",
            typeKeyboard: TextInputType.number),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary_Color,
        title: const Text('Gestion de dettes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              custom_TextFormField(ctrl.searchController.value,
                  Text("Rechercher"), "Recherche une dette"),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  custom_Icon(Icons.arrow_drop_down, color: primary_Color),
                  custom_Text("Liste de dettes", 20),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: ctrl.loadDettes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affiche un indicateur de chargement pendant le chargement des dettes
                  } else {
                    return Obx(
                      () => ctrl.dettes.value.length != 0
                          ? Container(
                              height: Get.height / 1.6,
                              child: listerDette(),
                            )
                          : Container(
                              height: Get.height / 1.7,
                              child: Center(
                                child:
                                    custom_Text("Aucune dettes Enregistré", 18),
                              ),
                            ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary_Color,
        onPressed: () {
          Get.bottomSheet(myBottomSheet());
        },
        child: custom_Icon(
          Icons.add,
        ),
      ),
    );
  }
}
