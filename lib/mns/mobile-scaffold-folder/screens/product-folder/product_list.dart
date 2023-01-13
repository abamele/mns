import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mns/mns/mobile-scaffold-folder/screens/product-folder/product_details.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/product-folder/product_model.dart';
import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");

  TextEditingController productName = TextEditingController();
  TextEditingController productCode = TextEditingController();
  TextEditingController attendanceExchange = TextEditingController();
  TextEditingController serviceExchange = TextEditingController();
  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<ProductModel> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int skipe = 0;
  int take = 10;

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
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, isScroll) {
          return [
            SliverAppBar(
              backgroundColor: blueColor,
              elevation: 0.0,
              title: Container(
                margin: EdgeInsets.only(right: 35),
                child: Center(
                  child: Text("Ürünler"),
                ),
              ),
            )
          ];
        },
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
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
            Container(
              margin: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(290, 45), primary: blueColor),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: new Text(
                                          "Ürün Ekle",
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Ürün Adı",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller: productName,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Ürün Kodu",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller: productCode,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Hizmet Bedeli",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller: attendanceExchange,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Servis Bedeli",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller: serviceExchange,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Açıklama",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                minLines: 4,
                                                maxLines: null,
                                                controller: comment,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.black,
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
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                        minimumSize:
                                                        Size(290, 45),
                                                        primary: blueColor),
                                                    child: Text("Kaydet"),
                                                    onPressed: () {
                                                      if(formKey.currentState!.validate()){
                                                        formKey.currentState!.save();
                                                        showBusinessLoginDialog();
                                                        addProduct(
                                                            Hive.box("userbox").get("UyeID"),
                                                            productName.text,
                                                            productCode.text,
                                                            double.parse(attendanceExchange.text),
                                                            double.parse(serviceExchange.text));
                                                      }
                                                    },
                                                  ),
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
                    "Ürün Ekle",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
            ValueListenableBuilder(
                valueListenable: _searchTextNotify,
                builder: (context, String textValue, Widget? widget) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      //controller: scrollController,
                      shrinkWrap: true,
                      itemCount: result.length + 1,
                      itemBuilder: (context, index) {
                        if (index == result.length) {
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

                        final code = result[index].code.toString().toLowerCase();
                        final name = result[index].name.toString().toLowerCase();
                        final comment = result[index].comment.toString().toLowerCase();
                        if (code.contains(textValue.toLowerCase()) ||
                            name.contains(textValue.toLowerCase()) ||
                            comment.contains(textValue.toLowerCase())) {
                          return Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Card(
                              elevation: 8.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    color: blueColor,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: new Text(
                                      "",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Ürün Kodu",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                    ),
                                    child: Text("${code}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Ürün Adı",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                    ),
                                    child: Text("${name}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Açıklama",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                    ),
                                    child: Text("${comment}"),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 35, right: 35, top: 20),
                                    child: Center(
                                      child: ElevatedButton(
                                        child: Text(
                                          "Ürün Detayları",
                                          style: TextStyle(
                                              fontSize: 17, color: Colors.grey),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(290, 45),
                                            primary: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                        productList:
                                                            result[index],
                                                      )));
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
                }),
          ],
        ),
      ),
    );
  }

  void fetchData(
    int skipe,
  ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/urun/urunler?_skipe=$skipe",
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
    print("....................................${modelClass}");
    result = result + modelClass.product;

    //int localOffset = offset + 15;
    setState(() {
      result;
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

  Future addProduct(int? uyeId, String name, String code, double hizmetBedeli,
      double servisBedeli) async {
    try {
      var response = await Dio().post(AppUrl.addProduct, data: {
        "EXPCATEGORY": "string",
        "NAME": "string",
        "CODE": "string",
        "LOGICALREF": 0,
        "UyeId": 0,
        "HizmetBedeli": 0,
        "ServisBedeli": 0
      }).then((value) {
        print("...........................................${value}");
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Ürün Eklendi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/product_list", (route) => false);
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
                    Navigator.pushNamedAndRemoveUntil(context,
                        "/customer_list", (Route<dynamic> route) => false);
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
        })
        .then((value) =>
    _loginLoading.value = {"state": 0, "message": ""});
  }
}
