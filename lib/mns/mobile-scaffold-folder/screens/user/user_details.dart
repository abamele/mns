import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/user/user_model.dart';

import '../../../constants/apiHttp.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';

class UserDetails extends StatefulWidget {
  UserModel? userList;
  UserDetails({Key? key, this.userList}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  @override
  Widget build(BuildContext context) {
    String? _userName = widget.userList!.nameSurname;
    String? _email = widget.userList!.email;
    String? _password = widget.userList!.password;
    String? _companyTitle = widget.userList!.companyTitle;
    String? _birthDay = widget.userList!.birthDay;
    String? _phone = widget.userList!.phone;
    String? _country = widget.userList!.country;
    String? _city = widget.userList!.city;
    String? _county = widget.userList!.county;
    String? _address = widget.userList!.address;
    String? _postalCode = widget.userList!.postalCode;
    bool? _userType = widget.userList!.userType;
    String? _website = widget.userList!.website;

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Kullanıcı"),
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
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Ad Soyad",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _userName,
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
                                _userName = value;
                              });
                            },
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
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
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Şifre",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _password,
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
                                _password = value;
                              });
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Fırma Unvan",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _companyTitle,
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
                                _companyTitle = value;
                              });
                            },
                            onSaved: (value) {
                              _companyTitle = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Doğum Tarihi",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _birthDay,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.date_range),
                              helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              await _openDatePicker1(context);
                              _birthDay =
                                  DateFormat('dd/MM/yyyy').format(dateTime1!);
                            },
                            onSaved: (val) {
                              strDate = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Telefon Numarası",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _phone,
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
                                _password = value;
                              });
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Ülke",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _country,
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
                                _country = value;
                              });
                            },
                            onSaved: (value) {
                              _country = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "İl",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _city,
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
                                _city = value;
                              });
                            },
                            onSaved: (value) {
                              _city = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "İlçe",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _county,
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
                                _county = value;
                              });
                            },
                            onSaved: (value) {
                              _county = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Adres",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _address,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            maxLines: null,
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _address = value;
                              });
                            },
                            onSaved: (value) {
                              _address = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Posta Kodu",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _postalCode,
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
                                _postalCode = value;
                              });
                            },
                            onSaved: (value) {
                              _postalCode = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Kullanıcı Tipi",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile<bool>(
                                title: const Text('Admin'),
                                value: true,
                                groupValue: _userType,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value;
                                  });
                                },
                              ),
                              RadioListTile<bool>(
                                title: const Text('Normal'),
                                value: false,
                                groupValue: _userType,
                                onChanged: (value) {
                                  setState(() {
                                    _userType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              left:
                              15.0,
                              top: 15),
                          child: Text(
                            "Web Sitesi",
                            style: TextStyle(
                                fontSize:
                                17,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Colors
                                    .black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            initialValue: _website,
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _website = value;
                              });
                            },
                            onSaved: (value) {
                              _website = value!;
                            },
                          ),
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            showBusinessLoginDialog();
                            updateUser(
                                widget.userList!.id,
                                _userName!,
                                _email!,
                                _password!,
                                _companyTitle!,
                                _birthDay!,
                                _address!,
                                _country!,
                                _city!,
                                _county!,
                                _postalCode!,
                                _userType!,
                                _website!);
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
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
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

  Future updateUser(
      int? id,
      String adSoyad,
      String email,
      String sifre,
      String firmaUnvan,
      String dogumT,
      String adres,
      String ulke,
      String il,
      String ilce,
      String postakodu,
      bool kullaniciTipi,
      String website) async {
    try {
      var response = await Dio().post(AppUrl.updateUser, data: {
        "UyeID": id,
        "KullaniciAdi": email,
        "Sifresi": sifre,
        "FirmaUnvan": firmaUnvan,
        "AdiSoyadi": adSoyad,
        "Onay": true,
        "OnayKodu": "00000000-0000-0000-0000-000000000000",
        "RootAdmin": true,
        "Telefon": "",
        "GSM": "",
        "Adres": adres,
        "Ulke": ulke,
        "Sehir": il,
        "Ilce": ilce,
        "PostaKodu": postakodu,
        "WebSitesi": website,
        "OnayBitisTarihi": "2022-05-10T11:14:33.474Z",
        "DogumTarihi": "2022-05-10T11:14:33.474Z",
        "DogumTarihiFormatli": dogumT,
        "CreatedOn": "2022-05-10T11:14:33.474Z",
        "ModifiedOn": "2022-05-10T11:14:33.474Z",
        "IsDeleted": true,
        "CreatedBy": ""
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
                      "Kullanıcı Güncenllendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/user_list", (route) => false);
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
