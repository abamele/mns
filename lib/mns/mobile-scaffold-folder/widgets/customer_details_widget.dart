import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../constants/apiHttp.dart';
import '../../constants/colors.dart';
import '../../constants/phone_number_format.dart';
import '../screens/customer-folder/customer_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';

class CustomerDetailsWidget extends StatefulWidget {

  CustomerModel customList;
  CustomerDetailsWidget({Key? key, required this.customList}) : super(key: key);

  @override
  State<CustomerDetailsWidget> createState() => _CustomerDetailsWidgetState();
}

class _CustomerDetailsWidgetState extends State<CustomerDetailsWidget> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);
  final ValueNotifier<int> itemList = ValueNotifier<int>(10);
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey=GlobalKey<FormState>();

  final UsNumberTextInputFormatter _phoneNumberFormatter =
  UsNumberTextInputFormatter();

  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _nameController = widget.customList.customerName ?? "";
    String _emailController = widget.customList.email ?? "";
    String _addressController = widget.customList.address ?? "";
    String _phoneController = widget.customList.tel ?? "";

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Form(
              key: formKey,
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
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Müşteri Adı",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10.0, right: 10, ),
                          child: TextFormField(
                            initialValue: _nameController,
                            decoration: InputDecoration(
                              helperStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "E-posta",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10.0, right: 10, ),
                          child: TextFormField(
                            initialValue: _emailController,
                            decoration: InputDecoration(
                              helperStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Telefon",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10.0, right: 10, ),
                          child: TextFormField(
                            initialValue: _phoneController.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10),
                              _phoneNumberFormatter
                            ],
                            decoration: InputDecoration(
                              helperStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Adres",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10.0, right: 10, ),
                          child: TextFormField(
                            minLines: 4,
                            maxLines: null,
                            initialValue: _addressController,
                            decoration: InputDecoration(
                              helperStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(290, 45), primary: blueColor),
                      child: Text("Kaydet"),
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          showBusinessLoginDialog();
                          updateCustomer(
                              widget.customList.customerId,
                              Hive.box("userbox")
                                  .get("UyeID"),
                              _nameController,
                              _emailController,
                              _addressController,
                              _phoneController

                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("")
                ],
              ),
            ),
          )
                ],

      ),
bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

/*  categoryDropdownList() {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.customers;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              "Kategori Seçiniz...",
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1]["KategoriAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }*/

/*  contactDropdownList() {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.customers;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              "Yetkili Seçiniz...",
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1]["KontakAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }*/

  Future updateCustomer(
      int? id,
      int? uyeId,
      String musteriAdi,
      String eposta,
      String telefon,
      String adres,
      ) async {
    try {
      var response = await Dio().post(AppUrl.updateCustomer, data: {
        "MusteriId": id,
        "MusteriAdi": musteriAdi,
        "Sehir": "",
        "Telefon": telefon,
        "Eposta": eposta,
        "YetkiliAdi": "",
        "OlusTarihi": "2022-05-10T12:16:54.157Z",
        "Adres": adres,
        "Ilce": "",
        "TcNo": "",
        "VergiNo": "",
        "VergiDairesi": "",
        "Doviz": "",
        "GercekKisiBool": true,
        "Turu": "",
        "OlusKullanici": "",
        "KategoriId": 0,
        "KontakListeIds": [107],
        "FirsatID": 0,
        "KategoriDurumuText": "",
        "KategoriAdi": "",
        "KontakListeIds": [0],
        "FirsatID": 0,
        "UyeId": uyeId,
        "KategoriDurumuText": "",
        "KategoriAdi": ""
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
                      "Müşteri Güncenllendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            "/customer_list", (Route<dynamic> route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      print("..............................................${e}");
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
