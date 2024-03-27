import 'package:flutter/material.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
class showdetails extends StatelessWidget {
  final String nomdetail, posterdetail,posterdetails;
  final int like;
  const showdetails(
      {super.key,
      required this.nomdetail,
      required this.posterdetail,
      required this.posterdetails,

      required this.like});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:5,
        actions: [IconButton(onPressed: () {},
         icon: Icon(Icons.details,),iconSize: 30,color: const Color.fromARGB(255, 88, 0, 104))],
        title: Center(
          child: Text(
            nomdetail,
            style: TextStyle( fontSize: 30),
          ),
        ),
        backgroundColor:primary_Color,
      ),
      body: ListView(
        children: <Widget>[
        Container(
          width: 150,
          height: 400,
          
          // color: Colors.amberAccent,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/$posterdetail',
                  ),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.perm_device_information,
                          color: const Color.fromARGB(255, 40, 0, 47),
                          size: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'hello',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                   
                        Text(
                          '$like% ',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),

                        ),
                         SizedBox(
                          width: 50,
                        ),
                        Icon(
                          Icons.thumb_up,
                          color: const Color.fromARGB(255, 88, 0, 104),
                          size: 40,
                        ),
                         Icon(
                          Icons.star,
                          color:  Colors.yellow,
                          size: 40,
                        ),
                          Icon(
                          Icons.star,
                          color:  Colors.yellow,
                          size: 40,
                        ),
                      ],
                    )
                  ],
                ),
              ),
               Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text( posterdetails,
                        style: TextStyle(fontSize: 25, ),),
                      
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // Text('Génie logiciel : Le génie logiciel est une spécialité qui concerne le développement de logiciels et de systèmes informatiques. Les métiers associés à cette spécialité sont développeur, ingénieur logiciel et analyste programmeur. Les avantages de ces métiers incluent un salaire attractif, la possibilité de travailler dans divers secteurs dactivité et une forte demande sur le marché du travail',
                        // style: TextStyle(fontSize: 25, ),),
                      
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ]
      ),
      
  
    );
  }
}
