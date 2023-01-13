import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../screens/offer-folder/offer_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';

class OfferContactDetailsWidget extends StatefulWidget {
  OfferModel contact;
  OfferContactDetailsWidget({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<OfferContactDetailsWidget> createState() =>
      _OfferContactDetailsWidgetState();
}

class _OfferContactDetailsWidgetState extends State<OfferContactDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.contact.contact.length,
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
                      "",
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
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "${widget.contact.contact[index].contactName ?? ''}",
                        style: TextStyle(fontSize: 17),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10),
                    child: Text(
                      "E-Posta:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "${widget.contact.contact[index].email ?? ''}",
                        style: TextStyle(fontSize: 17),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Cep Telefon:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.contact.contact[index].tel ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Departman:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.contact.contact[index].department ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Doğum Tarihi:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.contact.contact[index].birthDay ?? ''}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
                    child: Text(
                      "Adres:",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "${widget.contact.contact[index].address ?? ''}",
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
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }
}
