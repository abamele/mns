import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/apiHttp.dart';
import '../../constants/colors.dart';
import '../../constants/phone_number_format.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';

class AddNewScopeWidget extends StatefulWidget {
  List scopes;
  AddNewScopeWidget({Key? key, required this.scopes}) : super(key: key);

  @override
  State<AddNewScopeWidget> createState() => _AddNewScopeWidgetState();
}

class _AddNewScopeWidgetState extends State<AddNewScopeWidget> {
  TextEditingController customerName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController tcNo = TextEditingController();
  TextEditingController taxNo = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  String _groupValue = '';
  int _value1 = 0;
  bool isAdmin = true;

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 55, top: 10),
              child: Card(
                elevation: 8.0,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: blueColor,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: new Text(
                        "Müşteri Ekle",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Müşteri Adı",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: customerName,
                                decoration: InputDecoration(
                                  hintText: "Yazınız...",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "E-posta",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: "Yazınız...",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Telefon",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(10),
                                  _phoneNumberFormatter
                                ],
                                decoration: InputDecoration(
                                  hintText: "(5xx) xxx-xxxx ",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Telefon numaranızı giriniz.";
                                  } else {
                                    return (value).length == 14
                                        ? null
                                        : 'Lütfen telefon numaranızı formata uygun giriniz.';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "İl",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: city,
                                decoration: InputDecoration(
                                  hintText: "Yazınız...",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "İlçe",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: county,
                                decoration: InputDecoration(
                                  hintText: "Yazınız...",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Adres",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: address,
                                keyboardType: TextInputType.multiline,
                                minLines: 4,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Yazınız...",
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                            /*  Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: Column(
                                  children: <Widget>[
                                    RadioListTile(
                                      title: const Text('Gerçek Kişi'),
                                      value: "Gerçek Kişi",
                                      groupValue: _groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          checkRadio(value as String);
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                        title: Text('Tüzel Kişi'),
                                        value: 'Tüzel Kişi',
                                        groupValue: _groupValue,
                                        onChanged: (value) {
                                          checkRadio(value as String);
                                        }),
                                  ],
                                ),
                              ),*/
                            /* Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller:
                                  _groupValue == "Gerçek Kişi" ? tcNo : taxNo,
                                  decoration: InputDecoration(
                                    hintText: _groupValue == "Gerçek Kişi"
                                        ? "Tc No Giriniz..."
                                        : "Vergi Numarası Giriniz...",
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),

                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: tax,
                                  decoration: InputDecoration(
                                    hintText: _groupValue == "Gerçek Kişi"
                                        ? "Vergi Dairesi Giriniz..."
                                        : "Vergi Dairesi Giriniz...",
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),

                                  ),
                                ),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(290, 45),
                                    primary: blueColor),
                                child: Center(
                                  child: Text(
                                    "Kaydet",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    showBusinessLoginDialog();
                                    addCustomer(
                                        Hive.box("userbox").get("UyeID"),
                                        customerName.text,
                                        email.text,
                                        phone.text,
                                        city.text,
                                        address.text,
                                        county.text,
                                        tcNo.text,
                                        tax.text,
                                        taxNo.text,
                                        _groupValue);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Lütfen zorunlu alanları giriniz."),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Kapat"))
                                            ],
                                          );
                                        });
                                  }
                                }),
                          ),
                        ),
                      ],
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
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  categoryDropdownList() {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List categ = widget.scopes;
    for (var i = 0; i < categ.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              "Kategori Seçiniz...",
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              categ[i - 1]["KategoriAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future addCustomer(
    int? uyId,
    String musteriAdi,
    String eposta,
    String telefon,
    String sehir,
    String adres,
    String ilce,
    String tcNo,
    String vergiNo,
    String vergiDairesi,
    String turu,
  ) async {
    try {
      var response = await Dio().post(AppUrl.addCustomer, data: {
        "MusteriAdi": musteriAdi,
        "Sehir": sehir,
        "Telefon": telefon,
        "Eposta": eposta,
        "YetkiliAdi": "",
        "OlusTarihi": "2022-05-31T06:37:12.177Z",
        "Adres": adres,
        "Ilce": ilce,
        "TcNo": tcNo,
        "VergiNo": vergiDairesi,
        "VergiDairesi": vergiNo,
        "Doviz": "",
        "GercekKisiBool": true,
        "Turu": turu,
        "OlusKullanici": "",
        "KategoriId": 0,
        "KontakListeIds": [0],
        "FirsatID": 0,
        "UyeId": uyId,
        "KategoriDurumuText": "",
        "KategoriAdi": ""
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Müşteri kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/customer_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
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
                    Navigator.pushNamedAndRemoveUntil(context, "/customer_list",
                        (Route<dynamic> route) => false);
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
