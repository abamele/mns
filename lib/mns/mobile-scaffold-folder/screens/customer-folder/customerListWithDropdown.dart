/*
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mns/mns/screens/customer-folder/customer_model.dart';
import '../../constants/apiHttp.dart';
import '../../widgets/customer_details_widget.dart';

class CustomerListWithDropdown extends StatefulWidget {
  CustomerModel customList;
  CustomerListWithDropdown({Key? key, required this.customList}) : super(key: key);

  @override
  State<CustomerListWithDropdown> createState() => _CustomerListWithDropdownState();
}

class _CustomerListWithDropdownState extends State<CustomerListWithDropdown> {

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6f9),
      body: FutureBuilder(
        future: getCustomerList(),
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
          List data = snapshot.data.data;

          List _customers = data;
          return CustomerDetailsWidget(customers: _customers, customList: widget.customList.,
          );
        },
      ),
    );
  }

  Future getCustomerList() async {
    try {
      var response = await Dio().post(AppUrl.allCategeryList, data: {});
      var modelClass=CustomerModel.allCategoryList(response.data);
      widget.customList = widget.customList + modelClass;

      setState(() {
        widget.customList;
        // offset = localOffset;
      });
    } catch (e) {
      print(".......................$e");
    }
  }
}*/
