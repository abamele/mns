import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/apiHttp.dart';
import 'add_task.dart';

class addTaskWithDropdown2 extends StatefulWidget {
  const addTaskWithDropdown2({Key? key}) : super(key: key);

  @override
  State<addTaskWithDropdown2> createState() => _addTaskWithDropdown2State();
}

class _addTaskWithDropdown2State extends State<addTaskWithDropdown2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6f9),
      body: FutureBuilder(
        future: getAllListRespAndNominationTask(),
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
          List data =
          snapshot.data.data;

          List _task = data;
          return AddTask(
           task: _task,
          );
        },
      ),
    );
  }

  Future getAllListRespAndNominationTask() async {
    try {
      var response = await Dio().post(AppUrl.allTaskNominationList, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
