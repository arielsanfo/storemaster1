import 'package:objectbox/objectbox.dart';

@Entity()
class Produit {
  @Id()
  int? id;
  String? libele;
  double? tel;
  String? specialite;
  String? sexe;
  DateTime? date_naissance;

  @Property(type: PropertyType.date)
  DateTime? date_Exp;

  double? prix_Vente;

  Produit({
    this.id = 0,
    this.libele,
    this.tel,
    this.specialite,
    this.sexe,
    this.date_naissance,
    this.date_Exp,
    this.prix_Vente,
  });
}

@Entity()
class Client {
  @Id()
  int? id;
  String? nom;
  String? tel;

  Client({
    this.id = 0,
    this.nom,
    this.tel,
  });
}

@Entity()
class Commande {
  @Id()
  int? id;

  @Property(type: PropertyType.date)
  DateTime? dateDeCommande;

  int? montantTotal;

  Commande({
    this.id = 0,
    this.dateDeCommande,
    this.montantTotal,
  });

  final produitsEtDate = ToMany<ProduitQuantite>();
}

@Entity()
class Iventaire {
  @Id()
  int? id;

  @Property(type: PropertyType.date)
  DateTime? dateDeDecompte;
  int? montantTotal;

  Iventaire({
    this.id = 0,
    this.dateDeDecompte,
    this.montantTotal,
  });

  final produitsEtQuantite = ToMany<ProduitQuantite>();
}

@Entity()
class Dette {
  @Id()
  int? id;
  double? montantTotal;
  double? avance;

  Dette({
    this.id = 0,
    this.montantTotal,
    this.avance = 0,
  });
  final produitsEtQteEtDate = ToMany<ProduitQuantiteDate>();
  final client = ToOne<Client>();
}

@Entity()
class ProduitQuantite {
  @Id()
  int? id;
  int? quantite;

  ProduitQuantite({
    this.id = 0,
    this.quantite,
  });
  final produit = ToOne<Produit>();
}

@Entity()
class ProduitQuantiteDate {
  @Id()
  int? id;
  int? quantite;

  @Property(type: PropertyType.date)
  DateTime? date;

  ProduitQuantiteDate({
    this.id = 0,
    this.quantite,
    this.date,
  });

  final produit = ToOne<Produit>();
}
