import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/home-folder/send_offer.dart';
import 'package:progresso/progresso.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mns/mns/constants/context_extension.dart';
import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_appBar.dart';
import '../../widgets/expandable-fab-button-widget/action_button.dart';
import '../../widgets/expandable-fab-button-widget/expandable_fab_button_widget.dart';
import '../customer-folder/customer_list.dart';
import '../offer-folder/offerAndProductInfoWithDropdown.dart';
import '../product-folder/product_list.dart';
import '../scope-folder/addScopeWithDropdown.dart';

class DashboardScreen extends StatefulWidget {
  List offer;
  List prod;
  DashboardScreen({Key? key, required this.offer, required this.prod})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);
  TextEditingController customeName = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController validityDate = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List txtList = ["Teklif Bilgiler", "Ürün Bilgileri"];
  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];
  ValueNotifier<int?> _value1 = ValueNotifier<int?>(null);



  int? _value2 = 0;
  int? value3 = 0;
  int? value4 = 0;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  List itemMenu = [
    "Müşteriler",
    "Ürünler",
    "Teklifler",
    "Fırsatlar",
    "Onaylanan \nSiparişler",
    "Reddedilen \nSiparişler",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                toolbarHeight: 80,
                title: Container(
                  child: Center(child: Image.asset("assets/image 1.png")),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 145,
                    color: blueColor,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FutureBuilder(
                              future: DashbordInfoList(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Bir şeyler yanlış gitti');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                Map data = snapshot.data.data;
                                Map dashboardInfo = data["Veri"];
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MaterialButton(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Telifler",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xffA1539C))),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.2),
                                                    ),
                                                    Text(
                                                        "${dashboardInfo["TumTeklifler"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xffA1539C)))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Kabul Eden",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.15),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["OnaylananTeklifler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 145,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumTeklifler"] ==
                                                                0.0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "OnaylananTeklifler"] /
                                                                (dashboardInfo[
                                                                    "TumTeklifler"]),
                                                        progressColor:
                                                            blueColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Devam Eden",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.115),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["DevamEdenTeklifler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 145,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumTeklifler"] ==
                                                                0.0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "DevamEdenTeklifler"] /
                                                                (dashboardInfo[
                                                                    "TumTeklifler"]),
                                                        progressColor:
                                                            yellowColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Reddilen Eden",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.115),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["ReddedilenTeklifler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 145,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumTeklifler"] ==
                                                                0.0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "ReddedilenTeklifler"] /
                                                                (dashboardInfo[
                                                                    "TumTeklifler"]),
                                                        progressColor: redColor,
                                                        backgroundColor:
                                                            Color(0xffcfcfcf),
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/offer_list");
                                        },
                                      ),
                                      MaterialButton(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Fırsatlar",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff7093E0))),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.225),
                                                    ),
                                                    Text(
                                                        "${dashboardInfo["TumFirsatlar"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff7093E0)))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Değer. Aşa.",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.18),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["OnaylananFirsatlar"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumFirsatlar"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "OnaylananFirsatlar"] /
                                                                dashboardInfo[
                                                                    "TumFirsatlar"],
                                                        progressColor:
                                                            blueColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Geçerli",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.247),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["DevamEdenFirsatlar"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumFirsatlar"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "DevamEdenFirsatlar"] /
                                                                dashboardInfo[
                                                                    "TumFirsatlar"],
                                                        progressColor:
                                                            yellowColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Geçersiz",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.22),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["ReddedilenFirsatlar"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumFirsatlar"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "ReddedilenFirsatlar"] /
                                                                dashboardInfo[
                                                                    "TumFirsatlar"],
                                                        progressColor: redColor,
                                                        backgroundColor:
                                                            Color(0xffcfcfcf),
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/scope_list");
                                        },
                                      ),
                                      MaterialButton(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Görüşmeler",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xffA5306B))),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.2),
                                                    ),
                                                    Text(
                                                        "${dashboardInfo["TumGorusmeler"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xffA5306B)))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Başlanan",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.24),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["OnaylananGorusmeler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorusmeler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "OnaylananGorusmeler"] /
                                                                dashboardInfo[
                                                                    "TumGorusmeler"],
                                                        progressColor:
                                                            blueColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Devam Eden",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.193),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["DevamEdenGorusmeler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorusmeler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "DevamEdenGorusmeler"] /
                                                                dashboardInfo[
                                                                    "TumGorusmeler"],
                                                        progressColor:
                                                            yellowColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("İptal Eden",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.23),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["ReddedilenGorusmeler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorusmeler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "ReddedilenGorusmeler"] /
                                                                dashboardInfo[
                                                                    "TumGorusmeler"],
                                                        progressColor: redColor,
                                                        backgroundColor:
                                                            Color(0xffcfcfcf),
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/activity_list");
                                        },
                                      ),
                                      MaterialButton(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Görevler",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.22),
                                                    ),
                                                    Text(
                                                        "${dashboardInfo["TumGorevler"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Başlanan",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.22),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["OnaylananGorevler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorevler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "OnaylananGorevler"] /
                                                                dashboardInfo[
                                                                    "TumGorevler"],
                                                        progressColor:
                                                            blueColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Tamamlan.",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.18),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["DevamEdenGorevler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorevler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "DevamEdenGorevler"] /
                                                                dashboardInfo[
                                                                    "TumGorevler"],
                                                        progressColor:
                                                            yellowColor,
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("İptal",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: context
                                                          .dynamicWidth(0.3),
                                                    ),
                                                    Text(
                                                      "${dashboardInfo["ReddedilenGorevler"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                                SizedBox(
                                                  width: 155,
                                                  child: Container(
                                                    child: Progresso(
                                                        progress: dashboardInfo[
                                                                    "TumGorevler"] ==
                                                                0
                                                            ? 0.0
                                                            : dashboardInfo[
                                                                    "ReddedilenGorevler"] /
                                                                dashboardInfo[
                                                                    "TumGorevler"],
                                                        progressColor: redColor,
                                                        backgroundColor:
                                                            Color(0xffcfcfcf),
                                                        progressStrokeWidth: 5,
                                                        backgroundStrokeWidth:
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/task_list");
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 25),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: blueColor,
                                    minimumSize: Size(290, 45)),
                                onPressed: () {
                                  /*showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            content: Form(
                                              key: formKey,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      color: blueColor,
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: new Text(
                                                        "Teklif Oluşur",
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Müşteriler",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 12,
                                                              ),
                                                              margin: const EdgeInsets
                                                                  .all(10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          (BorderRadius.circular(
                                                                              12))),
                                                              child:
                                                                  ValueListenableBuilder(
                                                                valueListenable:
                                                                    _value1,
                                                                builder: (context,
                                                                    int?
                                                                        value1Value,
                                                                    Widget?
                                                                        child) {
                                                                  return DropdownButton(
                                                                      isExpanded:
                                                                          true,
                                                                      value:
                                                                          value1Value,
                                                                      items: customerDropdownList(
                                                                          "Seçiniz"),
                                                                      onChanged:
                                                                          (int?
                                                                              value) {
                                                                        if (value ==
                                                                            0) {
                                                                          return;
                                                                        } else {
                                                                          _value1.value =
                                                                              value;
                                                                        }
                                                                      },
                                                                      hint: const Text(
                                                                          "Seçiniz..."));
                                                                },
                                                              )),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child: Text(
                                                                "Yetkililer",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 12,
                                                              ),
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          (BorderRadius.circular(
                                                                              12))),
                                                              child:
                                                                  ValueListenableBuilder(
                                                                valueListenable:
                                                                    _value1,
                                                                builder: (context,
                                                                    int?
                                                                        value2Value,
                                                                    Widget?
                                                                        child) {
                                                                  if (value2Value ==
                                                                      null) {
                                                                    return Container();
                                                                  } else {
                                                                    return DropdownButton(
                                                                        isExpanded:
                                                                            true,
                                                                        value:
                                                                            _value2,
                                                                        items: contactDropdownList(
                                                                            "Seçiniz...",
                                                                            value2Value -
                                                                                1),
                                                                        onChanged:
                                                                            (int?
                                                                                value) {
                                                                          *//* if (_value2 == 0) {
                                                                                _value2 = 0;
                                                                              } else {
                                                                                _value2 = value;
                                                                              }*//*
                                                                          _value2 =
                                                                              value;
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        hint: const Text(
                                                                            "Seçiniz..."));
                                                                  }
                                                                },
                                                              )),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Geçerlilik Tarihi",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                            EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                            ),
                                                            child: TextFormField(
                                                              controller:
                                                              validityDate,
                                                              decoration:
                                                              InputDecoration(
                                                                hintText:
                                                                'Yazınız...',
                                                                suffixIcon: Icon(
                                                                    Icons
                                                                        .date_range),
                                                                helperStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                    17),
                                                              ),
                                                              onTap: () async {
                                                                DateTime?
                                                                pickedDate =
                                                                await showDatePicker(
                                                                    locale: Locale(
                                                                        "tr",
                                                                        "TR"),
                                                                    context:
                                                                    context,
                                                                    initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                    firstDate:
                                                                    DateTime(
                                                                        2000), //DateTime.now() - not to allow to choose before today.
                                                                    lastDate:
                                                                    DateTime.now().add(Duration(days: 7)));

                                                                if (pickedDate !=
                                                                    null) {
                                                                  print(
                                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                  String
                                                                  formattedDate =
                                                                  DateFormat(
                                                                      'dd-MM-yyyy')
                                                                      .format(
                                                                      pickedDate);
                                                                  print(
                                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                  //you can implement different kind of Date Format here according to your requirement

                                                                  setState(() {
                                                                    validityDate
                                                                        .text =
                                                                        formattedDate; //set output date to TextField value.
                                                                  });
                                                                } else {
                                                                  print(
                                                                      "seçilmedi");
                                                                }
                                                              },

                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Teklif Durumu",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 12,
                                                              ),
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          (BorderRadius.circular(
                                                                              12))),
                                                              child:
                                                                  DropdownButton(
                                                                      isExpanded:
                                                                          true,
                                                                      value:
                                                                          value4,
                                                                      items: offerStateDropdownList(
                                                                          "Seçiniz..."),
                                                                      onChanged:
                                                                          (int?
                                                                              value) {
                                                                        value4 =
                                                                            value;
                                                                        if (value4 ==
                                                                            0) {
                                                                          value4 =
                                                                              0;
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      hint: const Text(
                                                                          "Yazınız..."))),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Açıklama",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 20),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  comment,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              minLines: 4,
                                                              maxLines: null,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Yazınız...",
                                                                helperStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      minimumSize:
                                                                          Size(
                                                                              290,
                                                                              45),
                                                                      primary:
                                                                          blueColor),
                                                              child: Text(
                                                                  "Devam Et"),
                                                              onPressed: () {
                                                                if (formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  formKey
                                                                      .currentState!
                                                                      .save();
                                                                 *//* addOffer(
                                                                      Hive.box(
                                                                              "userbox")
                                                                          .get(
                                                                              "UyeID"),
                                                                      _value1
                                                                          .toString(),
                                                                      _value2!,
                                                                      validityDate.text,
                                                                      state
                                                                          .text,
                                                                      comment
                                                                          .text);*//*

                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text("")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      });*/

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SendOffer(
                                            offer: widget.offer,
                                            prod: widget.prod,
                                          )));
                                },
                                child: Text(
                                  "Teklif Gönder",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ))),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  selectMenuWidget(
                                      1, FontAwesomeIcons.user, itemMenu[0])
                                ],
                              ),
                              Row(
                                children: [
                                  selectMenuWidget(2,
                                      FontAwesomeIcons.userGroup, itemMenu[1])
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  selectMenuWidget(
                                      3, FontAwesomeIcons.cube, itemMenu[2])
                                ],
                              ),
                              Row(
                                children: [
                                  selectMenuWidget(
                                      4, FontAwesomeIcons.bullseye, itemMenu[3])
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: ExpandableFab2(
          distance: 80,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ActionButton(
                        heroTag: "btn1",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.peopleCarryBox, color: blueColor,),
                            Center(
                              child: Text(
                                "Teklif Ekle",
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    offerAndProductInfoWithDropdown()))),
                    SizedBox(
                      width: 10,
                    ),
                    ActionButton(
                        heroTag: "btn2",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.cube, color: blueColor,),
                            Center(
                              child: Text(
                                "Ürün Ekle",
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/add_product");
                        })
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ActionButton(
                        heroTag: "btn3",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(FontAwesomeIcons.cube, color: blueColor,),
                            Center(
                              child: Text(
                                "Fırsat Ekle",
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, "/add_scope")),
                    SizedBox(
                      width: 10,
                    ),
                    ActionButton(
                        heroTag: "btn4",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.tasks, color: blueColor,),
                            Center(
                              child: Text(
                                "Görev Ekle",
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/add_task");
                        })
                  ],
                ),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarWidget());
  }

  Future<void> _reload(var value) async {
    setState(() {});
  }

  customerDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.offer;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
        print(".......................${i}");
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1]["MusteriAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  offerStateDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    //List state = widget.offerList;
    for (var i = 0; i < txtState.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              txtState[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future<void> _openDatePicker1(BuildContext context) async {
    dateTime1 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blueColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  contactDropdownList(String title, int index) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List contact = widget.offer[index]["TeklifYetkilileri"];
    /*  print("--------------------------------------------${contact.toString()}");
    print("--------------------------------------------${contact.length}");*/
    for (var i = 0; i < contact.length + 1; i++) {
      if (i == 0 || i < 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
/*
        print("${contact[i-1]}------------------ ${contact[i-1]['KontakAdi']}-----------${i-1}");
*/
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              contact[i - 1]["KontakAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }

    return dropdownItemList;
  }

  colorX(int SiraNo) {
    if (SiraNo == 1) {
      return Color(0xff67b7dc);
    } else if (SiraNo == 2) {
      return Color(0xff6794dc);
    } else if (SiraNo == 3) {
      return Color(0xff6771dc);
    } else if (SiraNo == 4) {
      return Color(0xff8067dc);
    } else if (SiraNo == 5) {
      return Color(0xffa367dc);
    } else if (SiraNo == 6) {
      return Color(0xffc767dc);
    } else if (SiraNo == 7) {
      return Color(0xffdc67ce);
    } else if (SiraNo == 8) {
      return Color(0xffdc67ab);
    } else if (SiraNo == 9) {
      return Color(0xffdc6788);
    } else if (SiraNo == 10) {
      return Color(0xffdc6967);
    }
  }

  Widget selectMenuWidget(int index, IconData icon, String text) {
    return ValueListenableBuilder(
      valueListenable: selectButton,
      builder: (BuildContext context, int value, Widget? child) {
        return MaterialButton(
            child: Card(
              elevation: 5.0,
              color: value == index ? blueColor : Colors.white,
              margin: EdgeInsets.only(top: 30),
              child: Container(
                width: context.dynamicWidth(0.40),
                height: context.dynamicHeight(0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        size: 25,
                        color: value == index ? Colors.white : blueColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: value == index
                                  ? Colors.white
                                  : Color(0xff4F4F4F))),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              if (index == 1) {
                selectButton.value = index;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerList()));
              } else if (index == 2) {
                selectButton.value = index;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductList()));
              } else if (index == 3) {
                selectButton.value = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            offerAndProductInfoWithDropdown()));
              } else if (index == 4) {
                selectButton.value = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddScopeWithDropdown()));
              }
              ;
            });
      },
    );
  }

  Future DashbordInfoList() async {
    try {
      var response = await Dio().post(AppUrl.dashbordInfo, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future DashbordTopTenInfoList() async {
    try {
      var response = await Dio().post(AppUrl.dashbordTopTenInfo, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future dashbordBirthDayInfo() async {
    try {
      var response = await Dio().post(AppUrl.dashbordBirthDayInfo, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future addOffer(int? uyeId, String musteriAdi, int kontakAdi,
      String aktiviteTarihi, String teklifDurumu, String aciklama) async {
    try {
      var response = await Dio().post(AppUrl.addOffer, data: {
        "TeklifID": 0,
        "SiparisID": 0,
        "UyeID": uyeId,
        "Aciklama": aciklama,
        "TeklifNo": 0,
        "IsDeleted": true,
        "MusteriAdi": musteriAdi,
        "MusteriID": 0,
        "KontakAdi": kontakAdi,
        "TeklifTarihi": aktiviteTarihi,
        "GecerlilikTarihi": "2022-05-05T06:39:30.968Z",
        "TeklifDurumu": 0,
        "AraToplam": "",
        "ToplamTutar": "",
        "DuzenlemeTarihi": "2022-05-05T06:39:30.968Z",
        "OlusturmaTarihi": "2022-05-05T06:39:30.968Z",
        "GuncellemeTarihi": "2022-05-05T06:39:30.968Z",
        "VadeTarihi": "2022-05-05T06:39:30.968Z",
        "TeklifinDurumu": 0,
        "TeklifDurumuText": teklifDurumu,
        "KontakID": 0,
        "OlusKullaniciId": 0,
        "GuncelleyenKullaniciId": 0,
        "YetkiliListeIds": [0],
        "TeklifYetkilileri": [
          {
            "KontakAdi": "",
            "KontakID": 0,
            "Email": "",
            "CepTelefonu": "",
            "Departman": "",
            "DogumTarihi": "2022-05-05T06:39:30.968Z",
            "DogumTarihiFormatli": "",
            "AdresSatiri1": ""
          }
        ],
        "GecerlilikTarihiFormatli": ""
      }).then((value) {
        /*   print("...........................................${value}");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Teklif kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kapat"))
                ],
              );
            });*/
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      print("...........................................${e}");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${e.response!.data["message"]}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kapat"))
              ],
            );
          });
    }
  }
}
