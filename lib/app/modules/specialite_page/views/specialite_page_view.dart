import 'package:ArielSchool/app/modules/home/controllers/details.dart';
// import 'package:ArielSchool/app/modules/specialite_page/controllers/specialite_page_controller.dart';
import 'package:flutter/material.dart';

// import 'package:/Apropos_detail.dart';
class specialite extends StatefulWidget {
  const specialite({super.key});

  @override
  State<specialite> createState() => _specialiteState();
}

class _specialiteState extends State<specialite> {
  List<Container>? movieOscar = [];

  var poster = [
    {
      "name": "SECRETARIAT BUREAUTIQUE",
      "photo": "et.jpg",
      "detail":
          " Secrétariat bureautique : Le secrétariat bureautique consiste à assurer des tâches administratives et de gestion courante au sein d'une entreprise. Les métiers associés à cette spécialité sont secrétaire et assistant administratif. Les avantages de ces métiers incluent la polyvalence des tâches et la possibilité d'évoluer vers des postes de gestion administrative."
    },
    {"name": "WEBMASTER", "photo": "et2.jpg", "detail": " "},
    {
      "name": "GENIE LOGICIEL",
      "photo": "et4.jpg",
      "detail":
          "Génie logiciel : Le génie logiciel est une spécialité qui concerne le développement de logiciels et de systèmes informatiques. Les métiers associés à cette spécialité sont développeur, ingénieur logiciel et analyste programmeur. Les avantages de ces métiers incluent un salaire attractif, la possibilité de travailler dans divers secteurs d'activité et une forte demande sur le marché du travail."
    },
    {
      "name": "COMPATABILIE ET GESTION",
      "photo": "et5.jpg",
      "detail":
          "Comptabilité et gestion : La comptabilité et la gestion concernent la tenue des comptes et la gestion financière d'une entreprise. Les métiers associés à cette spécialité sont comptable et contrôleur de gestion. Les avantages de ces métiers incluent la stabilité de l'emploi et la possibilité d'évoluer vers des postes de management. "
    },
    {
      "name": "SECRETARIAT BILINGUE",
      "photo": "et6.jpg",
      "detail":
          "Secrétariat bilingue : Le secrétariat bilingue implique la maîtrise de plusieurs langues pour assurer des tâches administratives dans un contexte international. Les métiers associés à cette spécialité sont secrétaire bilingue et assistant de direction bilingue. Les avantages de ces métiers incluent la maîtrise de plusieurs langues et l'ouverture à des opportunités internationales."
    },
    {"name": "SECRETARIAT COMPTABLE", "photo": "et7.jpg", "detail": " "},
    {"name": "SECRETARIAT MEDICAL", "photo": "et8.jpg", "detail": " "},
    {"name": "VENDEUR EN PHARMACIE", "photo": "et9.jpg", "detail": " "},
    {"name": "MAINTENANCE INFORMATIQUE", "photo": "et10.jpg", "detail": " "},
    {"name": "RESEAU INFORMATIQUE", "photo": "et3.png", "detail": " "},
    {
      "name": "GRAPHISME ET PRODUCTION",
      "photo": "et12.jpg",
      "detail":
          "Graphisme et production : Le graphisme et la production concernent la conception visuelle et la création de supports graphiques. Les métiers associés à cette spécialité sont graphiste et designer graphique. Les avantages de ces métiers incluent la créativité dans la conception visuelle et la possibilité de travailler en agence ou en freelance. "
    },
    {"name": "IWD", "photo": "et13.jpg", "detail": " "},
  ];

  buidList() async {
    for (var i = 0; i < poster.length; i++) {
      final gleinfo = poster[i];
      final String? imageposter = gleinfo['photo'];
      final String? details = gleinfo['detail'];
      int pourcent = 85 + i;

      movieOscar!.add(Container(
        padding: EdgeInsets.all(5.0),
        child: Card(
          elevation: 1.0,
          // color: Colors.transparent,

          child: ListView(
            children: <Widget>[
              Container(
                child: Hero(
                    tag: gleinfo,
                    child: Material(
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => showdetails(
                                      nomdetail: gleinfo['name']!,
                                      posterdetail: imageposter!,
                                      posterdetails: details!,
                                      like: pourcent,
                                    ))),
                        child: Container(
                          height: 210,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/$imageposter'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    )),
              ),
              Text(
                gleinfo['name']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    buidList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                //
              },
              icon: Icon(
                Icons.menu_book,
              ),
              iconSize: 40,
              color: const Color.fromARGB(255, 88, 0, 104))
        ],
        backgroundColor: Colors.black12,
        title: Title(
          color: Colors.white,
          child: Text('NOS SPECIALITES'),
        ),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: movieOscar!,
        ),
      ),
    );
  }
}
