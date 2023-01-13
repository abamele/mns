import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../widgets/customer_contact_widget.dart';
import '../../widgets/customer_details_widget.dart';
import '../../widgets/customer_offer_widget.dart';
import 'customer_model.dart';


class CustomerDetails extends StatefulWidget {
  CustomerModel customList;
  CustomerDetails({Key? key, required this.customList}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pushNamed(context, "/customer_list");},),
          backgroundColor: blueColor,
          elevation: 0.0,
          toolbarHeight: 80, // Set this height
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
                          "Müşteri Detayları",
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
              Tab(text: 'Detay',),
              Tab(text: 'Yetkiler',),
              Tab(text: 'Teklifler',),
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
            CustomerDetailsWidget(customList: widget.customList),
            CustomerContactWidget(contactList: widget.customList),
            CustomerOfferWidget(customerList:widget.customList)
          ],
        ),
      ),
    );
  }

  userTypeTitle(int userType) {
    if (userType == 1) {
      return const Text("Müşteri Detayları");
    } else if (userType == 2) {
      return const Text("Müşteri Yetkilileri");
    } else if (userType == 3) {
      return const Text("Müşteri Detayları");
    }
  }
}


