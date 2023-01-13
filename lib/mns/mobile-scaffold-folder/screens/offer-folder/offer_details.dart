import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/offer_contact_details_widget.dart';
import '../../widgets/offer_details_widget.dart';
import 'offer_model.dart';
import 'product_details_widget.dart';

class OfferDetails extends StatefulWidget {
  OfferModel offerList;
  OfferDetails({Key? key, required this.offerList}) : super(key: key);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> with TickerProviderStateMixin {
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
          elevation: 0.0,
          backgroundColor: blueColor,
          toolbarHeight: 70, // Set this height
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
                          "Teklif Detayları",
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
              Tab(text: ' Bilgiler',),
              Tab(text: 'Ürünler',),
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
            OfferDetailsWidget(offerList: widget.offerList),
            ProductDetailsWidget(product: widget.offerList),
            OfferContactDetailsWidget(contact: widget.offerList)

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


