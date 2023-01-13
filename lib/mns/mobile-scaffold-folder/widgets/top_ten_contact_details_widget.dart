import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'bottom-app-bar-widget/bottom_appBar.dart';

class TopTenContactDetailsWidget extends StatefulWidget {
  List offerList;
  TopTenContactDetailsWidget({
    Key? key,
    required this.offerList,
  }) : super(key: key);

  @override
  State<TopTenContactDetailsWidget> createState() =>
      _TopTenContactDetailsWidgetState();
}

class _TopTenContactDetailsWidgetState extends State<TopTenContactDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.offerList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              margin:
              EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: blueColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      "${widget.offerList[index]["KontakAdi"] ?? ''}",
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10),
                    child: Text(
                      "Ad/Soyad:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "${widget.offerList[index]["KontakAdi"] ?? ''}",
                        style: TextStyle(fontSize: 17),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10),
                    child: Text(
                      "E-Posta:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "${widget.offerList[index]["Email"] ?? ''}",
                        style: TextStyle(fontSize: 17),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Cep Telefon:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.offerList[index]["CepTelefonu"] ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Departman:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.offerList[index]["Departman"] ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Doğum Tarihi:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.offerList[index]["DogumTarihiFormatli"] ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Adres:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.offerList[index]["AdresSatiri1"] ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("")
                ],
              ),
            );
          }),
    );
  }
}
