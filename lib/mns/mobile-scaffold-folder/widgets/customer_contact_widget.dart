import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../screens/customer-folder/customer_model.dart';
import 'bottom-app-bar-widget/bottom_app_bar_traight.dart';

class CustomerContactWidget extends StatefulWidget {
  CustomerModel contactList;
  CustomerContactWidget({
    Key? key,
    required this.contactList,
  }) : super(key: key);

  @override
  State<CustomerContactWidget> createState() => _CustomerContactWidgetState();
}

class _CustomerContactWidgetState extends State<CustomerContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.contactList.contact.length,
          itemBuilder: (context, index) {
            String _emailController = widget.contactList.contact[index].email ?? "";
            String _phoneController =
                widget.contactList.contact[index].tel?? "";
            String _departmanController =
                widget.contactList.contact[index].department ?? "";
            String _birthdayController =
                widget.contactList.contact[index].birthDay ?? "";
            String _adresController =
                widget.contactList.contact[index].address ?? "";
            String _contactController =
                widget.contactList.contact[index].contactName ?? "";
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 8.0,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        color: blueColor,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new Text(
                          "${_contactController}",
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "E-mail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: TextFormField(
                                initialValue: _emailController,
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Telefon",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: TextFormField(
                                initialValue: _phoneController,
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Departman",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: TextFormField(
                                initialValue: _departmanController,
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Doğum Tarihi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: TextFormField(
                                initialValue: _birthdayController,
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Adres",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: TextFormField(
                                minLines: 4,
                                maxLines: null,
                                initialValue: _adresController,
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("")
                    ],
                  ),
                )
              ],
            );
          }),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }
}
