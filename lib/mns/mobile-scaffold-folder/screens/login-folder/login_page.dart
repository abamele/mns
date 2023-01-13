import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mns/mns/constants/colors.dart';
import '../../../constants/apiHttp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});

  final formKey = GlobalKey<FormState>();
  late bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Container(
          child: Center(child: Image.asset("assets/image 1.png"),),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Rectangle 8.png"),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.only(left: 20, right: 20,),
                child: Container(
                  color: Colors.white,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 30, top: 20),
                            child: TextFormField(
                              focusNode: FocusNode(),
                              controller: _userName,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email_outlined),
                                  hintText: 'Kullanıcı Adı',
                                  helperStyle:
                                      TextStyle(color: Colors.grey, fontSize: 17)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen kullanıcı adı giriniz";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 30, top: 20),
                            child: TextFormField(
                              focusNode: FocusNode(),
                              controller: _password,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                icon: IconButton(
                                  icon: Icon(hidePassword
                                      ? Icons.key_off_outlined
                                      : Icons.key),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                                hintText: 'Şifre',
                                helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                suffixIcon: IconButton(
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Şifre veya kullanıcı adınızı giriniz";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: LoginButton()
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget LoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(290, 45),
          primary: blueColor),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          loginRequest(_userName.text, _password.text);
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Hata"),
                  content: const Text("Giriş bilgileriniz hatalı"),
                  actions: [
                    MaterialButton(
                        child: const Text("Tamam"),
                        onPressed: () => Navigator.pop(context))
                  ],
                );
              });
        }
      },
        child: Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 16),
        )
    );
  }

  void loginRequest(String userName, String password) async {
    showBusinessLoginDialog();
    try {
      var response = await Dio().post(AppUrl.login,
          data: {"KullaniciAdi": userName, "Sifresi": password}).then((value) {
        print(value.toString());
        if (value.data["Veri"] == null) {
          _loginLoading.value = {
            "state": 2,
            "message": "Kullanıcı adı veya şifre hatalı"
          };
        } else {
          _loginLoading.value = {"state": 1, "message": ""};
          Hive.box("userbox").putAll({
            "AdiSoyadi": value.data["Veri"]["AdiSoyadi"],
            "CreatedOn": value.data["Veri"]["CreatedOn"],
            "GSM": value.data["Veri"]["GSM"],
            "KullaniciAdi": value.data["Veri"]["KullaniciAdi"],
            "DogumTarihiFormatli": value.data["Veri"]["DogumTarihiFormatli"],
            "Adres": value.data["Veri"]["Adres"],
            "UyeID": value.data["Veri"]["UyeID"],
            "Aktiflik": value.data["Veri"]["Aktiflik"],
          });
        }
      });
      return response;
    } on DioError catch (e) {
      _loginLoading.value = {"state": 2, "message": "${e.response}"};
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
                        context, "/home_page", (Route<dynamic> route) => false);
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
                            _userName.clear();
                            _password.clear();
                          },
                          child: const Text("Tamam"))
                    ],
                  );
                }
              });
        }).then((value) => _loginLoading.value = {"state": 0, "message": ""});
  }
}
