import 'package:flutter/material.dart';
import 'package:mns/mns/constants/colors.dart';
import 'package:dio/dio.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/home-folder/top_ten_customer_details.dart';
import '../../../constants/apiHttp.dart';
import '../../widgets/bottom-app-bar-widget/bottom_appBar.dart';
import 'package:intl/intl.dart';


class GetDetailsOfMyOffer extends StatefulWidget {
  List offer;
  GetDetailsOfMyOffer({Key? key, required this.offer}) : super(key: key);

  @override
  State<GetDetailsOfMyOffer> createState() => _GetDetailsOfMyOfferState();
}

class _GetDetailsOfMyOfferState extends State<GetDetailsOfMyOffer> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  TextEditingController customeName = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List txtList = ["Teklif Bilgiler", "Ürün Bilgileri"];
  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];
  ValueNotifier<int?> _value1 = ValueNotifier<int?>(null);

  int? _value2;
  int? value3;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
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
        body: ValueListenableBuilder(
            valueListenable: take,
            builder: (BuildContext context, int takeValue, Widget? child) {
              return ValueListenableBuilder(
                  valueListenable: _searchTextNotify,
                  builder: (BuildContext context, String searchValue,
                      Widget? child) {
                    return ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(),
                          child: Center(
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  hintText: 'Ara...',
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                //_searchTextNotify.value = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(290, 45),
                                  primary: blueColor),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return SingleChildScrollView(
                                          child: AlertDialog(
                                            actions: [
                                              Container(
                                                height: 50,
                                                color: blueColor,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: new Text(
                                                  "Teklif Ekle",
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
                                                                      "Müşteri Seçiniz"),
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
                                                                      "Müşteri Seçiniz..."));
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
                                                                    items: contactDropdownList(
                                                                        "Yetkili Seçiniz...",
                                                                        value2Value -
                                                                            1),
                                                                    onChanged: (int?
                                                                        value) {
                                                                      if (_value2 ==
                                                                          0) {
                                                                        _value2 =
                                                                            0;
                                                                      } else {
                                                                        _value2 =
                                                                            value;
                                                                      }
                                                                      setState(
                                                                          () {});
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
                                                              value: _value2,
                                                              items: offerStateDropdownList(
                                                                  "Teklif Durumu Seçiniz..."),
                                                              onChanged:
                                                                  (int? value) {
                                                                _value2 = value;
                                                                if (_value2 ==
                                                                    0) {
                                                                  _value2 = 0;
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
                                                          child: Text("Kaydet"),
                                                          onPressed: () {},
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
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Text(
                                "Teklif Ekle",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        widget.offer.isEmpty
                            ? Container(
                                child: Text(
                                  "Veri Yok",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.offer.length,
                                itemBuilder: (context, index) {
                                  final _offId = widget.offer[index]["TeklifID"]
                                      .toString();
                                  final _customNane = widget.offer[index]
                                          ["MusteriAdi"]
                                      .toString()
                                      .toUpperCase();
                                  final _offerState =
                                      widget.offer[index]["TeklifDurumuText"];
                                  final _offState =
                                      widget.offer[index]["TeklifinDurumu"];
                                  final productList =
                                      widget.offer[index]["Sepet"];
                                  final customerContact =
                                      widget.offer[index]["TeklifYetkilileri"];
                                  final _offNo =
                                      widget.offer[index]["TeklifNo"];
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: customerContact.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          child: Card(
                                            elevation: 8.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  color: blueColor,
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: new Text(
                                                    "${_offNo}",
                                                    style: new TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    "Teklif No",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  child: Text(
                                                      "${_offNo == null ? "" : _offNo}"),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    "Müşteri Adı",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  child: Text(
                                                      "${_customNane == null ? "" : _customNane}"),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    "Teklif Durumu",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  child: Text(
                                                      "${_offerState == null ? "" : _offerState}"),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ExpansionTile(
                                                  title: Text(
                                                    "Yetkililer",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: redColor),
                                                  ),
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "${customerContact[i]["KontakAdi"] == null ? "" : customerContact[i]["KontakAdi"]}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff4F4F4F),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        20.0),
                                                            child: TextButton(
                                                              child: Text(
                                                                "Detaylı Gör",
                                                                style: TextStyle(
                                                                    color:
                                                                        violetColor,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TopTenCustomerDetails(
                                                                                offerList: widget.offer[index])));
                                                              },
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ExpansionTile(
                                                  title: Text(
                                                    "Teklifler",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: redColor),
                                                  ),
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "${widget.offer[index]["TeklifNo"] == null ? "" : widget.offer[index]["TeklifNo"]}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff4F4F4F),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        20.0),
                                                            child: TextButton(
                                                              child: Text(
                                                                "Detaylı Gör",
                                                                style: TextStyle(
                                                                    color:
                                                                        violetColor,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              onPressed: () {},
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                })
                      ],
                    );
                  });
            }),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  Future<void> _reload(var value) async {
    setState(() {});
  }

  colorX(int value) {
    if (value == 1) {
      return Colors.green;
    } else if (value == 2) {
      return Colors.blue;
    } else if (value == 3) {
      return Colors.red;
    }
  }

  Future getOfferList(int take) async {
    try {
      var response = await Dio().post(AppUrl.offerList, data: {
        "sort": [
          {"selector": "", "desc": true}
        ],
        "group": {},
        "requireTotalCount": true,
        "searchOperation": "",
        "filterValue": {},
        "searchValue": {},
        "skip": 0,
        "take": take,
        "userDatas": [
          {"SelectedField": "", "SelectedValue": ""}
        ],
        "filter": [""],
        "filterSearchField": "",
        "filterSearchValue": "",
        "multiFilterSearch": {},
        "sortingFieldValue": "",
        "sortingFieldDesc": true,
        "multipleFilters": [
          [""]
        ]
      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future deleteOffer(int id, int uyeId) async {
    try {
      var response = await Dio()
          .post(
              "https://crm.mnsbilisim.com/api/teklif/teklif-sil?Id=$id&SessionUyeId=$uyeId")
          .then((value) {
        print("işlem gerçekleşti------------------------ $value");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Teklif Silindi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/offer_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
    } on DioError catch (e) {
      print("işlem olmadı beeeeeeeee ------------------------ ${e.response}");
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
