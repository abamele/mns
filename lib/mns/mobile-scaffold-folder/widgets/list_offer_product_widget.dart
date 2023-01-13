import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../screens/offer-folder/offer_model.dart';

class ListOfferProductWidget extends StatefulWidget {
  OfferModel prod;
  ListOfferProductWidget({Key? key, required this.prod,}) : super(key: key);

  @override
  State<ListOfferProductWidget> createState() => _ListOfferProductWidgetState();
}

class _ListOfferProductWidgetState extends State<ListOfferProductWidget> {

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
            child: Text("Ürünler"),
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.prod.product.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        color: blueColor,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new Text(
                          "",
                          style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              "Model:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${widget.prod.product[index].model ?? ""}",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Birim Fiyat:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                  "\$${(widget.prod.product[index].price)!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                )),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Miktar:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                "${widget.prod.product[index].quantity!.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        color: blueColor,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ara Toplam:",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                "\$${(widget.prod.product[index].totalPrice)!.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("")
                    ],
                  ),
                )
              ],

            );
          }
      ),
    );
  }
}
