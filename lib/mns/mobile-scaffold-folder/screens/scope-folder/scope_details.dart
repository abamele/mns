import 'package:flutter/material.dart';

import 'package:mns/mns/mobile-scaffold-folder/screens/scope-folder/scopeListWithDropdown.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/scope-folder/scope_model.dart';

import '../../../constants/colors.dart';
import '../../widgets/add_new_scope_widget.dart';

class ScopeDetails extends StatefulWidget {
  ScopeModel scopeList;
  ScopeDetails({Key? key, required this.scopeList}) : super(key: key);

  @override
  State<ScopeDetails> createState() => _ScopeDetailsState();
}

class _ScopeDetailsState extends State<ScopeDetails> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor:blueColor,
          elevation: 0.0,
          toolbarHeight: 70, // Set this height
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 30),
            color: blueColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                          "Fırsat Detayları",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ))),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Fırsat Detayları',),
              Tab(text: 'Yeni Müşteri Ekle',),
            ],
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 20),
            physics: NeverScrollableScrollPhysics(),
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ScopeListWithDropdown(scopeList: widget.scopeList,),
            AddNewScopeWidget(scopes: [],)
          ],
        ),
      ),
    );
  }

}


