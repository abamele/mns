import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  double dynamicWidth(double val)=> MediaQuery.of(this).size.width*val;
  double dynamicHeight(double val)=> MediaQuery.of(this).size.height*val;

  ThemeData get theme => Theme.of(this);
}

extension NumberExtension on BuildContext{
  double get lowVale => dynamicHeight(0.01);
  double get mediumVale => dynamicHeight(0.03);

}

extension PaddingExtension on BuildContext{
 EdgeInsets get paddingAllLow=> EdgeInsets.all(dynamicHeight(0.01));

}

extension MarginExtension on BuildContext{
  EdgeInsets marginAllLow(double val)=> EdgeInsets.all(dynamicHeight(val));

}