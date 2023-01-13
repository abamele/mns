import 'package:flutter/material.dart';
import 'package:mns/mns/constants/colors.dart';
import 'package:dio/dio.dart';
import '../../../../constants/apiHttp.dart';
import '../../../widgets/bottom-app-bar-widget/bottom_appBar.dart';
import '../../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';
import '../../../widgets/expandable-fab-button-widget/action_button.dart';
import '../../../widgets/expandable-fab-button-widget/expandable_fab_button_widget.dart';
import 'order_confirm_model.dart';

class OrderConfirm extends StatefulWidget {
  OrderConfirm({Key? key}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");

  ScrollController scrollController = ScrollController();
  List<OrderConfirmModel> order = [];
  bool loading = true;
  int skipe = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(skipe);
    handleNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, isScroll) {
          return [
            SliverAppBar(
              backgroundColor: blueColor,
              elevation: 0.0,
              toolbarHeight: 80,
              title: Container(
                margin: EdgeInsets.only(right: 35),
                child: Center(
                  child: Text("Onaylanan Siparişler"),
                ),
              ),
            )
          ];
        },
        body: ValueListenableBuilder(
            valueListenable: take,
            builder: (BuildContext context, int takeValue, Widget? child) {
              return ValueListenableBuilder(
                  valueListenable: _searchTextNotify,
                  builder: (BuildContext context, String searchValue,
                      Widget? child) {
                    return ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(),
                          child: Center(
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  hintText: 'Ara...',
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                _searchTextNotify.value = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: order.length,
                            itemBuilder: (context, index) {
                              if (index == order.length) {
                                return loading
                                    ? Container(
                                        height: 200,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 4,
                                          ),
                                        ),
                                      )
                                    : Container();
                              }
                              final _offerNo = order[index].offerNo.toString().toLowerCase() ?? "";
                              final _customName =
                                  order[index].customerName.toString().toLowerCase() ?? "";
                              final _cargoName = order[index].cargoName.toString().toLowerCase() ?? "";
                              final _paymentMethod = order[index].payment.toString().toLowerCase() ?? "";
                              final _confirmDate =
                                  order[index].confirmDate.toString().toLowerCase() ?? "";

                              if (_offerNo
                                      .contains(searchValue.toLowerCase()) ||
                                  _customName
                                      .contains(searchValue.toLowerCase()) ||
                                  _cargoName
                                      .contains(searchValue.toLowerCase()) ||
                                  _paymentMethod
                                      .contains(searchValue.toLowerCase())) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Card(
                                    elevation: 8.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50,
                                          color: blueColor,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: new Text(
                                            "",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                            15.0,
                                          ),
                                          child: Text(
                                            "Teklif No:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "${_offerNo}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Müşteri Adı:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "${_customName}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Kargo Adı :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "${_cargoName}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Ödeme Yöntemi:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "${_paymentMethod}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Onay Tarihi:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "${_confirmDate}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("")
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            })
                      ],
                    );
                  });
            }),
      ),
      bottomNavigationBar: BottomAppBarStraightWidget(),
    );
  }

  Future<void> _reload(var value) async {
    setState(() {});
  }

  void fetchData(
    int skipe,
  ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/teklif/onaylanan-siparisler?_skipe=$skipe",
        data: {
          "sort": [
            {"selector": "string", "desc": false}
          ],
          "group": {},
          "requireTotalCount": true,
          "searchOperation": "string",
          "filterValue": {},
          "searchValue": {},
          "skip": skipe,
          "take": 10,
          "userDatas": [
            {"SelectedField": "string", "SelectedValue": "string"}
          ],
          "filter": ["string"],
          "filterSearchField": "string",
          "filterSearchValue": "string",
          "multiFilterSearch": {},
          "sortingFieldValue": "string",
          "sortingFieldDesc": true,
          "multipleFilters": [
            ["string"]
          ]
        });

    Veri modelClass = Veri.fromJson(response.data);
    order = order + modelClass.order;
    //int localOffset = offset + 15;
    setState(() {
      order;
      loading = false;
      // offset = localOffset;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(skipe += 10);
      }
    });
  }
}
