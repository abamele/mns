import 'package:flutter/material.dart';
import '../../screens/home-folder/offerAndProductInfoWithDropdownDash.dart';
import 'bnb_custom_painter.dart';

import '../../screens/customer-folder/customer_list.dart';
import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/menu-folder/menu_list.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/profile-folder/profile_page.dart';

import 'bottom_appbar_clipper.dart';


class BottomAppBarWidget extends StatelessWidget {
  BottomAppBarWidget({Key? key}) : super(key: key);

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
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 70),
          painter: CustomPainterClip(),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  child: selectItemWidget(1, Icons.home_outlined, "Anasayfa")),
              Padding(
                padding: const EdgeInsets.only(right: 55.0),
                child: selectItemWidget(2, Icons.menu, "Menu"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: selectItemWidget(
                    3, Icons.group, "Müşteriler"),
              ),
              selectItemWidget(4, Icons.portrait_rounded, "Profil")
            ],
          ),
        )
      ],
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
