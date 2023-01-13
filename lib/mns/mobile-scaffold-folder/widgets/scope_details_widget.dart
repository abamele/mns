import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';

import '../../constants/apiHttp.dart';
import '../../constants/colors.dart';
import '../screens/scope-folder/scope_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';



class ScopeDetailsWidget extends StatefulWidget {
  ScopeModel scopeList;
  List scopes;
  ScopeDetailsWidget({Key? key, required this.scopeList, required this.scopes}) : super(key: key);

  @override
  State<ScopeDetailsWidget> createState() => _ScopeDetailsWidgetState();
}

class _ScopeDetailsWidgetState extends State<ScopeDetailsWidget> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});

  final formKey = GlobalKey<FormState>();
  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];

  int _value1 = 0;
  int _value2 = 0;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {

    String _scopeName = widget.scopeList.scopeName ?? '';
    String _comment = widget.scopeList.comment ?? '';
    String _scopeStartDate = widget.scopeList.startDate ?? '';
    String _scopeEndDate = widget.scopeList.endDate ?? '';
    //String _customers = widget.scopeList.scopeName ?? '';
    /*TextEditingController scopeState =
    TextEditingController(
        text:  widget.scopeList["FirsatDurumu"]);*/

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: blueColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      "Düzenle",
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: formKey,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Fırsat Adı", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                                ),
                                TextFormField(
                                  initialValue: _scopeName,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                /*  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Bu alan zorunludur";
                                    }
                                  },*/
                                  onChanged: (value) {
                                    setState(() {
                                      _scopeName = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    _scopeName = value!;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Açıklama", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                                ),
                                TextFormField(
                                  initialValue: _comment,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 4,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _comment = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    _comment = value!;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Başlangıç Tarihi", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                                ),
                                TextFormField(
                                  initialValue:
                                  _scopeStartDate,
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
                                        DateTime(
                                            2101));

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
                                        _scopeStartDate =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print(
                                          "seçilmedi");
                                    }
                                  },
                                  onSaved: (val) {
                                    endDate = val;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Bitiş Tarihi", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                                ),
                                TextFormField(
                                  initialValue:
                                  _scopeEndDate,
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
                                        DateTime(
                                            2101));

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
                                        _scopeEndDate
                                             =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print(
                                          "seçilmedi");
                                    }
                                  },
                                  onSaved: (val) {
                                    endDate = val;
                                  },
                                ),
                    /*            Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Müşteriler", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
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
                                  child: DropdownButton(
                                      isExpanded: true,
                                      value: _value1,
                                      items: scopeCustomerDropdownList(
                                          "Müşteri Seçiniz"),
                                      onChanged: (int? value) {
                                        _value1 = value!;
                                        if (_value1 == 0) {
                                          _value1 = 0;
                                        }
                                        setState(() {});
                                      },
                                      hint: const Text("Müşteri Seçiniz...")),
                                ),*/
                           /*     Padding(
                                  padding: const EdgeInsets.only( top: 20 ),
                                  child: Text("Durumu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
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
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _value2,
                                    items: scopeStateDropdownList(
                                        "Fırsat Durumu Seçiniz..."),
                                    onChanged: (int? value) {
                                      _value2 = value!;
                                      if (_value2 == 0) {
                                        _value2 = 0;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),*/

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(290, 45),
                            primary: blueColor
                        ),
                        onPressed: () {
                          if (formKey.currentState!
                              .validate()) {
                            formKey.currentState!.save();
                            showBusinessLoginDialog();
                            updateScope(
                                widget
                                    .scopeList.id,
                                Hive.box("userbox")
                                    .get("UyeID"),
                                _scopeName,
                                _comment,
                                _scopeStartDate,
                                _scopeEndDate,
                                );
                          }
                        }, child: Text("Kaydet", style: TextStyle(fontSize: 17),)),
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
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
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
                primary: Color(0xff5858FF), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color(0xff5858FF), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color(0xff5858FF), // button text color
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
                primary: Color(0xff5858FF), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color(0xff5858FF), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color(0xff5858FF), // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  scopeCustomerDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.scopes;
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
    List customer = txtState;
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
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future updateScope(
      int? id,
      int? uyeId,
      String firsatAdi,
      String aciklama,
      String baslangicTarihi,
      String bitisTarihi,

      ) async {
    try {
      var response = await Dio().post(AppUrl.updateScope, data: {
        "FirsatID": id,
        "UyeId": uyeId,
        "FirsatAdi": firsatAdi,
        "FirsatAciklama": aciklama,
        "BaslangicTarihi": "2022-05-10T12:16:54.089Z",
        "OlusturulmaTarihi": "2022-05-10T12:16:54.089Z",
        "BitisTarihi": "2022-05-10T12:16:54.089Z",
        "MusteriAdi": "",
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
                title: Column(
                  children: [
                    Icon(Icons.check_circle, size: 60, color: Colors.green),
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Fırsat Güncellendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/scope_list", (route) => false);
                      },
                      child: Text(
                        "Kapat",
                        style: TextStyle(fontSize: 17),
                      ))
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
                    child: Text("Kapat", style: TextStyle(fontSize: 17)))
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
