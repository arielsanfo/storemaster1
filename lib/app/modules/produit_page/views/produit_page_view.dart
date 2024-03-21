import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/app/modules/home/views/home_view.dart';
import 'package:ArielSchool/main.dart';
import '../controllers/produit_page_controller.dart';

// ignore: must_be_immutable
class ProduitPageView extends GetView<ProduitPageController> {
  ProduitPageView({Key? key}) : super(key: key);

  var ctrl = Get.put(ProduitPageController());
  ProduitStore produitController = ProduitStore(objectbox.store);

  Container myBottomSheet(BuildContext context, bool? modif,
      {Produit? produitExistant}) {
    return Container(
      height: Get.height / 1.5,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Form(
          key: ctrl.formKey,
          child: Column(
            children: [
              custom_Text("Nouveau Etudiant", 18),
              SizedBox(
                height: 5,
              ),
              // Divider(
              //   height: 1,
              //   color: Color.fromARGB(255, 49, 49, 49),
              // ),
              SizedBox(
                height: 20,
              ),
              custom_TextFormField(ctrl.libelleController,
                  custom_Text("nom et prenom", 18), "Entrez le nom de etudiant",
                  typeKeyboard: TextInputType.name),
              SizedBox(
                height: 20,
              ),
              custom_TextFormField(ctrl.specialiteController,
                  custom_Text("Specialite", 18), "Entrez votre specialite",
                  typeKeyboard: TextInputType.name),
              SizedBox(
                height: 20,
              ),
              custom_TextFormField(ctrl.prixController,
                  custom_Text("Scolarite", 18), "Entrez le prix du produit",
                  typeKeyboard: TextInputType.number),
              SizedBox(
                height: 20,
              ),
              custom_TextFormField(ctrl.telController, custom_Text("tel", 18),
                  "Entrez le numero de telephone",
                  typeKeyboard: TextInputType.phone),
              SizedBox(
                height: 20,
              ),
              custom_TextFormField(ctrl.sexeController, custom_Text("tel", 18),
                  "Entrez le numero de telephone",
                  typeKeyboard: TextInputType.name),
              SizedBox(
                height: 20,
              ),
              // custom_TextFormField(ctrl.dateNaissance.hour, custom_Text("date", 18),
              //     "Entrez le numero de telephone",
              //     typeKeyboard: TextInputType.datetime),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  custom_Button(
                      custom_Text("choisir la date", 17,
                          color: white_Color, fontWeight: FontWeight.bold),
                      Get.width / 2.5, () async {
                    final DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050));
                    if (datePicked != null) {
                      ctrl.dateExpiration = datePicked;

                      Get.back();
                      Get.bottomSheet(myBottomSheet(context, false));
                    }
                  }, true, height: 40),
                  Spacer(),
                  Container(
                    height: 40,
                    width: Get.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: primary_Color),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: custom_Text(
                          "${ctrl.dateExpiration!.day}-${ctrl.dateExpiration!.month}-${ctrl.dateExpiration!.year}",
                          22),
                    ),
                  )
                ],
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
                    ctrl.disposer();
                    Get.back();
                  }, true, shadows: true, height: 40),
                  Spacer(),
                  custom_Button(
                      custom_Text("Valider", 17,
                          color: white_Color, fontWeight: FontWeight.bold),
                      Get.width / 3, () {
                    if (ctrl.formKey.currentState!.validate() == true) {
                      if (modif == true) {
                        produitExistant!.date_Exp = ctrl.dateExpiration;
                        produitExistant.date_naissance = ctrl.dateNaissance;
                        produitExistant.libele = ctrl.libelleController.text;

                        produitExistant.prix_Vente =
                            double.parse(ctrl.prixController.text);
                        produitExistant.tel =
                            double.parse(ctrl.telController.text);
                        produitExistant.specialite =
                            ctrl.specialiteController.text;

                        try {
                          produitController.modifierProduit(produitExistant);
                          ctrl.produitsDispo.remove(produitExistant);
                          ctrl.produitsDispo.add(produitExistant);
                          Get.back();
                          Messenger("Etudiant modifié avec Succès", false)
                              .display();
                          ctrl.disposer();
                        } catch (e) {
                          Messenger(e.toString(), true).display();
                        }
                      } else {
                        Produit p = Produit(
                          tel: double.parse(ctrl.telController.value.text),
                          sexe: ctrl.sexeController.value.text,
                          // date_naissance: ctrl.dateNaissanceController,
                          date_naissance: ctrl.dateNaissance,
                          libele:
                              ctrl.libelleController.value.text.toUpperCase(),
                          specialite: ctrl.specialiteController.value.text
                              .toUpperCase(),
                          date_Exp: ctrl.dateExpiration,
                          prix_Vente:
                              double.parse(ctrl.prixController.value.text),
                        );
                        try {
                          produitController.ajouterProduit(p);
                          ctrl.produitsDispo.add(p);
                          Get.back();
                          Messenger("Etudiant ajouté avec Succès", false)
                              .display();
                          ctrl.disposer();
                        } catch (e) {
                          Messenger(e.toString(), true).display();
                        }
                      }
                    }
                  }, true, shadows: true, height: 40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctrl.onInit;

    return Scaffold(
      backgroundColor: white_Color,
      appBar: AppBar(
        title: const Text('Gestion des inscriptions'),
        centerTitle: true,
        backgroundColor: primary_Color,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: custom_Icon(
          Icons.arrow_back,
          color: white_Color,
          ontap: () {
            Get.to(() => HomeView());
          },
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            custom_TextFormField(ctrl.searchController, Text("recherche"),
                "rechercher un produit",
                suffixIcon: IconButton(
                    onPressed: () async {
                      ctrl.produitsDispo.value = await produitController
                          .rechercherProduitsParNom(ctrl.searchController.text);
                      Get.reload();
                    },
                    icon: Icon(
                      Icons.search,
                      color: primary_Color,
                    ))),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                custom_Icon(Icons.arrow_downward, color: primary_Color),
                custom_Text("Liste des Etudiant inscripts", 18),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ctrl.produitsDispo.length != 0
                ? Expanded(
                    child: Obx(
                    () => ListView.builder(
                        itemCount: ctrl.produitsDispo.length,
                        itemBuilder: (BuildContext, int index) {
                          Produit p = ctrl.produitsDispo[index];
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Color.fromARGB(255, 180, 226, 238),
                                  Color.fromARGB(143, 69, 221, 210),
                                ]),
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.deepPurple,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(95, 121, 243, 14),
                                      offset: Offset(4, 4),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width / 2,
                                      child: custom_Text(p.libele!, 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: Get.width / 8,
                                      child: PopupMenuButton<Options>(
                                          icon: custom_Icon(Icons.more_vert,
                                              color: white_Color,
                                              decoration: BoxDecoration(
                                                  color: primary_Color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25))),
                                          itemBuilder: ((context) {
                                            return <PopupMenuEntry<Options>>[
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "Avertissement !",
                                                      content: Container(
                                                        width: Get.width,
                                                        height: Get.height / 10,
                                                        child: custom_Text(
                                                            " Etes vous sûr de vouloir supprimer cet etudiant ?",
                                                            20,
                                                            align: TextAlign
                                                                .center),
                                                      ),
                                                      cancel: custom_Button(
                                                          custom_Text(
                                                              "Annuler", 17,
                                                              color: black_Color,),
                                                          Get.width / 4,
                                                          () => Get.back(),
                                                          true,
                                                          shadows: true,
                                                          height: 30),
                                                      confirm: custom_Button(
                                                          custom_Text(
                                                              "Confirmer", 17,
                                                              color:
                                                                  white_Color),
                                                          Get.width / 4, () {
                                                        try {
                                                          produitController
                                                              .supprimerProduit(
                                                                  p.id!);
                                                          ctrl.produitsDispo
                                                              .remove(p);

                                                          Get.back();
                                                          Get.reload();

                                                          Messenger(
                                                                  "Etudiant supprimé avec Succès",
                                                                  false)
                                                              .display();
                                                        } catch (e) {
                                                          Messenger(
                                                                  e.toString(),
                                                                  true)
                                                              .display();
                                                        }
                                                      }, true,
                                                          shadows: true,
                                                          height: 30),
                                                    );
                                                  },
                                                  child: Container(
                                                      child: custom_Text(
                                                          "Supprimer", 18)),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: Container(
                                                    child: Container(
                                                        child: Container(
                                                  child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        ctrl.dateExpiration =
                                                            p.date_Exp;
                                                        ctrl.libelleController
                                                            .text = p.libele!;

                                                        ctrl.prixController
                                                                .text =
                                                            p.prix_Vente
                                                                .toString();
                                                        ctrl.telController
                                                                .text =
                                                            p.tel.toString();
                                                        ctrl.sexeController
                                                                .text =
                                                            p.sexe.toString();
                                                        ctrl.dateNaissance =
                                                            p.date_naissance;
                                                        ctrl.specialiteController
                                                                .text =
                                                            p.specialite!;
                                                        Get.bottomSheet(
                                                            myBottomSheet(
                                                                context, true,
                                                                produitExistant:
                                                                    p));
                                                      },
                                                      child: custom_Text(
                                                          "Modifier", 18)),
                                                ))),
                                              )
                                            ];
                                          })),
                                    ),
                                  ],
                                ),
                                custom_Text("Specialite: ${p.specialite} ", 20,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 7,
                                ),
                                custom_Text(
                                    "Scolarite: ${p.prix_Vente} Fcfa", 20,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 7,
                                ),
                                custom_Text("telephone: +237 ${p.tel} ", 20,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 7,
                                ),
                                custom_Text("Sexe: ${p.sexe}", 20,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 7,
                                ),
                                custom_Text(
                                    "Date de naissance: ${p.date_naissance} ",
                                    20,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 7,
                                ),
                                custom_Text(
                                    "Date d'inscription : ${p.date_Exp!.day}-${p.date_Exp!.month}-${p.date_Exp!.year}",
                                    20),
                              ],
                            ),
                          );
                        }),
                  ))
                : Container(
                    padding: EdgeInsets.only(top: Get.height / 3.4),
                    child: custom_Text(
                        "Aucun etudiant disponible, veuillez ajouter", 20,
                        align: TextAlign.center),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctrl.disposer();
          Get.bottomSheet(myBottomSheet(context, false));
        },
        backgroundColor: primary_Color,
        child: custom_Icon(Icons.add, color: white_Color),
      ),
    );
  }
}
