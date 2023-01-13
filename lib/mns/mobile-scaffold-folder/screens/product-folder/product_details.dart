import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/product-folder/product_model.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';

class ProductDetails extends StatefulWidget {
  ProductModel? productList;
  ProductDetails({Key? key, this.productList}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _productName = widget.productList!.name ?? '';
    String _productCode = widget.productList!.code ?? '';
    var _attendanceExchange = widget.productList!.attendanceExchange ?? "";
    var _serviceExchange = widget.productList!.serviceExchange ?? "";
    String _comment = widget.productList!.comment ?? '';
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Ürünler"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 8.0,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Ürün Adı",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: TextFormField(
                              initialValue: _productName,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Ürün Kodu",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: TextFormField(
                              initialValue: _productCode,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Hizmet Bedeli",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: TextFormField(
                              initialValue: _attendanceExchange,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Servis Bedeli",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: TextFormField(
                              initialValue: _serviceExchange,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Açıklama",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: TextFormField(
                              minLines: 4,
                              maxLines: null,
                              initialValue: _comment,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(290, 45), primary: blueColor),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              updateProduct(
                                  Hive.box("userbox").get("UyeID"),
                                  widget.productList!.ref,
                                  _productName,
                                  _productCode,
                                  (_attendanceExchange as double),
                                  (_serviceExchange as double) ,
                                  _comment);
                            }
                          },
                          child: Text(
                            "Kaydet",
                            style: TextStyle(fontSize: 17),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future updateProduct(int? uyeId, int? ref, String name, String code,
      double hizmetBedeli, double servisBedeli, String expCategory) async {
    try {
      var response = await Dio().post(AppUrl.updateProduct, data: {
        "EXPCATEGORY": expCategory,
        "NAME": name,
        "CODE": code,
        "LOGICALREF": ref,
        "UyeId": uyeId,
        "HizmetBedeli": hizmetBedeli,
        "ServisBedeli": servisBedeli
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Icon(Icons.check_circle, size: 60, color: Colors.green),
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Ürün Güncellendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/product_list", (route) => false);
                      },
                      child: Text(
                        "Kapat",
                        style: TextStyle(fontSize: 14),
                      ))
                ],
              );
            });
      });
      return response;
    } on DioError catch (e) {
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

  showBusinessLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: _loginLoading,
              builder: (BuildContext context, Map value, Widget? child) {
                if (value["state"] == 0) {
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else if (value["state"] == 1) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/homepage", (Route<dynamic> route) => false);
                  });
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else {
                  return AlertDialog(
                    title: Text(value["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Tamam"))
                    ],
                  );
                }
              });
        }).then((value) => _loginLoading.value = {"state": 0, "message": ""});
  }
}
