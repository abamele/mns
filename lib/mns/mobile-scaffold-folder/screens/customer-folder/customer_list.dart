import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';
import '../../../constants/phone_number_format.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import '../../widgets/list_customer_offer_widget.dart';
import 'customer_details.dart';
import 'customer_model.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
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

  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  String _groupValue = '';
  bool isAdmin = true;

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  ScrollController scrollController = ScrollController();
  List<CustomerModel> customer = [];
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
                  child: Text("Müşteriler"),
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: new Text(
                                                    "Müşteri Ekle",
                                                    style: new TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "Müşteri Adı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          controller:
                                                              customerName,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "E-posta",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          controller: email,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "Telefon",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          controller: phone,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "[0-9]")),
                                                            LengthLimitingTextInputFormatter(
                                                                10),
                                                            _phoneNumberFormatter
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "İl",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          controller: city,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "İlçe",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          controller: county,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          "Adres",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                          right: 10,
                                                        ),
                                                        child: TextFormField(
                                                          minLines: 4,
                                                          maxLines: null,
                                                          controller: address,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Yazınız...",
                                                            helperStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(290, 45),
                                                            primary: blueColor),
                                                    child: Text("Kaydet"),
                                                    onPressed: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        formKey.currentState!
                                                            .save();
                                                        showBusinessLoginDialog();
                                                        addCustomer(
                                                            Hive.box("userbox")
                                                                .get("UyeID"),
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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Lütfen zorunlu alanları giriniz."),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          "Kapat"))
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                "Müşteri Ekle",
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
                                  itemCount: customer.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == customer.length) {
                                      return loading
                                          ? Container(
                                              height: 200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 4,
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }
                                    final _customerName = customer[index]
                                            .customerName
                                            .toString()
                                            .toLowerCase() ??
                                        "";
                                    final _adres = customer[index]
                                            .address
                                            .toString()
                                            .toLowerCase() ??
                                        "";
                                    final _email = customer[index]
                                            .email
                                            .toString()
                                            .toLowerCase() ??
                                        "";
                                    final _telefon = customer[index].tel ?? "";
                                    final contactList = customer[index].contact;
                                    final offerList = customer[index].offer;

                                    if (_customerName.contains(
                                            searchValue.toLowerCase()) ||
                                        _email.contains(
                                            searchValue.toLowerCase()) ||
                                        _telefon.contains(
                                            searchValue.toLowerCase())) {
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: new Text(
                                                  "",
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "E-mail",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Text(
                                                    "${_email == null ? "" : _email}"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Telefon",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Text(
                                                    "${_telefon == null ? "" : _telefon}"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Adres",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Text(
                                                    "${_adres == null ? "" : _adres}"),
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
                                                          "",
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
                                                                  right: 20.0),
                                                          child: TextButton(
                                                            child: Text(
                                                              "Detaylı Gör",
                                                              style: TextStyle(
                                                                  color:
                                                                      violetColor,
                                                                  fontSize: 16),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          CustomerDetails(
                                                                            customList:
                                                                                customer[index],
                                                                          )));
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
                                                          "",
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
                                                                  right: 20.0),
                                                          child: TextButton(
                                                            child: Text(
                                                              "Detaylı Gör",
                                                              style: TextStyle(
                                                                  color:
                                                                      violetColor,
                                                                  fontSize: 16),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ListCustomerOfferWidget(
                                                                            offerList:
                                                                                customer[index],
                                                                          )));
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
                                    }
                                    return Container();
                                  });
                            }),
                      ],
                    );
                  });
            }),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  void fetchData(
    int skipe,
  ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/musteri/musteriler?_skipe=$skipe",
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

    Veri modelClass = Veri.fromJson(response.data);
    customer = customer + modelClass.custom;

    setState(() {
      customer;
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
