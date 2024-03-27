import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import '../../login_page/views/login_page_view.dart';
import '../controllers/home_controller.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  var ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: custom_Text(
          "AFRICA-TECH",
          25,
          fontWeight: FontWeight.bold,
          color: white_Color,
        ),
        backgroundColor: primary_Color,
        centerTitle: true,
      ),
        bottomNavigationBar: Container(
          height: 68,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple], // Couleurs du dégradé
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.house,size: 35,),
                onPressed: () {},
                color: Colors.white,focusColor: red_Color,
              ),
              IconButton(
                icon: Icon(Icons.message,size: 35),
                onPressed: () {},
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.account_circle,size: 35),
                onPressed: () {},
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.favorite,size: 35),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
          ),
        ),
      
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple]
              ),
              // color: Color.fromARGB(196, 235, 235, 235),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      custom_TextFormField(ctrl.seachController.value,
                          Text("Rechercher"), "Effectuer une recherche",
                          suffixIcon: IconButton(
                              onPressed: () {
                                navigator?.push(MaterialPageRoute(
                                    builder: (context) => LoginPageView()));
                              },
                              icon: Icon(
                                Icons.tune,
                                color: black_Color,
                              ))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  color: Color.fromARGB(196, 235, 235, 235),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Get.height / 45,
                        mainAxisSpacing: Get.height / 35,
                      ),
                      itemCount: ctrl.menuItem.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ctrl.menuItem[index].id == 1
                              ? ctrl.inventaireController
                                          .getAllIventaires()
                                          .length >
                                      0
                                  ? ctrl.menuItem[index].actions
                                  : () {
                                      Messenger(
                                              "Veuillez faire d'abord un Inventaire",
                                              true)
                                          .display();
                                    }
                              : ctrl.menuItem[index].id == 4 ||
                                      ctrl.menuItem[index].id == 3
                                  ? ctrl.produitController
                                              .getAllProduit()
                                              .length >
                                          0
                                      ? ctrl.menuItem[index].actions
                                      : () {
                                          Messenger(
                                                  "Ajouter d'abord un/des etudiants(s)",
                                                  true)
                                              .display();
                                        }
                                  : ctrl.menuItem[index].actions,
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            decoration: BoxDecoration(
                                color: white_Color,
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                      color: primary_Color,
                                      offset: Offset(5, 5),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: Get.height / 10,
                                    width: Get.width / 4.5,
                                    child: Image.asset(
                                        ctrl.menuItem[index].urlImage!)),
                                Spacer(),
                                custom_Text(ctrl.menuItem[index].title!, 20,
                                    fontWeight: FontWeight.w500,
                                    color: black_Color)
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Nom Utilisateur'),
              accountEmail: Text('utilisateur@example.com'),
              currentAccountPicture: CircleAvatar(
                minRadius: 80,
                maxRadius: 80,
                backgroundImage: AssetImage('assets/images/et2.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () {
                // Navigator.pus
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.timelapse),
              title: Text('schedule'),
              onTap: () {
                //
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Statistiques'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
