import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../screens/customer-folder/customer_model.dart';

class ListCustomerOfferWidget extends StatefulWidget {
  CustomerModel offerList;
  ListCustomerOfferWidget({
    Key? key,
    required this.offerList,
  }) : super(key: key);

  @override
  State<ListCustomerOfferWidget> createState() => _ListCustomerOfferWidgetState();
}

class _ListCustomerOfferWidgetState extends State<ListCustomerOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Teklifler"),
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.offerList.offer.length,
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
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 30,),
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
                      "${widget.offerList.offer[index].comment ?? ''}",
                      style: TextStyle( fontSize: 16),
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
                      "${widget.offerList.offer[index].offerState ?? ''}",
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
                      "${widget.offerList.offer[index].offerDate ?? ''}",
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
                    "${widget.offerList.offer[index].validityDate ?? ''}",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            );
          }),
    );
  }
}
