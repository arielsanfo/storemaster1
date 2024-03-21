// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/data/modal.dart';

class Messenger {
  String? message;
  bool? error;
  Messenger(this.message, this.error);
  display() {
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 1),
      titleText: error == true
          ? custom_Text("Error", 20, color: white_Color)
          : custom_Text("Succes", 20, color: white_Color),
      messageText: custom_Text(message!, 18, color: white_Color),
      backgroundColor: error == true ? red_Color : green_Color,
    ));
  }
}

Gradient custom_Degrade(Color firstColor, Color secondColor,
    {AlignmentGeometry? begin, AlignmentGeometry? end}) {
  return LinearGradient(
      colors: [
        firstColor,
        secondColor,
      ],
      begin: begin != null ? begin : Alignment.topLeft,
      end: end != null ? end : Alignment.bottomRight,
      tileMode: TileMode.decal);
}

InkWell custom_Button(
  Widget label,
  double width,
  Function()? ontap,
  bool pleinButton, {
  double? height,
  EdgeInsetsGeometry? padding,
  Color? color,
  bool? shadows,
  Color? shadowsColor,
}) {
  color != null ? color = color : color = primary_Color;
  shadowsColor == null
      ? shadowsColor = Color.fromARGB(163, 45, 45, 45)
      : shadowsColor = shadowsColor;
  pleinButton == false ? shadows = false : null;

  return InkWell(
      onTap: ontap,
      child: Container(
        padding: padding != null ? padding : EdgeInsets.all(0),
        height: height != null ? height : 50,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: pleinButton == false ? color : color),
            borderRadius: BorderRadius.circular(25),
            color: pleinButton == true
                // ignore: unnecessary_null_comparison
                ? color != null
                    ? color
                    : primary_Color
                : Color.fromARGB(0, 207, 8, 8),
            boxShadow: shadows == true
                ? [
                    BoxShadow(
                        color: shadowsColor,
                        offset: Offset(7, 7),
                        blurStyle: BlurStyle.inner)
                  ]
                : null),
        child: Center(child: label),
      ));
}

Container custom_TextFormField(
  TextEditingController controller,
  Widget title,
  String hint, {
  TextInputType? typeKeyboard,
  Color? borderColor,
  EdgeInsetsGeometry? padding,
  Widget? suffixIcon,
}) {
  return Container(
    padding: padding != null ? padding : EdgeInsets.all(0),
    child: TextFormField(
      keyboardType: typeKeyboard != null ? typeKeyboard : TextInputType.text,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty || value == "") {
          return "Veuillez remplir ce champ";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hint,
          label: title,
          suffixIcon: suffixIcon != null ? suffixIcon : null,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 0.70,
                  color: borderColor != null ? borderColor : primary_Color),
              borderRadius: BorderRadius.circular(20))),
    ),
  );
}

Container custom_Text(
  String texte,
  double size, {
  Color? color,
  TextAlign? align,
  FontWeight? fontWeight,
  EdgeInsetsGeometry? padding,
}) {
  return Container(
    padding: padding != null ? padding : EdgeInsets.all(0),
    child: Text(
      texte,
      style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          color: color != null ? color : const Color.fromARGB(255, 33, 33, 33)),
      textAlign: align,
      softWrap: true,
    ),
  );
}

Container custom_Icon(IconData icon,
    {Color? color,
    Function()? ontap,
    double? size,
    EdgeInsetsGeometry? padding,
    Decoration? decoration}) {
  return Container(
    decoration: decoration,
    padding: padding != null ? padding : EdgeInsets.all(0),
    child: InkWell(
      onTap: ontap,
      child: Icon(
        icon,
        color: color != null ? color : white_Color,
        size: size != null ? size : 30,
      ),
    ),
  );
}

class CustomSelectProduit extends StatefulWidget {
  final List<Produit> options;
  final Produit selectedOption;
  final Function(Produit) onSelect;

  CustomSelectProduit(
      {required this.options,
      required this.selectedOption,
      required this.onSelect});

  @override
  _CustomSelectProduitState createState() => _CustomSelectProduitState();
}

class _CustomSelectProduitState extends State<CustomSelectProduit> {
  Produit _selectedOption = Produit();

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.5, color: primary_Color)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Produit>(
          value: _selectedOption,
          items: widget.options.map((Produit option) {
            return DropdownMenuItem<Produit>(
              value: option,
              child: Container(
                  width: Get.width / 1.5,
                  padding: EdgeInsets.all(5),
                  child: custom_Text(option.libele!.toUpperCase(), 18,
                      fontWeight: FontWeight.bold, )),
            );
          }).toList(),
          onChanged: (Produit? newValue) {
            setState(() {
              _selectedOption = newValue!;
              widget.onSelect(newValue);
            });
          },
        ),
      ),
    );
  }
}

class CustomSelectProduitQte extends StatefulWidget {
  final List<ProduitQuantite> options;
  final ProduitQuantite selectedOption;
  final Function(ProduitQuantite) onSelect;

  CustomSelectProduitQte(
      {required this.options,
      required this.selectedOption,
      required this.onSelect});

  @override
  _CustomSelectProduitQteState createState() => _CustomSelectProduitQteState();
}

class _CustomSelectProduitQteState extends State<CustomSelectProduitQte> {
  ProduitQuantite _selectedOption = ProduitQuantite();

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.5, color: primary_Color)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProduitQuantite>(
          value: _selectedOption,
          items: widget.options.map((ProduitQuantite option) {
            return DropdownMenuItem<ProduitQuantite>(
              value: option,
              child: Container(
                  width: Get.width / 1.5,
                  padding: EdgeInsets.all(5),
                  child: custom_Text(
                      option.produit.target!.libele!.toUpperCase(), 18,
                      fontWeight: FontWeight.bold)),
            );
          }).toList(),
          onChanged: (ProduitQuantite? newValue) {
            setState(() {
              _selectedOption = newValue!;
              widget.onSelect(newValue);
            });
          },
        ),
      ),
    );
  }
}

class CustomSelectClient extends StatefulWidget {
  final List<Client> options;
  final Client selectedOption;
  final Function(Client) onSelect;

  CustomSelectClient(
      {required this.options,
      required this.selectedOption,
      required this.onSelect});

  @override
  _CustomSelectClientState createState() => _CustomSelectClientState();
}

class _CustomSelectClientState extends State<CustomSelectClient> {
  Client _selectedOption = Client(nom: "", tel: "");

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.5,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.5, color: primary_Color)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Client>(
          value: _selectedOption,
          items: widget.options.map((Client option) {
            return DropdownMenuItem<Client>(
              value: option,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  option.nom!,
                  softWrap: true,
                ),
              ),
            );
          }).toList(),
          onChanged: (Client? newValue) {
            setState(() {
              _selectedOption = newValue!;
              widget.onSelect(newValue);
            });
          },
        ),
      ),
    );
  }
}

class CustomSelect extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelect;

  CustomSelect(
      {required this.options,
      required this.selectedOption,
      required this.onSelect});

  @override
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.5,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.5, color: primary_Color)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedOption,
          items: widget.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  option,
                  softWrap: true,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
              widget.onSelect(newValue);
            });
          },
        ),
      ),
    );
  }
}

Color primary_Color = Color(0xFF2E7D32);
Color red_Color = const Color.fromARGB(255, 216, 31, 18);
Color green_Color = Colors.green;
Color white_Color = Color(0xFFFFFFFF);

Color black_Color = Color.fromARGB(255, 2, 2, 2);
