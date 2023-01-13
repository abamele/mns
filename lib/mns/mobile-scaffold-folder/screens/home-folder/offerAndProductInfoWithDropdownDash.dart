import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/home-folder/dashboard_page.dart';

import '../../../constants/apiHttp.dart';

class offerAndProductInfoWithDropdownDash extends StatefulWidget {
  const offerAndProductInfoWithDropdownDash({Key? key}) : super(key: key);

  @override
  State<offerAndProductInfoWithDropdownDash> createState() => _offerAndProductInfoWithDropdownDashState();
}

class _offerAndProductInfoWithDropdownDashState extends State<offerAndProductInfoWithDropdownDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: offerList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Bir şeyler yanlış gitti.'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> data1 = snapshot.data.data as Map<String, dynamic>;

            List _offerList = data1["Veri"];
            return FutureBuilder(
              future: productList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Bir şeyler yanlış gitti.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> data2 =
                snapshot.data.data as Map<String, dynamic>;

                List product = data2["Veri"];

                return DashboardScreen(offer: _offerList, prod: product,);
              },
            );
          },
        ));
  }

  Future offerList() async {
    try {
      var response = await Dio().post(AppUrl.offerList, data: {
        "sort": [
          {"selector": "", "desc": true}
        ],
        "group": {},
        "requireTotalCount": true,
        "searchOperation": "",
        "filterValue": {},
        "searchValue": {},
        "skip": 0,
        "take": 10,
        "userDatas": [
          {"SelectedField": "", "SelectedValue": ""}
        ],
        "filter": [""],
        "filterSearchField": "",
        "filterSearchValue": "",
        "multiFilterSearch": {},
        "sortingFieldValue": "",
        "sortingFieldDesc": true,
        "multipleFilters": [
          [""]
        ]
      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future productList() async {
    try {
      var response = await Dio().post(AppUrl.offerproductList, data: {
        "skip": 0,
        "take": 10,
        "searchValue": ""
      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}