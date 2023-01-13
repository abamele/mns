import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/scope-folder/scope_model.dart';
import '../../../constants/apiHttp.dart';
import '../../widgets/scope_details_widget.dart';

class ScopeListWithDropdown extends StatefulWidget {
  ScopeModel scopeList;
  ScopeListWithDropdown({Key? key, required this.scopeList}) : super(key: key);

  @override
  State<ScopeListWithDropdown> createState() => _ScopeListWithDropdownState();
}

class _ScopeListWithDropdownState extends State<ScopeListWithDropdown> {
  final ValueNotifier<int> take = ValueNotifier<int>(10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ValueListenableBuilder(
        valueListenable: take,
        builder: (BuildContext context, int takeValue, Widget? child) {
          return FutureBuilder(
              future:getScopeCustomerList() ,
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
                return ScopeDetailsWidget(scopes: _scopes, scopeList: widget.scopeList,);
              }
          );
        }
      ),
    );
  }

  Future getScopeCustomerList() async {
    try {
      var response = await Dio().post(AppUrl.getScopeCustomer, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
