import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mns/mns/constants/context_extension.dart';

import '../../../constants/apiHttp.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';


class OfferProduct extends StatefulWidget {
  List prod;
  OfferProduct({Key? key, required this.prod}) : super(key: key);

  @override
  State<OfferProduct> createState() => _OfferProductState();
}

class _OfferProductState extends State<OfferProduct> {
  TextEditingController model = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unitPrice = TextEditingController();

  String total="";
  //String? value = items.first;
  int _value1 = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 55, left: 10, right: 10, bottom: 55),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: context.dynamicHeight(0.09),
                      width: context.dynamicWidth(0.6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            child: Center(
                              child: Text(
                                "Ürün Oluşur",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ),
                            onPressed: () {},
                          ),
                          /* TextButton(
                              child: Text(
                                "Üye Ol",
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                              onPressed: () {}),*/
                        ],
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: (BorderRadius.circular(12))),
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: _value1,
                                  items: productListDropdownList("Seçiniz..."),
                                  onChanged: (int? value) {
                                    _value1 = value!;
                                    if (_value1 == 0) {
                                      _value1 = 0;
                                    }
                                    setState(() {});
                                  },
                                  hint: const Text("Seçiniz...")),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 10, top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: quantity,
                                decoration: InputDecoration(
                                  hintText: 'Yazınız...',
                                  helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bu alan zorunludur";
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 10, top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: quantity,
                                decoration: InputDecoration(
                                  hintText: 'Yazınız...',
                                  helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bu alan zorunludur";
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 10, top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: unitPrice,
                                decoration: InputDecoration(
                                  hintText: 'Yazınız...',
                                  helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bu alan zorunludur";
                                  }
                                },
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: Center(
                                child: FloatingActionButton.extended(
                                    backgroundColor: Colors.green,
                                    label: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Center(
                                        child: Text(
                                          "Kaydet",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        showDialog(
                                            context:
                                            context,
                                            builder:
                                                (BuildContext
                                            conetext) {
                                              return AlertDialog(
                                                content:
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Toplam Tutar:",
                                                          style: TextStyle(
                                                              fontSize:
                                                              17),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Text("${total}",style: TextStyle(
                                                            fontSize:
                                                            17, fontWeight: FontWeight.bold),)
                                                      ],
                                                    ),
                                                    SizedBox(height: 30,),
                                                    Text(
                                                      "Kaydetmek ister misiniz?",
                                                      style: TextStyle(
                                                          fontSize:
                                                          20),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .grey),
                                                      onPressed:
                                                          () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                      Text("Vazgeç")),
                                                  Container(
                                                      margin:
                                                      EdgeInsets.only(right: 50),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(primary: Colors.green),
                                                          onPressed: () {
                                                            saveOffer(Hive.box("userbox").get("UyeID"),Hive.box("userbox").get("TeklifID"),  _value1.toString(), int.parse(quantity.text) , int.parse(unitPrice.text), int.parse(total));
                                                          },
                                                          child: Text("Kaydet"))),
                                                ],
                                              );
                                            });

                                      };
                                      int mult=int.parse(unitPrice.text) *
                                          int.parse(quantity.text);
                                      total=mult.toString();
                                      setState(() {

                                      });
                                    }),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  productListDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List product=widget.prod;
    for (var i = 0; i < product.length + 1; i++) {
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
              product[i - 1]["NAME"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future saveOffer(int? uyeId,int? teklifId, String model, int miktar, int birimFiyat, int topFiyat) async {
    try {
      var response = await Dio().post(AppUrl.addProductBasket, data: {
        "SepetID": 0,
        "UrunID": 0,
        "TeklifID": teklifId,
        "UyeID":uyeId,
        "LGItemsID": 0,
        "Model": model,
        "Miktar": miktar,
        "Birim": "",
        "Vergi": 0,
        "BirimFiyat": birimFiyat,
        "AraToplam": 0,
        "ToplamTutar": topFiyat,
        "Code": ""
      }).then((value) {
        print("..................................$value");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Ürün kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/offer_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      print("hatattttttttttttt..................................$e");
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
