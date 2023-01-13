import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/apiHttp.dart';
import '../../constants/colors.dart';
import '../screens/offer-folder/offer_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';



class OfferDetailsWidget extends StatefulWidget {
  OfferModel offerList;
  OfferDetailsWidget({Key? key, required this.offerList}) : super(key: key);

  @override
  State<OfferDetailsWidget> createState() => _OfferDetailsWidgetState();
}

class _OfferDetailsWidgetState extends State<OfferDetailsWidget> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _customeName = widget.offerList.customerName ?? '';
    String _contacts = widget.offerList.customerName?? '';
    String _offerDate = widget.offerList.offerDate ?? '';
    String _validityDate = widget.offerList.validityDate ?? '';
    String _offerState = widget.offerList.offerStatetxt ?? '';
    String _comment = widget.offerList.comment?? '';

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Müşteri Adı",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10.0, right: 10, ),
                          child: TextFormField(
                            initialValue: _customeName,
                            decoration: InputDecoration(
                              helperStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Teklif Tarihi",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue:
                      _offerDate,
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
                            _offerDate
                                 =
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
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Geçerlilik Tarihi",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue:
                      _validityDate,
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
                            _validityDate
                                 =
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
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Teklif Durumu",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10.0, right: 10, ),
                    child: TextFormField(
                      initialValue: _offerState,
                      decoration: InputDecoration(
                        helperStyle: TextStyle(
                            color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Açıkalama",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10.0, right: 10, ),
                    child: TextFormField(
                      minLines: 4,
                      maxLines: null,
                      initialValue: _comment,
                      decoration: InputDecoration(
                        helperStyle: TextStyle(
                            color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(290, 45), primary: blueColor),
                      child: Text("Kaydet"),
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          showBusinessLoginDialog();
                          updateOffer(
                              widget.offerList.offerId,
                              Hive.box("userbox").get("UyeID"),
                              _customeName,
                              _contacts,
                              _offerDate,
                              _validityDate,
                              _offerState,
                              _comment);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("")
                ],
              ),
            ),),
                ],
              ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
            );

  }

  /*customerDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.offerList;
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

  contactDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List contact = widget.offerList;
    for (var i = 0; i < contact.length + 1; i++) {
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
              contact[i - 1]["KontakAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }*/

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

  Future updateOffer(
      int? id,
      int? uyeId,
      String customerName,
      String contact,
      String date,
      String validity,
      String state,
      String comment,
      ) async {
    try {
      var response = await Dio().post(AppUrl.updateOffer, data: {
        "TeklifID": id,
        "UyeID": uyeId,
        "SiparisID": 0,
        "Aciklama": comment,
        "TeklifNo": 0,
        "IsDeleted": true,
        "MusteriAdi": customerName,
        "MusteriID": 0,
        "KontakAdi": contact,
        "TeklifTarihi": date,
        "GecerlilikTarihi": validity,
        "PB": "string",
        "TeklifDurumu": 0,
        "AraToplam": "string",
        "ToplamTutar": "string",
        "DuzenlemeTarihi": "2022-06-07T11:32:57.775Z",
        "OlusturmaTarihi": "2022-06-07T11:32:57.775Z",
        "GuncellemeTarihi": "2022-06-07T11:32:57.775Z",
        "VadeTarihi": "2022-06-07T11:32:57.775Z",
        "Doviz": "string",
        "TeklifKosullari": "string",
        "TeklifinDurumu": 0,
        "TeklifDurumuText": "string",
        "HizmetNedeni": "string",
        "KontakID": 0,
        "Email": "string",
        "OlusKullaniciId": 0,
        "GuncelleyenKullaniciId": 0,
        "YetkiliListeIds": [0],
        "TeklifYetkilileri": [
          {
            "KontakAdi": "string",
            "KontakID": 0,
            "Email": "string",
            "CepTelefonu": "string",
            "Departman": "string",
            "DogumTarihi": "2022-06-07T11:32:57.775Z",
            "DogumTarihiFormatli": "string",
            "AdresSatiri1": "string"
          }
        ],
        "GecerlilikTarihiFormatli": "string"
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
                            context, "/offer_list", (route) => false);
                      },
                      child: Text(
                        "Kapat",
                        style: TextStyle(fontSize: 14),
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
