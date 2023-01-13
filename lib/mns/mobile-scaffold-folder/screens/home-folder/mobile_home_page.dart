import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'offerAndProductInfoWithDropdownDash.dart';


class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final PageStorageBucket bucket=PageStorageBucket();

  int currentIndex=0;
  Widget currentScreen = offerAndProductInfoWithDropdownDash();

  final List<Widget> screens=[
    offerAndProductInfoWithDropdownDash(),
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




