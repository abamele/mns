import 'package:flutter/material.dart';

import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/menu-folder/menu_list.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/profile-folder/profile_page.dart';
import 'package:mns/mns/tablet-scaffold-folder/widgets/bottom_app_bar_widget/tablet_custom_painter_cliper.dart';

import '../../../mobile-scaffold-folder/screens/customer-folder/customer_list.dart';
import '../../../mobile-scaffold-folder/screens/home-folder/offerAndProductInfoWithDropdownDash.dart';
import '../../screens/tablet-home-page-folder/tablet_offer_and_product_in_with_dropdown_dashboard.dart';




class TabletBottomAppBarWidget extends StatelessWidget {
  TabletBottomAppBarWidget({Key? key}) : super(key: key);

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
          size: Size(MediaQuery.of(context).size.width, 100),
          painter: TabletCustomPainterClip(),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: selectItemWidget(1, Icons.home_outlined, "Anasayfa")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: selectItemWidget(2, Icons.menu, "Menu"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: selectItemWidget(
                    3, Icons.group, "Müşteriler"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: selectItemWidget(4, Icons.portrait_rounded, "Profil"),
              )
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
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        txt,
                        style: TextStyle(
                            color: value == index ? blueColor : Colors.grey,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (index == 1) {
                    selectButton.value = index;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabletOfferAndProductInfoWithDropdownDash()));
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
