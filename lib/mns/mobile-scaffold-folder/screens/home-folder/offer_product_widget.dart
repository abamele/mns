import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';

class OfferProductWidget extends StatefulWidget {
  List product;
  OfferProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<OfferProductWidget> createState() => _OfferProductWidgetState();
}

class _OfferProductWidgetState extends State<OfferProductWidget> {
  TextEditingController model = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unitPrice = TextEditingController();

  List<int> selectedValue=[];
  String total="";
  //String? value = items.first;
  int _value1 = 0;
  int _value2 = 0;

  final formKey = GlobalKey<FormState>();

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
            child: Text("Ürünler"),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 55),
              child: Card(
                elevation: 8.0,
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
                        "Ürün Oluşur",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18),
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
                              margin: EdgeInsets.only(
                                  top: 15, left: 15),
                              child: Text(
                                "Ürün Adı",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 16),
                              ),
                            ),
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
                              child: SearchableDropdown.multiple(
                                  isExpanded: true,
                                  selectedItems: selectedValue,
                                  items: ProductDropdownList("Seçiniz..."),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },

                                  hint: const Text("Seçiniz...")),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 15, left: 15),
                              child: Text(
                                "Miktar",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 16),
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
                              margin: EdgeInsets.only(
                                  top: 15, left: 15),
                              child: Text(
                                "Birim Fiyat",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 16),
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
                                child:ElevatedButton(
                                    style: ElevatedButton
                                        .styleFrom(
                                        minimumSize:
                                        Size(290,
                                            45),
                                        primary:
                                        blueColor),
                                    child: Text("Kaydet"),
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
                                                              20, fontWeight: FontWeight.bold),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Text("\$${total}",style: TextStyle(
                                                            fontSize:
                                                            25, fontWeight: FontWeight.bold ),)
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
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
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
                                                         child: ElevatedButton(
                                                             style: ElevatedButton.styleFrom(primary: Colors.green),
                                                             onPressed: () {
                                                               saveOffer(Hive.box("userbox").get("UyeID"),Hive.box("userbox").get("TeklifID"),  selectedValue.toString(), int.parse(quantity.text) , int.parse(unitPrice.text), int.parse(total));
                                                             },
                                                             child: Text("Kaydet"))),
                                                   ],
                                                 )
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
    );
  }


  ProductDropdownList(String title) {
    List<String> items = [];
    List<DropdownMenuItem<String>> dropdownItemList = [];
    List prod=widget.product;
    for (var i = 0; i < prod.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: "",
          ),
        );
      } else {
        items.add(prod[i-1]["NAME"].toString());
      /*  dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              prod[i - 1]["NAME"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );*/
      }
    }
    items
        .forEach((word) {
      dropdownItemList.add(DropdownMenuItem(
        child: Text(word),
        value: word,
      ));
      /* if (wordPair.isEmpty) {
        wordPair = word + " ";

      } else {
        wordPair;
        if (items.indexWhere((item) {
          return (item == wordPair);
        }) == -1) {
          dropdownItemList.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }*/
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/offer_list", (route) => false);
                          },
                          child: Text("Kapat")),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green
                        ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/offer_list", (route) => false);
                          },
                          child: Text("Yeni Teklif Oluşur")),
                    ],
                  )
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
