import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key,}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productName = TextEditingController();
  TextEditingController productCode = TextEditingController();
  TextEditingController attendanceExchange = TextEditingController();
  TextEditingController serviceExchange = TextEditingController();
  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroll) {
          return [
            SliverAppBar(
              backgroundColor: blueColor,
              elevation: 0.0,
              toolbarHeight: 80,
              title: Container(
                margin: EdgeInsets.only(right: 35),
                child: Center(
                  child: Text("Ürünler"),
                ),
              ),
            )
          ];
        },
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20 ),
                child: Card(
                  elevation: 8.0,

                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                color: blueColor,
                                alignment: Alignment.center,
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: new Text(
                                  "Ürün Ekle",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        "Ürün Adı",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        //controller: _userName,
                                        decoration:
                                        InputDecoration(
                                          hintText:
                                          "Yazınız...",
                                          helperStyle:
                                          TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        "Ürün Kodu",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        //controller: _userName,
                                        decoration:
                                        InputDecoration(
                                          hintText:
                                          "Yazınız...",
                                          helperStyle:
                                          TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        "Hizmet Bedeli",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        //controller: _userName,
                                        decoration:
                                        InputDecoration(
                                          hintText:
                                          "Yazınız...",
                                          helperStyle:
                                          TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        "Servis Bedeli",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        //controller: _userName,
                                        decoration:
                                        InputDecoration(
                                          hintText:
                                          "Yazınız...",
                                          helperStyle:
                                          TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        "Açıklama",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        minLines: 4,
                                        maxLines: null,
                                        //controller: _userName,
                                        decoration:
                                        InputDecoration(
                                          hintText:
                                          "Yazınız...",
                                          helperStyle:
                                          TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20),
                                child: ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                      minimumSize:
                                      Size(290, 45),
                                      primary: blueColor),
                                  child: Text("Kaydet"),
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      formKey.currentState!.save();
                                      //showBusinessLoginDialog();
                                      addProduct(
                                          Hive.box("userbox").get("UyeID"),
                                          productName.text,
                                          productCode.text,
                                          double.parse(attendanceExchange.text),
                                          double.parse(serviceExchange.text));
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future addProduct(int? uyeId, String name, String code, double hizmetBedeli,
      double servisBedeli) async {
    try {
      var response = await Dio().post(AppUrl.addProduct, data: {
        "EXPCATEGORY": "string",
        "NAME": "string",
        "CODE": "string",
        "LOGICALREF": 0,
        "UyeId": 0,
        "HizmetBedeli": 0,
        "ServisBedeli": 0
      }).then((value) {
        print("...........................................${value}");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Ürün Eklendi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
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
