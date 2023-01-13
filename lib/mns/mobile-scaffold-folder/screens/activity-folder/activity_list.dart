import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';

import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';
import 'package:intl/intl.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';

import 'activite_details.dart';
import 'activity_model.dart';

class ActivityList extends StatefulWidget {
  List activities;
  ActivityList({Key? key, required this.activities}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  TextEditingController customerName = TextEditingController();
  TextEditingController activityGender = TextEditingController();
  TextEditingController activityType = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController dateOfActivity = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  TextEditingController email = TextEditingController();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  ValueNotifier<int?> _value1 = ValueNotifier<int?>(null);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final ValueNotifier<int> take = ValueNotifier<int>(50);

  final formKey = GlobalKey<FormState>();

  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];

  int _value2 = 0;
  int _value3 = 0;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  ScrollController scrollController = ScrollController();
  List<ActivityModel> activity = [];
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
                  child: Text("Aktiviteler"),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child: new Text(
                                                      "Aktivite Ekle",
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 40),
                                                          child: Text(
                                                            "Müşteriler",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
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
                                                                  top: 10),
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
                                                                      Widget?
                                                                          child) {
                                                                    return DropdownButton(
                                                                        isExpanded:
                                                                            true,
                                                                        value:
                                                                            value1Value,
                                                                        items: customerDropdownList(
                                                                            "Seçiniz..."),
                                                                        onChanged:
                                                                            (int?
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
                                                                  }),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Yetkililer",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
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
                                                            ),
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
                                                                        (BorderRadius.circular(
                                                                            12))),
                                                            child:
                                                                ValueListenableBuilder(
                                                              valueListenable:
                                                                  _value1,
                                                              builder: (context,
                                                                  int?
                                                                      value2Value,
                                                                  Widget?
                                                                      child) {
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
                                                                          "Seçiniz...",
                                                                          value2Value -
                                                                              1),
                                                                      onChanged:
                                                                          (int?
                                                                              value) {
                                                                        /*if (_value2 ==
                                                                            0) {
                                                                          _value2 =
                                                                              0;
                                                                        } else {
                                                                          _value2 = value!;
                                                                        }*/
                                                                        _value2 =
                                                                            value!;
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      hint: const Text(
                                                                          "Yetkili Seçiniz..."));
                                                                }
                                                              },
                                                            )),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Aktivite Türü",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                activityGender,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Aktivite Tipi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                activityType,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Aktivite Durumu",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
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
                                                                  border: Border
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
                                                              value: _value3,
                                                              items: aktivityStateDropdownList(
                                                                  "Seçiniz..."),
                                                              onChanged:
                                                                  (int? value) {
                                                                print(
                                                                    "........durummmmmmmmmm.........${_value3}");
                                                                _value3 =
                                                                    value!;
                                                                if (_value3 ==
                                                                    0) {
                                                                  _value3 = 0;
                                                                }
                                                                setState(() {});
                                                              },
                                                              hint: const Text(
                                                                  "Seçiniz...")),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Açıklama",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
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
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Aktivite Tarihi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            readOnly: false,
                                                            controller:
                                                                dateOfActivity,
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
                                                            /* onTap: () async {
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
                                                                  dateOfActivity
                                                                          .text =
                                                                      formattedDate; //set output date to TextField value.
                                                                });
                                                              } else {
                                                                print(
                                                                    "seçilmedi");
                                                              }
                                                            },*/
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Email",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller: email,
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
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 35, right: 35),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    Size(290,
                                                                        45),
                                                                primary:
                                                                    blueColor),
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            //showBusinessLoginDialog();
                                                            formKey
                                                                .currentState!
                                                                .save();
                                                             addMeeting(
                                                                Hive.box(
                                                                        "userbox")
                                                                    .get(
                                                                        "UyeID"),
                                                                customerName
                                                                    .text,
                                                                activityGender
                                                                    .text,
                                                                activityType
                                                                    .text,
                                                                comment.text,
                                                                dateOfActivity
                                                                    .text,
                                                                email.text);
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
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
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text("Kapat"))
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        },
                                                        child: Text(
                                                          "Kaydet",
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
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
                                "Aktivite Ekle",
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
                                      itemCount: activity.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == activity.length) {
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
                                            activity[index].comment.toString().toLowerCase() ?? "";
                                        final _email =
                                            activity[index].email.toString().toLowerCase() ?? "";
                                        final _customerName =
                                            activity[index].customerName.toString().toLowerCase() ?? "";
                                        final _contactName =
                                            activity[index].contactName.toString().toLowerCase() ?? "";

                                        if (_customerName
                                                .contains(searchValue.toLowerCase()) ||
                                            _contactName
                                                .contains(searchValue.toLowerCase()) ||
                                            _email
                                                .contains(searchValue.toLowerCase())) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
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
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Açıklama",
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
                                                    child: Text("${_comment}"),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "E-mail",
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
                                                    child: Text("${_email}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
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
                                                        "${_customerName}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Kontak Adı",
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
                                                    child:
                                                        Text("${_contactName}"),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 35,
                                                        right: 35,
                                                        top: 20),
                                                    child: Center(
                                                      child: ElevatedButton(
                                                        child: Text(
                                                          "Ürün Detayları",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.grey),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    Size(290, 45),
                                                                primary:
                                                                    Colors.white),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ActivityDetails(
                                                                            activityList:
                                                                                activity[index],
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
                            })
                      ],
                    );
                  });
            }),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  customerDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customers = widget.activities;
    for (var i = 0; i < customers.length + 1; i++) {
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
              customers[i - 1]["MusteriAdi"].toString(),
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
    List contacts = widget.activities[index]["KontakListe"];
    for (var i = 0; i < contacts.length + 1; i++) {
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
              contacts[i - 1]["KontakAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  aktivityStateDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List aktState = txtState;
    for (var i = 0; i < aktState.length + 1; i++) {
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
              aktState[i - 1],
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

  void fetchData(
    int skipe,
  ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/aktivite/aktiviteler?_skipe=$skipe",
        data: {
          "sort": [
            {"selector": "string", "desc": true}
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
    activity = activity + modelClass.activity;
    //int localOffset = offset + 15;
    setState(() {
      activity;
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

  Future addMeeting(int? uyeId, musteriAdi, aktiviteTuru, aktiviteTipi,
      aciklama, aktiviteTarihi, email) async {
    try {
      var response = await Dio().post(AppUrl.addAktivity, data: {
        "AktiviteKodu": 0,
        "KontakID": 0,
        "UyeID": uyeId,
        "MusteriAdi": musteriAdi,
        "KontakAdi": "0",
        "AktiviteTuru": aktiviteTuru,
        "AktiviteTipi": aktiviteTipi,
        "Aciklama": aciklama,
        "AktiviteDurumu": 0,
        "AktiviteTarihi": aktiviteTarihi,
        "OlusturmaTarihi": "2022-04-20T10:51:35.448Z",
        "Email": email,
        "MusteriID": 0,
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Aktivite kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/activity_list", (route) => false);
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
