import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../screens/customer-folder/customer_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';

class CustomerOfferWidget extends StatefulWidget {
  CustomerModel customerList;
  CustomerOfferWidget({
    Key? key,
    required this.customerList,
  }) : super(key: key);

  @override
  State<CustomerOfferWidget> createState() => _CustomerOfferWidgetState();
}

class _CustomerOfferWidgetState extends State<CustomerOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.customerList.offer.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: blueColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      "Teklif",
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Açıklama",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      "${widget.customerList.offer[index].comment ?? ''}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Teklif Durumu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      "${widget.customerList.offer[index].offerState ?? ''}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Teklif Tarihi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      "${widget.customerList.offer[index].offerDate ?? ''}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Geçerlilik Tarihi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(""),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.customerList.offer[index].validityDate ?? ''}",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            );
          }),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }
}
