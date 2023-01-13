import 'package:flutter/material.dart';
import 'package:mns/mns/tablet-scaffold-folder/screens/tablet-home-page-folder/tablet_offer_and_product_in_with_dropdown_dashboard.dart';

class TabletHomePage extends StatefulWidget {
  const TabletHomePage({Key? key}) : super(key: key);

  @override
  State<TabletHomePage> createState() => _TabletHomePageState();
}

class _TabletHomePageState extends State<TabletHomePage> {
  final PageStorageBucket bucket=PageStorageBucket();

  int currentIndex=0;
  Widget currentScreen = TabletOfferAndProductInfoWithDropdownDash();

  final List<Widget> screens=[
    TabletOfferAndProductInfoWithDropdownDash(),
    /*CustomerListScreen(),
    ProductListScreen(),
    ProfileScreen()*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),

    );
  }
}