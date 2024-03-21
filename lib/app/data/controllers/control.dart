// import 'package:ArielSchool/app/data/primaryData.dart';

// class ProduitService {
//   final box = ObjectBoxStore.boxFor<Produit>();

//   Future<int> ajouterProduit(Produit produit) async {
//     // Vérification des paramètres
//     if (produit.libele == null || produit.date_Exp == null || produit.prix_Vente == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produit);
//   }

//   Future<int> modifierProduit(Produit produit) async {
//     // Vérification des paramètres
//     if (produit.id == null || produit.libele == null || produit.date_Exp == null || produit.prix_Vente == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produit);
//   }

//   Future<bool> supprimerProduit(int id) async {
//     // Vérification des paramètres
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class DetteService {
//   final box = ObjectBoxStore.boxFor<Dette>();

//   Future<double> obtenirMontantTotal(int id) async {
//     // Vérification des paramètres
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     Dette dette = box.get(id);
//     return dette.montantTotal;
//   }
// }

// class ClientService {
//   final box = ObjectBoxStore.boxFor<Client>();

//   Future<int> ajouterClient(Client client) async {
//     if (client.nom == null || client.tel == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(client);
//   }

//   Future<int> modifierClient(Client client) async {
//     if (client.id == null || client.nom == null || client.tel == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(client);
//   }

//   Future<bool> supprimerClient(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class CommandeService {
//   final box = ObjectBoxStore.boxFor<Commande>();

//   Future<int> ajouterCommande(Commande commande) async {
//     if (commande.dateDeCommande == null || commande.montantTotal == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(commande);
//   }

//   Future<int> modifierCommande(Commande commande) async {
//     if (commande.id == null || commande.dateDeCommande == null || commande.montantTotal == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(commande);
//   }

//   Future<bool> supprimerCommande(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class IventaireService {
//   final box = ObjectBoxStore.boxFor<Iventaire>();

//   Future<int> ajouterIventaire(Iventaire iventaire) async {
//     if (iventaire.dateDeDecompte == null || iventaire.montantTotal == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(iventaire);
//   }

//   Future<int> modifierIventaire(Iventaire iventaire) async {
//     if (iventaire.id == null || iventaire.dateDeDecompte == null || iventaire.montantTotal == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(iventaire);
//   }

//   Future<bool> supprimerIventaire(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class DetteService {
//   final box = ObjectBoxStore.boxFor<Dette>();

//   Future<int> ajouterDette(Dette dette) async {
//     if (dette.montantTotal == null || dette.avance == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(dette);
//   }

//   Future<int> modifierDette(Dette dette) async {
//     if (dette.id == null || dette.montantTotal == null || dette.avance == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(dette);
//   }

//   Future<bool> supprimerDette(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class ProduitQuantiteService {
//   final box = ObjectBoxStore.boxFor<ProduitQuantite>();

//   Future<int> ajouterProduitQuantite(ProduitQuantite produitQuantite) async {
//     if (produitQuantite.quantite == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produitQuantite);
//   }

//   Future<int> modifierProduitQuantite(ProduitQuantite produitQuantite) async {
//     if (produitQuantite.id == null || produitQuantite.quantite == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produitQuantite);
//   }

//   Future<bool> supprimerProduitQuantite(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }

// class ProduitQuantiteDateService {
//   final box = ObjectBoxStore.boxFor<ProduitQuantiteDate>();

//   Future<int> ajouterProduitQuantiteDate(ProduitQuantiteDate produitQuantiteDate) async {
//     if (produitQuantiteDate.quantite == null || produitQuantiteDate.date == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produitQuantiteDate);
//   }

//   Future<int> modifierProduitQuantiteDate(ProduitQuantiteDate produitQuantiteDate) async {
//     if (produitQuantiteDate.id == null || produitQuantiteDate.quantite == null || produitQuantiteDate.date == null) {
//       throw Exception('Paramètres invalides');
//     }
//     return box.put(produitQuantiteDate);
//   }

//   Future<bool> supprimerProduitQuantiteDate(int id) async {
//     if (id == null) {
//       throw Exception('Paramètre invalide');
//     }
//     return box.remove(id);
//   }
// }