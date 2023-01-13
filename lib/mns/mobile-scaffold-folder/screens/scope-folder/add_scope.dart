import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';

class AddScope extends StatefulWidget {
  List scopes;
  AddScope({Key? key, required this.scopes}) : super(key: key);

  @override
  State<AddScope> createState() => _AddScopeState();
}

class _AddScopeState extends State<AddScope> {
  TextEditingController scopeName = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController scopeStartDate = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  TextEditingController scopeEndDate = TextEditingController();
  TextEditingController customers = TextEditingController();
  TextEditingController scopeState = TextEditingController();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];
  final format = DateFormat("dd-MM-yyyy");
  int _value1 = 0;
  int _value2 = 0;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;

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
                  child: Text("Fırsatlar"),
                ),
              ),
            )
          ];
        },
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
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
                          "Fırsat Ekle",
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
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Fırsat Adı",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: scopeName,
                                  decoration: InputDecoration(
                                    hintText: "Yazınız...",
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Açıklama",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: comment,
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
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Başlangıç Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  controller: scopeStartDate,
                                  decoration: InputDecoration(
                                    hintText: 'Yazınız...',
                                    suffixIcon: Icon(Icons.date_range),
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        locale: Locale("tr", "TR"),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        scopeStartDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("seçilmedi");
                                    }
                                  },
                                  onSaved: (val) {
                                    endDate = val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Bitiş Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  controller: scopeEndDate,
                                  decoration: InputDecoration(
                                    hintText: 'Yazınız...',
                                    suffixIcon: Icon(Icons.date_range),
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        locale: Locale("tr", "TR"),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        scopeEndDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("seçilmedi");
                                    }
                                  },
                                  onSaved: (val) {
                                    endDate = val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Müşteriler",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: (BorderRadius.circular(12))),
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: _value1,
                                    items: scopeCustomersDropdownList(
                                        "Seçiniz..."),
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
                                margin: EdgeInsets.only(left: 10, top: 40),
                                child: Text(
                                  "Fırsat Durumu",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: (BorderRadius.circular(12))),
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: _value2,
                                    items: scopeStateDropdownList("Yazınız..."),
                                    onChanged: (int? value) {
                                      _value2 = value!;
                                      if (_value2 == 0) {
                                        _value2 = 0;
                                      }
                                      setState(() {});
                                    },
                                    hint: const Text("Seçiniz...")),
                              ),
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
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(290, 50),
                                    primary: blueColor),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
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
                                    addScope(
                                      Hive.box("userbox").get("UyeID"),
                                      scopeName.text,
                                      comment.text,
                                      scopeStartDate.text,
                                      scopeEndDate.text,
                                      customers.text,
                                    );
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
                                },
                              ),
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
      ),
    );
  }

  scopeCustomersDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.scopes;
    for (var i = 0; i < customer.length + 1; i++) {
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

  scopeStateDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    //List customer=widget.scopes;
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

  Future<void> _openDatePicker2(BuildContext context) async {
    dateTime2 = await showDatePicker(
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

  Future addScope(int uyeId, String firsatAdi, String firsatAciklamasi,
      String baslangicTarihi, String bitisTarihi, String musteriAdi) async {
    try {
      showBusinessLoginDialog();
      var response = await Dio().post(AppUrl.addScope, data: {
        "FirsatID": 0,
        "UyeID": uyeId,
        "FirsatAdi": firsatAdi,
        "FirsatAciklama": firsatAciklamasi,
        "BaslangicTarihi": "2022-06-07T09:19:47.214Z",
        "OlusturulmaTarihi": "2022-06-07T09:19:47.214Z",
        "BitisTarihi": "2022-06-07T09:19:47.214Z",
        "MusteriAdi": musteriAdi,
        "MusteriID": 0,
        "FirsatDurumu": 0,
        "BitisTarihiFormatli": bitisTarihi,
        "BaslangicTarihiFormatli": baslangicTarihi,
        "OlusturanKullaniciId": 0
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Fırsat kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/scope_list", (route) => false);
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
