import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'mns/mobile-scaffold-folder/screens/activity-folder/activityLlistWithDropdown.dart';
import 'mns/mobile-scaffold-folder/screens/cargo-folder/cargo_list.dart';
import 'mns/mobile-scaffold-folder/screens/currency-folder/currency_list.dart';
import 'mns/mobile-scaffold-folder/screens/customer-folder/customer_list.dart';
import 'mns/mobile-scaffold-folder/screens/home-folder/mobile_home_page.dart';
import 'mns/mobile-scaffold-folder/screens/integration-folder/integration_management.dart';
import 'mns/mobile-scaffold-folder/screens/login-folder/login_page.dart';
import 'mns/mobile-scaffold-folder/screens/menu-folder/menu_list.dart';
import 'mns/mobile-scaffold-folder/screens/offer-folder/add_offer.dart';
import 'mns/mobile-scaffold-folder/screens/offer-folder/offerAndProductInfoWithDropdown.dart';
import 'mns/mobile-scaffold-folder/screens/order-folder/cause-refuse/cause_refuse_list.dart';
import 'mns/mobile-scaffold-folder/screens/order-folder/order-confirm/order_confirm.dart';
import 'mns/mobile-scaffold-folder/screens/order-folder/order-refuse/order_refuse.dart';
import 'mns/mobile-scaffold-folder/screens/product-folder/add_product.dart';
import 'mns/mobile-scaffold-folder/screens/product-folder/product_list.dart';
import 'mns/mobile-scaffold-folder/screens/profile-folder/profile_page.dart';
import 'mns/mobile-scaffold-folder/screens/scope-folder/addScopeWithDropdown.dart';
import 'mns/mobile-scaffold-folder/screens/scope-folder/addScopeWithDropdown2.dart';
import 'mns/mobile-scaffold-folder/screens/task-folder/addTaskWithDropdown.dart';
import 'mns/mobile-scaffold-folder/screens/task-folder/addtaskWithDropdown2.dart';
import 'mns/mobile-scaffold-folder/screens/user/user_list.dart';
import 'mns/responsive-layout-folder/responsive_layout.dart';
import 'mns/tablet-scaffold-folder/screens/tablet-home-page-folder/tablet_home_page.dart';

void main() async {
  await Hive.initFlutter("localdatabase");
  await Hive.openBox("userbox");
  // await Hive.openBox("rememberbox");

  // Hive.box("caybox").clear();
  // Hive.box("rememberbox").clear();
  // Hive.box("userbox").clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('tr')],
      routes: {
        "/login": (context) => LoginPage(),
        "/home_page": (context) => ResponsiveLayout(
              mobilScaffold: MobileHomePage(),
              tabletScaffold: TabletHomePage(),
            ),

        //List data
        "/profile": (context) => ProfileScreen(),
        "/menu": (context) => MenuList(),
        "/customer_list": (context) => CustomerList(),
        "/activity_list": (context) => activityLlistWithDropdown(),
        "/product_list": (context) => ProductList(),
        "/user_list": (context) => UserList(),
        "/scope_list": (context) => AddScopeWithDropdown(),
        "/task_list": (context) => addTaskWithDropdown(),
        "/refuse_order": (context) => OrderRefuse(),
        "/offer_list": (context) => offerAndProductInfoWithDropdown(),
        "/currency_list": (context) => CurrencyList(),
        "/cause_refuse_list": (context) => CauseRefuseList(),
        "/cargo_list": (context) => CargoList(),
        "/order_confirm": (context) => OrderConfirm(),
        "/integration": (context) => IntegrationManagement(),

        "/add_offer": (context) => AddOffer(
              prod: [],
              offer: [],
            ),
        "/add_product": (context) => AddProduct(),
        "/add_scope": (context) => AddScopeWithDropdown2(),
        "/add_task": (context) => addTaskWithDropdown2(),

        /*
        //Add Data
        "/add_task":(context)=>addTaskWithDropdown(),
        "/add_offer":(context)=>offerAndProductInfoWithDropdown(),
        "/add_customer":(context)=>addCustomerWithDropdown(),
        "/add_user":(context)=>AddUser(),
        "/add_product":(context)=>AddProduct(),
        "/add_scope":(context)=>AddScopeWithDropdown(),
        "/add_currency":(context)=>AddCurrency(),
        "/add_cause_refuse":(context)=>AddCauseRefuse(),
        "/add_cargo":(context)=>AddCargo(),*/

        /*
        "/settings":(context)=>SettingsScreen(),
        "/currency_manager":(context)=>CurrencyManagerScreen(),
        "/order_list":(context)=>OrderList(),
        "/confirm_orders":(context)=>ConfirmOrderListScreen(),
        "/refuse_orders":(context)=>RefuseOrderScreen(),

        //add data
        "/add_product":(context)=>AddProduct(),
        "/add_cause_refuse":(context)=>AddCauseRefuse(),
        //"/offer_info":(context)=>offerAndProductInfoWithDropdown(),*/

        //"/test":(context)=>HomePageTest(),
      },
      initialRoute: "/login",
    );
  }
}
