import 'package:flutter/material.dart';


import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/menu-folder/menu_list.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/profile-folder/profile_page.dart';

import '../../screens/customer-folder/customer_list.dart';
import '../../screens/home-folder/offerAndProductInfoWithDropdownDash.dart';

class BottomAppBarStraightWidget extends StatelessWidget {
  BottomAppBarStraightWidget({Key? key}) : super(key: key);

  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);
  List text = [
    "Anasayfa",
    "Ürünler",
    "Anasayfa",
    "Müşteriler",
    "Profili",
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          selectItemWidget(1, Icons.home_outlined, "Anasayfa"),
          selectItemWidget(2, Icons.menu, "Menu"),
          selectItemWidget(
              3, Icons.group, "Müşteriler"),
          selectItemWidget(4, Icons.portrait_rounded, "Profil")
        ],
      ),
    );
  }

  Widget selectItemWidget(
      int index,
      IconData icon,
      String txt,
      ) {
    return ValueListenableBuilder(
      valueListenable: selectButton,
      builder: (BuildContext context, int value, Widget? child) {
        return Container(
          child: Row(
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: value == index ? blueColor : Colors.grey,
                        size: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        txt,
                        style: TextStyle(
                            color: value == index ? blueColor : Colors.grey,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (index == 1) {
                    selectButton.value = index;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => offerAndProductInfoWithDropdownDash()));
                  } else if (index == 2) {
                    selectButton.value = index;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuList()));
                  } else if (index == 3) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerList()));
                  } else if (index == 4) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
