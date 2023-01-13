
import 'package:flutter/material.dart';

import '../mobile-scaffold-folder/screens/home-folder/mobile_home_page.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobilScaffold;
  final Widget tabletScaffold;
   ResponsiveLayout({Key? key, required this.mobilScaffold, required this.tabletScaffold}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth<600){
            return widget.mobilScaffold;
          }else{
            return widget.tabletScaffold;
          }
        }

    );
  }
}
