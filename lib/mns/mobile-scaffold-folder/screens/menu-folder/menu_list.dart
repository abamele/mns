import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/constants/context_extension.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/product-folder/product_list.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/profile-folder/profile_page.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/scope-folder/addScopeWithDropdown.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/task-folder/addTaskWithDropdown.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/user/user_list.dart';
import '../activity-folder/activityLlistWithDropdown.dart';
import '../cargo-folder/cargo_list.dart';
import '../currency-folder/currency_list.dart';
import '../customer-folder/customer_list.dart';
import '../integration-folder/integration_management.dart';
import '../offer-folder/offerAndProductInfoWithDropdown.dart';
import '../order-folder/cause-refuse/cause_refuse_list.dart';
import '../order-folder/order-confirm/order_confirm.dart';
import '../order-folder/order-refuse/order_refuse.dart';



class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);

  List itemMenu = [
    "Kullanıcılar",
    "Müşteriler",
    "Ürünler",
    "Aktiviteler",
    "Fırsatlar",
    "Görevler",
    "Reddedilen \nSiparişler",
    "Onaylanan \nSiparişler",
    "Teklifler",
    "Para Birimi",
    "Entegrasyon \nYönetimi",
    "Ret Nedenleri \nYönetimi",
    "Kargo Yönetimi",
    "Profilim",
    "Çıkış"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.only(right: 35),
            child: Center(
              child: Text(
                "Menu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(1,FontAwesomeIcons.user ,itemMenu[0])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(2,FontAwesomeIcons.userGroup ,itemMenu[1])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(3,FontAwesomeIcons.cube ,itemMenu[2])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(4,FontAwesomeIcons.bullseye ,itemMenu[3])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(5,Icons.star_border_outlined,itemMenu[4])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(6,FontAwesomeIcons.tasks ,itemMenu[5])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(7,Icons.clear ,itemMenu[6])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(8,Icons.check_box_outlined ,itemMenu[7])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(9,FontAwesomeIcons.peopleCarryBox ,itemMenu[8])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(10,FontAwesomeIcons.coins ,itemMenu[9])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(11,Icons.add ,itemMenu[10])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(12,FontAwesomeIcons.xmark ,itemMenu[11])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(13,FontAwesomeIcons.truck ,itemMenu[12])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(14,FontAwesomeIcons.user ,itemMenu[13])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(15,FontAwesomeIcons.rightFromBracket ,itemMenu[14])
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectMenuWidget(int index, IconData icon, String text) {
    return ValueListenableBuilder(
      valueListenable: selectButton,
      builder: (BuildContext context, int value, Widget? child) {
        return MaterialButton(
          child: Card(
            elevation: 5.0,
            color: value==index?blueColor:Colors.white,
            margin: EdgeInsets.only(top: 30),
            child: Container(
              width: context.dynamicWidth(0.40),
              height: context.dynamicHeight(0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      size: 25,
                      color:value==index?Colors.white: blueColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: value==index?Colors.white: Color(0xff4F4F4F))),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            if(index==1){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserList()));
            }else if(index==2){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerList()));
            }else if(index==3){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductList()));
            }else if(index==4){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => activityLlistWithDropdown()));
            }else if(index==5){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddScopeWithDropdown()));
            }else if(index==6){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addTaskWithDropdown()));
            }else if(index==7){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderRefuse()));
            }else if(index==8){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderConfirm()));
            }else if(index==9){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => offerAndProductInfoWithDropdown()));
            }else if(index==10){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrencyList()));
            }else if(index==11){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IntegrationManagement()));
            }else if(index==12){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CauseRefuseList()));
            }else if(index==13){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CargoList()));
            }else if(index==14){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen()));
            }else if(index==15){
              selectButton.value=index;
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            }

          },
        );
      },
    );
  }
}
