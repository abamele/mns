import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';
import '../../widgets/bottom-app-bar-widget/bottom_appBar.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import '../../widgets/expandable-fab-button-widget/action_button.dart';
import '../../widgets/expandable-fab-button-widget/expandable_fab_button_widget.dart';

class IntegrationManagement extends StatefulWidget {
  IntegrationManagement({Key? key, }) : super(key: key);

  @override
  State<IntegrationManagement> createState() => _IntegrationManagementState();
}

class _IntegrationManagementState extends State<IntegrationManagement> {
  final ValueNotifier<Map> _loginLoading = ValueNotifier<Map>({"state": 0, "message": ""});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Center(
              child: Text(
                "Entegrasyon Yönetimi",
                style: TextStyle(color: Colors.white),
              ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: blueColor,
                minimumSize: Size(290, 55)
              ),
              child: Text("LOGO ENTEGRASYONU ÇALIŞTIR"),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext conetext) {
                      return AlertDialog(
                        content: Text(
                          "Logo Entegrasyonunu Çalıştırmak Istediğinize Emin Misiniz?",
                          style: TextStyle(fontSize: 17),
                        ),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Vazgeç")),
                          Container(
                              margin: EdgeInsets.only(right: 90),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () {
                                    showBusinessLoginDialog();
                                    startIntegration();
                                  },
                                  child: Text("Kaydet"))),
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future startIntegration() async {
    try {
      var response = await Dio().post(AppUrl.integra, data: {}).then((value) {
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
                      "Başarılı",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/homepage");
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
                    Navigator.pushNamedAndRemoveUntil(context,
                        "/home_page", (Route<dynamic> route) => false);
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
