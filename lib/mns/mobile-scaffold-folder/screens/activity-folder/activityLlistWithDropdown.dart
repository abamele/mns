import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/apiHttp.dart';
import 'activity_list.dart';

class activityLlistWithDropdown extends StatefulWidget {
  const activityLlistWithDropdown({Key? key}) : super(key: key);

  @override
  State<activityLlistWithDropdown> createState() => _activityLlistWithDropdownState();
}

class _activityLlistWithDropdownState extends State<activityLlistWithDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getActivityList(),
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
          Map<String, dynamic> data =
          snapshot.data.data as Map<String, dynamic>;

          List _activities = data["Veri"];
          return ActivityList(
             activities: _activities,
          );
        },
      ),
    );
  }

  Future getActivityList() async {
    try {
      var response = await Dio().post(AppUrl.getmusterWithPaging, data: {
          "skip": 0,
          "take": 50,
          "searchValue": ""
      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
