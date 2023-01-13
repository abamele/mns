import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/home-folder/offer_product_widget.dart';
import '../../../constants/apiHttp.dart';


import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import '../../widgets/list_offer_product_widget.dart';
import 'offer_details.dart';
import 'offer_model.dart';

class OfferList extends StatefulWidget {
  List offer;
  List product;
  OfferList({Key? key, required this.offer, required this.product})
      : super(key: key);

  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  final ValueNotifier<int> take = ValueNotifier<int>(67);
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  TextEditingController customeName = TextEditingController();
  TextEditingController contacts = TextEditingController();
  TextEditingController validityDate = TextEditingController(text: DateFormat("dd-MM-yyyy").format(DateTime.now().add(Duration(days: 7))));
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

  ScrollController scrollController = ScrollController();
  List<OfferModel> offer = [];
  bool loading = true;
  int skipe = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(skipe);
    handleNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: NestedScrollView(
        controller: scrollController,
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
                                _searchTextNotify.value = value;
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
                                        return AlertDialog(
                                          content: Form(
                                            key: formKey,
                                            child: SingleChildScrollView(
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
                                                            child: ValueListenableBuilder(
                                                              valueListenable: _value1,
                                                              builder: (context, int? value1Value,
                                                                  Widget? child) {
                                                                return DropdownButton(
                                                                    isExpanded: true,
                                                                    value: value1Value,
                                                                    items: customerDropdownList(
                                                                        "Seçiniz"),
                                                                    onChanged: (int? value) {
                                                                      if (value == 0) {
                                                                        return;
                                                                      } else {
                                                                        _value1.value = value;
                                                                      }
                                                                    },
                                                                    hint: const Text("Seçiniz..."));
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
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                            ),
                                                            margin: EdgeInsets.only(
                                                                left: 10, right: 10, top: 20),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                  color: Colors.white,
                                                                ),
                                                                borderRadius: (BorderRadius.circular(12))),
                                                            child: ValueListenableBuilder(
                                                              valueListenable: _value1,
                                                              builder: (context, int? value2Value,
                                                                  Widget? child) {
                                                                if (value2Value == null) {
                                                                  return Container();
                                                                } else {
                                                                  return DropdownButton(
                                                                      isExpanded: true,
                                                                      value: _value2,
                                                                      items: contactDropdownList(
                                                                          "Seçiniz...",
                                                                          value2Value - 1),
                                                                      onChanged: (int? value) {
                                                                        /*if (_value2 == 0) {
                                                                          _value2 = 0;
                                                                        } else {
                                                                          _value2 = value;
                                                                        }*/
                                                                        _value2 = value;
                                                                        setState(() {});
                                                                      },
                                                                      hint:
                                                                      const Text("Seçiniz..."));
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
                                                            controller:
                                                            validityDate,
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
                                                                  DateTime.now(),
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
                                                                  validityDate
                                                                      .text =
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
                                                                    "Seçiniz..."),
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
                                                                    "Seçiniz..."))),
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
                                                              "Yazınız...",
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
                                                                    validityDate.text,
                                                                    state.text,
                                                                    comment.text);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => OfferProductWidget(product: widget.product,)));
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
                        ValueListenableBuilder(
                            valueListenable: _searchTextNotify,
                            builder: (BuildContext context, String searchValue,
                                Widget? child) {
                              return ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: offer.length + 1,
                                            itemBuilder: (context, index) {
                                              if (index == offer.length) {
                                                return loading
                                                    ? Container(
                                                  height: 200,
                                                  child: const Center(
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 4,
                                                    ),
                                                  ),
                                                )
                                                    : Container();
                                              }
                                              final _offId = offer[index].offerId ?? "";
                                              final _customNane = offer[index].customerName.toString().toLowerCase() ?? "";
                                              final _offerTxtState = offer[index].offerStatetxt.toString().toLowerCase() ?? "";
                                              final _offState = offer[index].offerStateNum;
                                              final productList = offer[index].product;
                                              final contact = offer[index].contact;
                                              final _offNo = offer[index].offerNo.toString().toLowerCase() ?? "";

                                              return Container(
                                                            margin: EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 20),
                                                            child: Card(
                                                              elevation: 8.0,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    color:
                                                                        blueColor,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                                    child: new Text(
                                                                      "",
                                                                      style: new TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            15.0),
                                                                    child: Text(
                                                                      "Teklif No",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 15.0,
                                                                    ),
                                                                    child: Text(
                                                                        "${_offNo == null ? "" : _offNo}"),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            15.0),
                                                                    child: Text(
                                                                      "Müşteri Adı",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 15.0,
                                                                    ),
                                                                    child: Text(
                                                                        "${_customNane == null ? "" : _customNane}"),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            15.0),
                                                                    child: Text(
                                                                      "Teklif Durumu",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 15.0,
                                                                    ),
                                                                    child: Text(
                                                                        "${_offerTxtState == null ? "" : _offerTxtState}", style: TextStyle(color: colorX(_offState)),),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  ExpansionTile(
                                                                    title: Text(
                                                                      "Yetkililer",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color:
                                                                              redColor),
                                                                    ),
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 20.0),
                                                                            child:
                                                                                Text(
                                                                              "",
                                                                              style: TextStyle(
                                                                                  color: Color(0xff4F4F4F),
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  right:
                                                                                      20.0),
                                                                              child:
                                                                                  TextButton(
                                                                                child:
                                                                                    Text(
                                                                                  "Detaylı Gör",
                                                                                  style: TextStyle(color: violetColor, fontSize: 16),
                                                                                ),
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => OfferDetails(
                                                                                                offerList: offer[index],
                                                                                              ))).then((value) => _reload(value));
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
                                                                      "Ürünler",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color:
                                                                              redColor),
                                                                    ),
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 20.0),
                                                                            child:
                                                                                Text(
                                                                              "",
                                                                              style: TextStyle(
                                                                                  color: Color(0xff4F4F4F),
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  right:
                                                                                      20.0),
                                                                              child:
                                                                                  TextButton(
                                                                                child:
                                                                                    Text(
                                                                                  "Detaylı Gör",
                                                                                  style: TextStyle(color: violetColor, fontSize: 16),
                                                                                ),
                                                                                onPressed:
                                                                                    () {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => ListOfferProductWidget(
                                                                                                prod: offer[index],
                                                                                              ))).then((value) => _reload(value));
                                                                                    },
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

      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future<void> _reload(var value) async {
    setState(() {});
  }

  colorX(int? value) {
    if (value == 1) {
      return Colors.green;
    } else if (value == 2) {
      return Colors.blue;
    } else if (value == 3) {
      return Colors.red;
    }
  }

  void fetchData(
      int skipe,
      ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/teklif/teklifler?_skipe=$skipe",
        data: {
          "sort": [
            {"selector": "string", "desc": false}
          ],
          "group": {},
          "requireTotalCount": true,
          "searchOperation": "string",
          "filterValue": {},
          "searchValue": {},
          "skip": skipe,
          "take": 10,
          "userDatas": [
            {"SelectedField": "string", "SelectedValue": "string"}
          ],
          "filter": ["string"],
          "filterSearchField": "string",
          "filterSearchValue": "string",
          "multiFilterSearch": {},
          "sortingFieldValue": "string",
          "sortingFieldDesc": true,
          "multipleFilters": [
            ["string"]
          ]
        });

    Veri modelClass=Veri.fromJson(response.data);
    offer = offer + modelClass.offer;

    setState(() {
      offer;
      loading = false;
      // offset = localOffset;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(skipe += 10);
      }
    });
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
      if (i == 0 || i<0) {
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
