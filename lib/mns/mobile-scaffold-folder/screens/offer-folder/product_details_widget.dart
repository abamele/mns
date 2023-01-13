import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import 'offer_model.dart';

class ProductDetailsWidget extends StatefulWidget {
  OfferModel product;
  ProductDetailsWidget({Key? key, required this.product,}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.product.product.length,
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
                                    "${widget.product.product[index].model ?? ""}",
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
                                  "\$${(widget.product.product[index].price)!.toStringAsFixed(2)}",
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
                                "${widget.product.product[index].quantity!.toStringAsFixed(0)}",
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
                                "\$${(widget.product.product[index].totalPrice)!.toStringAsFixed(2)}",
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
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }
}
