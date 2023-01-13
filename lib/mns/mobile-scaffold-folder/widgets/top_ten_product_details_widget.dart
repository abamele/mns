import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'bottom-app-bar-widget/bottom_appBar.dart';

class TopTenProductDetailsWidget extends StatefulWidget {
  List offerList;
  TopTenProductDetailsWidget({Key? key, required this.offerList,}) : super(key: key);

  @override
  State<TopTenProductDetailsWidget> createState() => _TopTenProductDetailsWidgetState();
}

class _TopTenProductDetailsWidgetState extends State<TopTenProductDetailsWidget> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.offerList.length,
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
                          "${widget.offerList[index]["Model"]}",
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
                                    "${widget.offerList[index]["Model"] ?? ""}",
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
                                  "\$${(widget.offerList[index]["BirimFiyat"]).toStringAsFixed(2)}",
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
                                "${widget.offerList[index]["Miktar"].toStringAsFixed(0)}",
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
                                "\$${(widget.offerList[index]["AraToplam"]).toStringAsFixed(2)}",
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
