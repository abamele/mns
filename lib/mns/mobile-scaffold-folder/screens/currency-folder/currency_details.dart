import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import 'currency_model.dart';

class CurrencyDetails extends StatefulWidget {
  CurrencyModel currency;
  CurrencyDetails({Key? key, required this.currency}) : super(key: key);

  @override
  State<CurrencyDetails> createState() => _CurrencyDetailsState();
}

class _CurrencyDetailsState extends State<CurrencyDetails> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double? _currency = widget.currency.currency;
    //String _price = widget.currency["Fiyat"].toString();
    bool? _isActive = widget.currency.active;

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          toolbarHeight: 70,
          title: Center(
              child: Text(
            "Para Birimi Detayları",
            style: TextStyle(color: Colors.white),
          ))),
      body: Card(
          elevation: 8.0,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                color: blueColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: new Text(
                  "",
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _currency.toString() ,
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
                              _currency = value as double;
                            });
                          },
                          onSaved: (value) {
                            _currency = value as double;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _currency.toString(),
                          keyboardType: TextInputType.number,
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
                              _currency = value as double;
                            });
                          },
                          onSaved: (value) {
                            _currency = value as double;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Aktiflik",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      ),
                      Switch(
                          value: _isActive!,
                          onChanged: (value) {
                            setState(() {
                              _isActive = value;
                              print(_isActive);
                            });
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                      updateCurrency(
                          widget.currency.id,
                          Hive.box("userbox").get("UyeId"),
                          _currency.toString(),
                          double.tryParse(_currency.toString()) ?? 0.0,
                          _isActive!);
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text("")
            ],
          )),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future updateCurrency(
      int? id, int? uyeId, String currency, double fiyat, bool aktiflik) async {
    try {
      var response = await Dio().post(AppUrl.updateCurrency, data: {
        "Id": id,
        "UyeId": uyeId,
        "Currency": currency,
        "OlusturmaTarihi": "2022-06-27T15:16:43.112Z",
        "OlusturanKullaniciId": 0,
        "OlusturanKisi": "string",
        "GuncellemeTarihi": "2022-06-27T15:16:43.112Z",
        "GuncelleyenKullaniciId": 0,
        "GuncelleyenKisi": "string",
        "OlusturulmaTarihiFormatli": "string",
        "GuncellemeTarihiFormatli": "string",
        "Aktiflik": aktiflik,
        "Fiyat": fiyat
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
                            context, "/currency_manager", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      print(".................htaaaaaaaaa..........................${e}");
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
