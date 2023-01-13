import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import '../../widgets/bottom-app-bar-widget/bottom_appBar.dart';
import '../../widgets/expandable-fab-button-widget/action_button.dart';
import '../../widgets/expandable-fab-button-widget/expandable_fab_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Profilim"),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/profilim.jpg"),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Center(child: Text("${Hive.box("userbox").get("AdiSoyadi").toString()}")),
            subtitle: Center(child: Text("${Hive.box("userbox").get("KullaniciAdi").toString()}")),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ad",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration: InputDecoration(

                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Soyad",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "E-Posta",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("KullaniciAdi").toString(),
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Telefon Numarası",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("GSM").toString(),
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kullanıcı Adı",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration:
                          InputDecoration(),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doğum Tarihi",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox")
                          .get("DogumTarihiFormatli")
                          .toString(),
                      decoration:
                          InputDecoration(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adres",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("Adres").toString(),
                    minLines: 4,
                    maxLines: null,
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          /*SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(left: 35, right: 35),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(290, 45),
                  primary: blueColor
                ),
                onPressed: () {}, child: Text("Kaydet", style: TextStyle(fontSize: 17),)),
          ),
          SizedBox(height: 30,),
          Text("")*/
        ],
      ),

      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }
}


