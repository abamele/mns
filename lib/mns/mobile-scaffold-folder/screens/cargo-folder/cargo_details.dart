import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import 'cargo_model.dart';

class CargoDetails extends StatefulWidget {
  CargoModel cargo;
  CargoDetails({Key? key, required this.cargo}) : super(key: key);

  @override
  State<CargoDetails> createState() => _CargoDetailsState();
}

class _CargoDetailsState extends State<CargoDetails> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _comment = widget.cargo.cargoName ?? '';
    bool? isActive = widget.cargo.active;

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: blueColor,
          toolbarHeight: 80,
          elevation: 0.0,
          title: Center(
              child: Text(
            "Ret Nedeni Detayları",
            style: TextStyle(color: Colors.white),
          ))),
      body: ListView(
        shrinkWrap: true,
        children: [
          Card(
              elevation: 8.0,
              margin: EdgeInsets.all(20),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                              initialValue: _comment,
                              decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _comment = value;
                                });
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Aktiflik",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                          ),
                          Switch(
                              value: isActive!,
                              onChanged: (value) {
                                setState(() {
                                  isActive = value;
                                });
                              })
                        ],
                      ),
                    ),
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
                          updateCauseRefuse(
                              widget.cargo.id,
                              Hive.box("userbox").get("UyeID"),
                              _comment,
                              isActive!);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("")
                ],
              ))),
        ],
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future updateCauseRefuse(
      int? kargoID, int? uyeId, String kargoAdi, bool aktiflik) async {
    try {
      var response = await Dio().post(AppUrl.updateCargo, data: {
        "KargoID": kargoID,
        "UyeID": uyeId,
        "KargoAdi": kargoAdi,
        "OlusturulmaTarihi": "2022-06-28T10:47:54.725Z",
        "OlusturanID": 0,
        "OlusturanKisi": "string",
        "GuncellemeTarihi": "2022-06-28T10:47:54.725Z",
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/cargo_list", (route) => false);
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
}
