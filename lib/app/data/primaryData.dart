// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Produit {
//   late String libele;
//   late DateTime date_Exp;
//   late double prix_Vente;
//   Produit({
//     required this.libele,
//     required this.date_Exp,
//     required this.prix_Vente,
//   });
// }

// class Client {
//   late String nom;
//   late String tel;
//   Client({
//     required this.nom,
//     required this.tel,
//   });
// }

// class Commande {
//   late List<ProduitQuantite> produitsEtDate;
//   late DateTime dateDeCommande;
//   late int montantTotal;
//   Commande({
//     required this.produitsEtDate,
//     required this.dateDeCommande,
//     required this.montantTotal,
//   });
// }

// class Iventaire {
//   late List<ProduitQuantite> produitsEtQuantite;
//   late DateTime dateDeDecompte;
//   late int montantTotal;
//   Iventaire({
//     required this.produitsEtQuantite,
//     required this.dateDeDecompte,
//     required this.montantTotal,
//   });
// }

// class Dette {
//   late Client client;
//   late List<ProduitQuantiteDate> produitsEtQteEtDate;
//   late double montantTotal;
//   late double avance;
//   Dette({
//     required this.client,
//     required this.produitsEtQteEtDate,
//     required this.montantTotal,
//     required this.avance,
//   });
// }

// class ProduitQuantite {
//   late Produit produit;
//   late int quantite;
//   ProduitQuantite({
//     required this.produit,
//     required this.quantite,
//   });
// }

// class ProduitQuantiteDate {
//   late Produit produit;
//   late int quantite;
//   late DateTime date;
//   ProduitQuantiteDate({
//     required this.produit,
//     required this.quantite,
//     required this.date,
//   });
// }