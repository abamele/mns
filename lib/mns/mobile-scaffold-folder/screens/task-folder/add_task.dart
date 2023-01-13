import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';


class AddTask extends StatefulWidget {
  List task;
  AddTask({Key? key, required this.task}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskDef = TextEditingController();
  TextEditingController taskNomi = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskState = TextEditingController();
  TextEditingController taskComment = TextEditingController();
  TextEditingController taskStartedDate = TextEditingController();
  TextEditingController taskEndDate = TextEditingController();
  TextEditingController taskResp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<Map> _loginLoading = ValueNotifier<Map>({"state": 0, "message": ""});

  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;
  int _value1 = 0;
  int _value2 = 0;

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
                  child: Text("Görevler"),
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
                          "Görev Ekle",
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
                          margin: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Görev Tanımı",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  controller: taskDef,
                                  decoration: InputDecoration(
                                    hintText: "Yazınız... ",
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Görev Atayan",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: (BorderRadius.circular(12))),
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: _value1,
                                    items: taskNominationDropdownList("Seçiniz..."),
                                    onChanged: (int? value) {
                                      _value1 = value!;
                                      if (_value1 == 0) {
                                        _value1 = 0;
                                      }
                                      setState(() {});
                                    },
                                    hint: const Text("Seç...")),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Sorumlu",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: (BorderRadius.circular(12))),
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: _value2,
                                    items: taskRespDropdownList("Seçiniz..."),
                                    onChanged: (int? value) {
                                      _value2 = value!;
                                      if (_value2 == 0) {
                                        _value2 = 0;
                                      }
                                      setState(() {});
                                    },
                                    hint: const Text("Seçiniz...")),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Görev Tipi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: taskType,
                                  decoration: InputDecoration(
                                    hintText: "Yazınız... ",
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Başlangıç Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: taskStartedDate,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.date_range),
                                    hintText: 'Yazınız...',
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                  onTap: () async{
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    await _openDatePicker1(context);
                                    taskStartedDate.text = DateFormat('dd/MM/yyyy').format(dateTime1!);
                                  },
                                  onSaved: (val){
                                    strDate=val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Bitiş Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: taskEndDate,
                                  decoration: InputDecoration(
                                    hintText: 'Yazınız...',
                                    suffixIcon: Icon(Icons.date_range),
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                  onTap: () async{
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    await _openDatePicker2(context);
                                    taskEndDate.text = DateFormat('dd/MM/yyyy').format(dateTime2!);
                                  },
                                  onSaved: (val){
                                    endDate=val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Görev Durumu",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: (BorderRadius.circular(12))),
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: _value2,
                                    items: offerStateDropdownList("Seçiniz..."),
                                    onChanged: (int? value) {
                                      _value2 = value!;
                                      if (_value2 == 0) {
                                        _value2 = 0;
                                      }
                                      setState(() {});
                                    },
                                    hint: const Text("Seçiniz...")),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
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
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  controller: taskComment,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 4,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Yazınız...",
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: blueColor,
                                  minimumSize: Size(290, 50)
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                    child: Text(
                                      "Kaydet",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  addTask(
                                      Hive.box("userbox").get("UyeID"),
                                      taskDef.text,
                                      taskNomi.text,
                                      taskType.text,
                                      taskResp.text,
                                      taskStartedDate.text,
                                      taskEndDate.text,
                                      taskState.text,
                                      taskComment.text);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("")
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

  taskDefDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskDef=widget.task;
    for (var i = 0; i < taskDef.length + 1; i++) {
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
              taskDef[i - 1]["GorevTanimi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  taskNominationDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskNomination=widget.task;
    for (var i = 0; i < taskNomination.length + 1; i++) {
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
              taskNomination[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  taskRespDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskResp=widget.task;
    for (var i = 0; i < taskResp.length + 1; i++) {
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
              taskResp[i - 1]["AdiSoyadi"].toString(),
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

  Future addTask(int? uyeId, gorevTanimi, gorevAtayan, gorevTipi, gorevSorumlu,
      baslangicTarihi, bitisTarihi, gorevDurumu, gorevAciklamasi) async {
    showBusinessLoginDialog();
    try {
      var response = await Dio().post(AppUrl.addTask, data: {
        "GorevID": 0,
        "UyeID":uyeId,
        "GorevTanimi": gorevTanimi,
        "GoreviAtayanID": 0,
        "GoreviAtayanAdiSoyadi": gorevAtayan,
        "GorevSorumlusuID": 0,
        "GorevTipi": gorevTipi,
        "GorevinDurumu": 0,
        "GorevinAciklamasi": gorevAciklamasi,
        "GorevBaslangic": baslangicTarihi,
        "GorevBitisTarihi": bitisTarihi,
        "OlusturulmaTarihi": "2022-04-20T10:51:35.496Z",
        "GorevSorumlusu": gorevSorumlu,
        "GorevBaslangicFormatli": "",
        "GorevBitisFormatli": "",
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Görev kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/task_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print(response);
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
                    Navigator.pushNamedAndRemoveUntil(context,
                        "/homepage", (Route<dynamic> route) => false);
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
