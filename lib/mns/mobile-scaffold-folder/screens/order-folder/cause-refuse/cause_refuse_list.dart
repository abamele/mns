import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';

import 'package:mns/mns/constants/colors.dart';
import '../../../../constants/apiHttp.dart';
import '../../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import 'cause_refuse_details.dart';
import 'cause_refuse_model.dart';

class CauseRefuseList extends StatefulWidget {
  const CauseRefuseList({Key? key}) : super(key: key);

  @override
  State<CauseRefuseList> createState() => _CauseRefuseListState();
}

class _CauseRefuseListState extends State<CauseRefuseList> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");

  TextEditingController comment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isActive = false;

  ScrollController scrollController = ScrollController();
  List<CauseRefuseModel> causeRefuse = [];
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
                  child: Text("Ret Nedennleri"),
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
                                                      "Ret Nedeni Ekle",
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
                                                            "Açıklama",
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
                                                            }),
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
                                                            onPressed: () {
                                                              if(formKey.currentState!.validate()){
                                                                formKey.currentState!.save();
                                                                addCauseRefuse(Hive.box("userbox").get("UyeID"), comment.text, isActive);
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],
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
                                "Ret Nedeni Ekle",
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
                                            itemCount: causeRefuse.length + 1,
                                            itemBuilder: (context, index) {
                                              if (index == causeRefuse.length) {
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
                                              final _comment =
                                                  causeRefuse[index].comment.toString().toLowerCase() ?? "";
                                              final _createdDate = causeRefuse[index].createdDate.toString().toLowerCase() ?? "";
                                              final _persCreated = causeRefuse[index].persCreated.toString().toLowerCase() ?? "";
                                              final _updateDate = causeRefuse[index].updateDate.toString().toLowerCase() ?? "";
                                              final _persUpdated = causeRefuse[index].persUpdate.toString().toLowerCase() ?? "";

                                              if (_createdDate
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _persCreated
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _updateDate
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _persUpdated
                                                      .contains(searchValue.toLowerCase())) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, right: 20, bottom: 10),
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
                                                            "Açıklama",
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
                                                              "${_comment}"),
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
                                                              "${_createdDate}"),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
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
                                                          height: 40,
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                        SizedBox(
                                                          height: 40,
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
                                                                            CauseRefuseDetails(
                                                                                refuse: causeRefuse[index])));
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


  void fetchData(
      int skipe,
      ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/rednedenleri/tum-ret-nedenleri?_skipe=$skipe",
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

    var modelClass=CauseRefuseModel.causeRefuseList(response.data);
    causeRefuse = causeRefuse + modelClass;

    setState(() {
      causeRefuse;
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

  Future addCauseRefuse(int? uyeId, String aciklama, bool aktiflik) async {
    try {
      var response = await Dio().post(AppUrl.addCauseRefuse, data: {
        "RedID": 0,
        "UyeID": uyeId,
        "RedAciklama": aciklama,
        "OlusturulmaTarihi": "2022-06-28T06:34:16.979Z",
        "OlusturanID": 0,
        "OlusturanKisi": "string",
        "GuncellemeTarihi": "2022-06-28T06:34:16.979Z",
        "GuncelleyenID": 0,
        "GuncelleyenKisi": "string",
        "OlusturulmaTarihiFormatli": "string",
        "GuncellemeTarihiFormatli": "string",
        "Aktiflik": aktiflik
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
}
