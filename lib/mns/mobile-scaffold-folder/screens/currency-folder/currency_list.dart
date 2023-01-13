import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import 'currency_details.dart';
import 'currency_model.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});

  TextEditingController currency = TextEditingController();
  TextEditingController price = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isActive = false;

  ScrollController scrollController = ScrollController();
  List<CurrencyModel> currencies = [];
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
                  child: Text("Para Birimi Yönetimi"),
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
                                                      "Para Birimi Ekle",
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10, top: 20),
                                                          child: Text(
                                                            "Para Birimi",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                             ),
                                                          child: TextFormField(
                                                            controller: currency,
                                                            decoration:
                                                            InputDecoration(
                                                              hintText:
                                                              'Yazınız...',
                                                              helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  17),
                                                            ),
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
                                                              left: 10, top: 20),
                                                          child: Text(
                                                            "Fiyat",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                            ),
                                                          child: TextFormField(
                                                            controller: price,
                                                            decoration:
                                                            InputDecoration(
                                                              hintText: 'Yazınız...',
                                                              helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  17),
                                                            ),
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
                                                              left: 10,
                                                              right: 10,
                                                              top: 20),
                                                          child: Text("Aktiflik",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17)),
                                                        ),
                                                        Switch(
                                                            value: isActive,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isActive = value;
                                                                print(isActive);
                                                              });
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 35, right: 35),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(290, 45), primary: blueColor),
                                                        onPressed: () {
                                                          if (formKey.currentState!
                                                              .validate()) {
                                                            formKey.currentState!.save();
                                                            showBusinessLoginDialog();
                                                            addCurrency(Hive.box("userbox").get("UyeId"), currency.text, int.parse(price.text));
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
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Text(
                                "Para Birimi Ekle",
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
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: currencies.length + 1,
                                            itemBuilder: (context, index) {
                                              if (index == currencies.length) {
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
                                              final _currencyUnit =
                                                  currencies[index].currency.toString().toLowerCase() ?? "";
                                              final _price =
                                                  currencies[index].price.toString().toLowerCase() ?? "";
                                              final _createDate = currencies[index].createdDate.toString().toLowerCase() ?? "";
                                              final _persCreated =
                                                  currencies[index].persCreated.toString().toLowerCase() ?? "";
                                              final _updateDate = currencies[
                                                      index].updateDate.toString().toLowerCase() ?? "";
                                              final _persUpdated =
                                                  currencies[index].persUpdate.toString().toLowerCase() ?? "";

                                              if (_currencyUnit
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _price
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _createDate
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _persCreated
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _updateDate
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _persUpdated
                                                      .contains(searchValue.toLowerCase())) {
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
                                                          color: blueColor,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
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
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Para Birimi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_currencyUnit}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Fiyat",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child:
                                                              Text("${_price}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Oluşturulma Tarihi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_createDate}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Oluşturan Kişi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_persCreated}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Güncelleme Tarihi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_persUpdated}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Güncelleyen Kişi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_persUpdated}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 35,
                                                                  right: 35,
                                                                  top: 20),
                                                          child: Center(
                                                            child: ElevatedButton(
                                                              child: Text(
                                                                "Ürün Detayları",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      minimumSize:
                                                                          Size(
                                                                              290,
                                                                              45),
                                                                      primary: Colors
                                                                          .white),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            CurrencyDetails(
                                                                                currency: currencies[index])));
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text("")
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Container();
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


  Future addCurrency(int? uyeId, String currency, int fiyat) async {
    try {
      var response = await Dio().post(AppUrl.addCurrency, data: {
        "Id": 0,
        "UyeId": uyeId,
        "Currency": currency,
        "OlusturmaTarihi": "2022-06-27T15:16:43.112Z",
        "OlusturanKullaniciId": 0,
        "OlusturanKisi": "string",
        "GuncellemeTarihi": "2022-06-27T15:16:43.112Z",
        "GuncelleyenKullaniciId": 0,
        "GuncelleyenKisi": "string",
        "OlusturulmaTarihiFormatli": "string",
        "GuncellemeTarihiFormatli": "string",
        "Aktiflik": true,
        "Fiyat": fiyat
      }).then((value) {
        print("...........................................${value}");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
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

  void fetchData(
      int skipe,
      ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/parabirimleri/tum-para-birimleri?_skipe=$skipe",
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

    var modelClass=CurrencyModel.currencyList(response.data);
    currencies = currencies + modelClass;

    setState(() {
      currencies;
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
}
