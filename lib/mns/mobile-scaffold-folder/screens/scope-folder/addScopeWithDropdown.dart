import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/scope-folder/scope_list.dart';

import '../../../constants/apiHttp.dart';

class AddScopeWithDropdown extends StatefulWidget {
  const AddScopeWithDropdown({Key? key}) : super(key: key);

  @override
  State<AddScopeWithDropdown> createState() => _AddScopeWithDropdownState();
}

class _AddScopeWithDropdownState extends State<AddScopeWithDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6f9),
      body: FutureBuilder(
        future:getScopeList() ,
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

          List _scopes = data;
          return ScopeList(scopes: _scopes);
        }
      ),
    );
  }

  Future getScopeList() async {
    try {
      var response = await Dio().post(AppUrl.getScopeCustomer, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
