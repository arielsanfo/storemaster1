import 'package:get/get.dart';

import '../modules/commande_page/bindings/commande_page_binding.dart';
import '../modules/commande_page/views/commande_page_view.dart';
import '../modules/dette_page/bindings/dette_page_binding.dart';
import '../modules/dette_page/views/dette_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventaire_page/bindings/inventaire_page_binding.dart';
import '../modules/inventaire_page/views/inventaire_page_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/produit_page/bindings/produit_page_binding.dart';
import '../modules/produit_page/views/produit_page_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () =>  LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PAGE,
      page: () => SignupPageView(),
      binding: SignupPageBinding(),
    ),
    GetPage(
      name: _Paths.DETTE_PAGE,
      page: () => DettePageView(),
      binding: DettePageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUIT_PAGE,
      page: () => ProduitPageView(),
      binding: ProduitPageBinding(),
    ),
    GetPage(
      name: _Paths.INVENTAIRE_PAGE,
      page: () =>  InventairePageView(),
      binding: InventairePageBinding(),
    ),
    GetPage(
      name: _Paths.COMMANDE_PAGE,
      page: () =>  CommandePageView(),
      binding: CommandePageBinding(),
    ),
     GetPage(
      name: _Paths.AUTHENTIFICATION_PAGE,
      page: () =>  CommandePageView(),
      binding: CommandePageBinding(),
    ),
     GetPage(
      name: _Paths.SPECIALITE_PAGE,
      page: () =>  CommandePageView(),
      binding: CommandePageBinding(),
    ),
  
  ];
}
