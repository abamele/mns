import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/activity-folder/activity_model.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';

class ActivityDetails extends StatefulWidget {
  ActivityModel? activityList;
  ActivityDetails({Key? key, this.activityList}) : super(key: key);

  @override
  State<ActivityDetails> createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _customerName = widget.activityList!.customerName ?? "";
    String _contactName = widget.activityList!.contactName ?? "";
    String _activityGender = widget.activityList!.activityGender ?? "";
    String _activityType = widget.activityList!.activityType ?? "";
    String _comment = widget.activityList!.comment ?? "";
    //TextEditingController _activityState = TextEditingController(text: widget.activityList["AktiviteDurumu"]);
    String _activityDate = widget.activityList!.startDate ?? "";
    String _persCreated = widget.activityList!.persCreated ?? "";
    String _email = widget.activityList!.email ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Aktivite"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: blueColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      "Düzenle",
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Müşteri Adı", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _customerName,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                          /*    validator: (value) {
                                if (value!.isEmpty) {
                                  return "Bu alan zorunludur";
                                }
                              },*/
                              onChanged: (value) {
                                setState(() {
                                  _customerName = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Kontak Adı", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _contactName,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              /*validator: (value) {
                                if (value!.isEmpty) {
                                  return "Bu alan zorunludur";
                                }
                              },*/
                              onChanged: (value) {
                                setState(() {
                                  _contactName = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Aktivite Türü", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _activityGender,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            /*  validator: (value) {
                                if (value!.isEmpty) {
                                  return "Bu alan zorunludur";
                                }
                              },*/
                              onChanged: (value) {
                                setState(() {
                                  _activityGender = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Aktivite Tipi", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _activityType,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                           /*   validator: (value) {
                                if (value!.isEmpty) {
                                  return "Bu alan zorunludur";
                                }
                              },*/
                              onChanged: (value) {
                                setState(() {
                                  _activityType = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Açıklama Yazınız", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Durumu", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Başlangiç Tarihi", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _activityDate,
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
                                  _activityDate = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Oluşturan Kişi", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _persCreated,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _persCreated = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text("Email", style: TextStyle(color: Colors.black, fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                              initialValue: _email,
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
                                  _email = value;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                            updateActivity(
                                widget.activityList!.id,
                                _customerName,
                                _contactName,
                                _activityGender,
                                _activityType,
                                _comment,
                                _activityDate,
                                _persCreated,
                                _email);
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future updateActivity(
      int? uyeId,
      String musteriAdi,
      String kontakadi,
      String aktiviteTuru,
      String aktiviteTipi,
      String aciklama,
      String aktiviteTarihi,
      String olusturan,
      String email,
      ) async {
    try {
      var response = await Dio().post(AppUrl.updateActivity, data: {
        "AktiviteKodu": 0,
        "KontakID": 0,
        "UyeId": uyeId,
        "MusteriAdi": musteriAdi,
        "KontakAdi": kontakadi,
        "AktiviteTuru": aktiviteTuru,
        "AktiviteTipi": aktiviteTipi,
        "Aciklama": aciklama,
        "AktiviteDurumu": 0,
        "AktiviteTarihi": "2022-05-10T12:16:54.070Z",
        "OlusturmaTarihi": "2022-05-10T12:16:54.070Z",
        "OlusKullanici": olusturan,
        "Email": email,
        "MusteriID": 0,
        "AktiviteTarihiFormatli": aktiviteTarihi
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
                      "Aktivite Güncellendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/activity_list");
                      },
                      child: Text(
                        "Kapat",
                        style: TextStyle(fontSize: 17),
                      ))
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
