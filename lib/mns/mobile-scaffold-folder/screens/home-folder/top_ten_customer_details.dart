import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../widgets/top_ten_contact_details_widget.dart';
import '../../widgets/top_ten_product_details_widget.dart';

class TopTenCustomerDetails extends StatefulWidget {
  Map? offerList;
  TopTenCustomerDetails({Key? key, this.offerList}) : super(key: key);

  @override
  State<TopTenCustomerDetails> createState() => _TopTenCustomerDetailsState();
}

class _TopTenCustomerDetailsState extends State<TopTenCustomerDetails> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          toolbarHeight: 85, // Set this height
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 30),
            color: blueColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: widget.offerList!["TeklifCount"]==null?Container():Center(
                        child: Text(
                          "${widget.offerList!["TeklifCount"]} Teklif Detayları",
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
              Tab(text: 'Ürün Bilgilerim',),
              Tab(text: 'Yetkililer',),
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
            TopTenProductDetailsWidget(offerList: widget.offerList!["Sepet"]),
            TopTenContactDetailsWidget(offerList: widget.offerList!["MusteriKontakListe"],)
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


