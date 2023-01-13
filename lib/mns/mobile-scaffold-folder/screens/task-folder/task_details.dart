import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/task-folder/task_model.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';

class TaskDetails extends StatefulWidget {
  TaskModel? taskList;
  List task;
  TaskDetails({Key? key, required this.taskList, required this.task})
      : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;


  @override
  Widget build(BuildContext context) {
    String _taskDef = widget.taskList!.taskDef ?? '';
    String _taskNom = widget.taskList!.taskNom ?? '';
    String _taskResp = widget.taskList!.taskResp ?? '';
    String _taskType = widget.taskList!.taskType ?? '';
    String _taskStartDate = widget.taskList!.startDate ?? '';
    String _taskEndDate = widget.taskList!.endDate ?? '';
    String _taskState = widget.taskList!.taskState ?? '';
    String _comment = widget.taskList!.comment ?? '';

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Görevler"),
          ),
        ),
      ),
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
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Görev Tanımı",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextFormField(
                          initialValue: _taskDef,
                          decoration: InputDecoration(
                            helperStyle:
                            TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _taskDef = value;
                            });
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Görev Atayan",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _taskNom,
                      decoration: InputDecoration(
                        helperStyle:
                            TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Görev Sorumlusu",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        initialValue: _taskResp,
                        decoration: InputDecoration(
                          helperStyle:
                          TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bu alan zorunludur";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _taskResp = value;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Görev Tipi",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        initialValue: _taskType,
                        decoration: InputDecoration(
                          hintText: 'Aktivite Tipi',
                          helperStyle:
                          TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bu alan zorunludur";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _taskType = value;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Başlangıç Tarihi",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue:
                      _taskStartDate,
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
                            _taskStartDate
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
                      "Bitiş Tarihi",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue:
                      _taskEndDate,
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
                            _taskEndDate
                                 =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print(
                              "seçilmedi");
                        }
                      },
                      onSaved: (val) {
                        endDate = val;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Görev Durumu",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      readOnly: true,
                        initialValue: _taskState,
                        decoration: InputDecoration(
                          helperStyle:
                          TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bu alan zorunludur";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _taskState = value;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Açıkalama",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        initialValue: _comment,
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: null,
                        decoration: InputDecoration(
                          helperStyle:
                          TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _comment = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(290, 45), primary: blueColor),
                      child: Text("Kaydet"),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          showBusinessLoginDialog();
                          updateTask(
                              widget.taskList!.id,
                              Hive.box("userbox").get("UyeID"),
                              _taskDef,
                              Hive.box("userbox").get("UyeID"),
                              _taskNom,
                              Hive.box("userbox").get("UyeID"),
                              _taskResp,
                              _taskType,
                              _taskStartDate,
                              _taskEndDate,
                              _taskState,
                              _comment);
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
        ],
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  taskNominationDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskNomination = widget.task;
    for (var i = 0; i < taskNomination.length + 1; i++) {
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

  Future updateTask(
      int? id,
      int? uyeId,
      String gorevTanimi,
      int gorevAtayanId,
      String gorevAtayan,
      int gorevSorumlusuId,
      String gorevSorumlu,
      String gorevTipi,
      String baslangicTarihi,
      String bitisTarihi,
      String gorevDurumu,
      String aciklama,
      ) async {
    try {
      var response = await Dio().post(AppUrl.updateTask, data: {
        "GorevID": id,
        "UyeId": uyeId,
        "GorevTanimi": gorevTanimi,
        "GoreviAtayanID": gorevAtayanId,
        "GoreviAtayanAdiSoyadi": "string",
        "GorevSorumlusuID": gorevSorumlusuId,
        "GorevSorumlusuAdiSoyadi": gorevSorumlu,
        "GorevTipi": gorevTipi,
        "GorevinDurumu": 0,
        "GorevinAciklamasi": aciklama,
        "GorevBaslangic": "2022-08-29T05:51:25.318Z",
        "GorevBitisTarihi": "2022-08-29T05:51:25.318Z",
        "OlusturulmaTarihi": "2022-08-29T05:51:25.318Z",
        "GuncellemeTarihi": "2022-08-29T05:51:25.318Z",
        "GorevSorumlusu": "string",
        "OlusturanKullaniciId": 0,
        "GorevBaslangicFormatli": baslangicTarihi,
        "GorevBitisFormatli": bitisTarihi,
        "GuncelleyenKullaniciId": 0,
        "GorevDurumuText": "string"
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
                      "Görev Güncellendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/task_list", (route) => false);
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
      print(".........................................................${e}");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            print("....................................................${e}");
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
