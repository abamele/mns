import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../home-folder/offer_product_widget.dart';



class AddOffer extends StatefulWidget {
  List offer;
  List prod;
  AddOffer({Key? key, required this.offer, required this.prod}) : super(key: key);

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  TextEditingController customeName = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List txtList = ["Teklif Bilgiler", "Ürün Bilgileri"];
  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];
  ValueNotifier<int?> _value1 = ValueNotifier<int?>(null);

  int? _value2=0;
  int? value3=0;
  int? value4=0;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;


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
                  child: Text("Teklifler"),
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
                  padding:
                  const EdgeInsets.symmetric(
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
                        margin: EdgeInsets.only(
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
                          margin:
                          const EdgeInsets
                              .all(10.0),
                          decoration:
                          BoxDecoration(
                              color: Colors
                                  .white,
                              border: Border
                                  .all(
                                color: Colors
                                    .white,
                              ),
                              borderRadius:
                              (BorderRadius
                                  .circular(
                                  12))),
                          child:
                          ValueListenableBuilder(
                            valueListenable:
                            _value1,
                            builder: (context,
                                int?
                                value1Value,
                                Widget? child) {
                              return DropdownButton(
                                  isExpanded:
                                  true,
                                  value:
                                  value1Value,
                                  items: customerDropdownList(
                                      "Seçiniz"),
                                  onChanged: (int?
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
                          margin:
                          EdgeInsets.only(
                              top: 15),
                          child: Text(
                            "Yetkililer",
                            style: TextStyle(
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontSize: 16),
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
                              border: Border
                                  .all(
                                color: Colors
                                    .white,
                              ),
                              borderRadius:
                              (BorderRadius
                                  .circular(
                                  12))),
                          child:
                          ValueListenableBuilder(
                            valueListenable:
                            _value1,
                            builder: (context,
                                int?
                                value2Value,
                                Widget? child) {
                              if (value2Value ==
                                  null) {
                                return Container();
                              } else {
                                return DropdownButton(
                                    isExpanded:
                                    true,
                                    value:
                                    _value2,
                                    items: contactDropdownList("Yetkili Seçiniz...", value2Value - 1),
                                    onChanged: (int?value) {
                                      if (_value2 == 0) {
                                        _value2 = 0;
                                      } else {
                                        _value2 = value;
                                      }
                                      setState(() {});
                                    },
                                    hint: const Text(
                                        "Yetkili Seçiniz..."));
                              }
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(
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
                        margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20),
                        child: TextFormField(
                          controller: date,
                          decoration:
                          InputDecoration(
                            suffixIcon: Icon(
                                Icons
                                    .date_range),
                            helperStyle: TextStyle(
                                color: Color(
                                    0xff5858FF),
                                fontSize: 17),
                          ),
                          onTap: () async {
                            FocusScope.of(
                                context)
                                .requestFocus(
                                new FocusNode());
                            await _openDatePicker1(
                                context);
                            date.text = DateFormat(
                                'dd/MM/yyyy')
                                .format(
                                dateTime1!);
                          },
                          validator: (value) {
                            if (value!
                                .isEmpty) {
                              return "Bu alan zorunludur";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
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
                              (BorderRadius
                                  .circular(
                                  12))),
                          child: DropdownButton(
                              isExpanded: true,
                              value: value4,
                              items: offerStateDropdownList(
                                  "Teklif Durumu Seçiniz..."),
                              onChanged:
                                  (int? value) {
                                value4 = value;
                                if (value4 ==
                                    0) {
                                  value4 = 0;
                                }
                                setState(() {});
                              },
                              hint: const Text(
                                  "Teklif Durumu Seçiniz..."))),
                      Container(
                        margin: EdgeInsets.only(
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
                        margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20),
                        child: TextFormField(
                          controller: comment,
                          keyboardType:
                          TextInputType
                              .multiline,
                          minLines: 4,
                          maxLines: null,
                          decoration:
                          InputDecoration(
                            hintText:
                            "açıklama Ekleyiniz...",
                            helperStyle:
                            TextStyle(
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
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20),
                        child: ElevatedButton(
                          style: ElevatedButton
                              .styleFrom(
                              minimumSize:
                              Size(290,
                                  45),
                              primary:
                              blueColor),
                          child: Text("Devam Et"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              addOffer(
                                  Hive.box("userbox").get("UyeID"),
                                  _value1.toString(),
                                  _value2!,
                                  date.text,
                                  state.text,
                                  comment.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferProductWidget(product: widget.prod,)));
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
            )
          ],
        ),
      ),
    );
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

  contactDropdownList(String title, int index) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List contact = widget.offer[index]["TeklifYetkilileri"];
    /*  print("--------------------------------------------${contact.toString()}");
    print("--------------------------------------------${contact.length}");*/
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
