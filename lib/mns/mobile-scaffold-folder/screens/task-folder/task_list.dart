import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/task-folder/task_model.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


import 'package:mns/mns/constants/colors.dart';
import 'package:mns/mns/mobile-scaffold-folder/screens/task-folder/task_details.dart';
import '../../../constants/apiHttp.dart';
import 'package:intl/intl.dart';
import '../../widgets/bottom-app-bar-widget/bottom_app_bar_traight.dart';


class TaskList extends StatefulWidget {
  List task;
  TaskList({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  TextEditingController taskDef = TextEditingController();
  TextEditingController taskNomi = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskState = TextEditingController();
  TextEditingController taskComment = TextEditingController();
  TextEditingController taskStartedDate = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  TextEditingController taskEndDate = TextEditingController();
  TextEditingController taskResp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];
  String? selectedValue;
  String? selectedValue2;
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;
  int _value1 = 0;
  int _value2 = 0;

  ScrollController scrollController = ScrollController();
  List<TaskModel> task = [];
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
                  child: Text("Görevler"),
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
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(290, 45),
                                  primary: blueColor),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          content: Form(
                                            key: formKey,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    color: blueColor,
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child: new Text(
                                                      "Görev Ekle",
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 40),
                                                          child: Text(
                                                            "Görev Tanımı",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: TextFormField(
                                                            controller: taskDef,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Yazınız... ",
                                                              helperStyle:
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Görev Atayan",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      (BorderRadius
                                                                          .circular(
                                                                              12))),
                                                          child: SearchableDropdown.single(
                                                              isExpanded: true,
                                                              value: selectedValue,
                                                              items: taskNominationDropdownList(
                                                                  " Seçiniz..."),
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedValue = value;
                                                                });
                                                              },
                                                              hint: const Text(
                                                                  "Seçiniz...")),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Görev Sorumlusu",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      (BorderRadius
                                                                          .circular(
                                                                              12))),
                                                          child: SearchableDropdown.single(
                                                              isExpanded: true,
                                                              value: selectedValue2,
                                                              items: taskRespDropdownList(
                                                                  "Seçiniz..."),
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedValue2 = value;
                                                                });
                                                              },
                                                              hint: const Text(
                                                                  "Seçiniz...")),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Görev Tipi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                taskType,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Yazınız... ",
                                                              helperStyle:
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Başlangıç Tarihi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 10,
                                                                  top: 10),
                                                          child: TextFormField(
                                                            readOnly: false,
                                                            controller:
                                                                taskStartedDate,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Yazınız...',
                                                              suffixIcon: Icon(
                                                                  Icons
                                                                      .date_range),
                                                              helperStyle:
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                           /* onTap: () async {
                                                              DateTime?
                                                                  pickedDate =
                                                                  await showDatePicker(
                                                                      locale: Locale(
                                                                          "tr",
                                                                          "TR"),
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000), //DateTime.now() - not to allow to choose before today.
                                                                      lastDate:
                                                                          DateTime(
                                                                              2101));

                                                              if (pickedDate !=
                                                                  null) {
                                                                print(
                                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                String
                                                                    formattedDate =
                                                                    DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            pickedDate);
                                                                print(
                                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                //you can implement different kind of Date Format here according to your requirement

                                                                setState(() {
                                                                  taskStartedDate
                                                                          .text =
                                                                      formattedDate; //set output date to TextField value.
                                                                });
                                                              } else {
                                                                print(
                                                                    "seçilmedi");
                                                              }
                                                            },*/

                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Bitiş Tarihi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller:
                                                            taskEndDate,
                                                            decoration:
                                                            InputDecoration(
                                                              hintText:
                                                              'Seçiniz...',
                                                              suffixIcon: Icon(
                                                                  Icons
                                                                      .date_range),
                                                              helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  17),
                                                            ),
                                                            onTap: () async {
                                                              DateTime?
                                                              pickedDate =
                                                              await showDatePicker(
                                                                  locale: Locale(
                                                                      "tr",
                                                                      "TR"),
                                                                  context:
                                                                  context,
                                                                  initialDate:
                                                                  DateTime
                                                                      .now(),
                                                                  firstDate:
                                                                  DateTime(
                                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                                  lastDate:
                                                                  DateTime(
                                                                      2101));

                                                              if (pickedDate !=
                                                                  null) {
                                                                print(
                                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                String
                                                                formattedDate =
                                                                DateFormat(
                                                                    'dd-MM-yyyy')
                                                                    .format(
                                                                    pickedDate);
                                                                print(
                                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                //you can implement different kind of Date Format here according to your requirement

                                                                setState(() {
                                                                  taskEndDate
                                                                      .text =
                                                                      formattedDate; //set output date to TextField value.
                                                                });
                                                              } else {
                                                                print(
                                                                    "seçilmedi");
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Görev Durumu",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      (BorderRadius
                                                                          .circular(
                                                                              12))),
                                                          child: DropdownButton(
                                                              isExpanded: true,
                                                              value: _value2,
                                                              items: offerStateDropdownList(
                                                                  "Seçiniz"),
                                                              onChanged:
                                                                  (int? value) {
                                                                _value2 =
                                                                    value!;
                                                                if (_value2 ==
                                                                    0) {
                                                                  _value2 = 0;
                                                                }
                                                                setState(() {});
                                                              },
                                                              hint: const Text(
                                                                  "Seçiniz...")),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 20),
                                                          child: Text(
                                                            "Açıklama",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                taskComment,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            minLines: 4,
                                                            maxLines: null,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Yazınız...",
                                                              helperStyle:
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 35, right: 35),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    Size(290,
                                                                        45),
                                                                primary:
                                                                    blueColor),
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            formKey
                                                                .currentState!
                                                                .save();
                                                            addTask(
                                                                Hive.box(
                                                                        "userbox")
                                                                    .get(
                                                                        "UyeID"),
                                                                taskDef.text,
                                                                selectedValue,
                                                                taskType.text,
                                                                selectedValue2,
                                                                taskStartedDate
                                                                    .text,
                                                                taskEndDate
                                                                    .text,
                                                                taskState.text,
                                                                taskComment
                                                                    .text);
                                                          }
                                                        },
                                                        child: Text(
                                                          "Kaydet",
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text("")
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Text(
                                "Görev Ekle",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _searchTextNotify,
                            builder: (BuildContext context, String searchValue,
                                Widget? child) {
                              return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: task.length +1,
                                            itemBuilder: (context, index) {
                                              if (index == task.length) {
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
                                              final _taskDef = task[index].taskDef.toString().toLowerCase() ?? "";
                                              final _taskResp = task[index].taskResp.toString().toLowerCase() ?? "";
                                              final _startDate = task[index].startDate.toString().toLowerCase() ?? "";
                                              final _endDate = task[index].endDate.toString().toLowerCase() ?? "";

                                              if (_taskResp
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _startDate
                                                      .contains(searchValue.toLowerCase()) ||
                                                  _endDate
                                                      .contains(searchValue.toLowerCase())) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 20),
                                                  child: Card(
                                                    elevation: 8.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          color: blueColor,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: new Text(
                                                            "",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Görev Tanımı",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_taskDef}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Görev Sorumlusu",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_taskResp}"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Başlangıç Tarihi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_startDate}"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Bitiş Tarihi ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                          ),
                                                          child: Text(
                                                              "${_endDate}"),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 35,
                                                                  right: 35,
                                                                  top: 20),
                                                          child: Center(
                                                            child: ElevatedButton(
                                                              child: Text(
                                                                "Ürün Detayları",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      minimumSize:
                                                                          Size(
                                                                              290,
                                                                              45),
                                                                      primary: Colors
                                                                          .white),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TaskDetails(
                                                                              taskList:
                                                                                  task[index],
                                                                              task:
                                                                                  widget.task,
                                                                            ))).then(
                                                                    (value) =>
                                                                        _reload(
                                                                            value));
                                                              },
                                                            ),
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
                                            });

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

  taskDefDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskDef = widget.task;
    for (var i = 0; i < taskDef.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskDef[i - 1]["GorevTanimi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  taskNominationDropdownList(String title) {
    String wordPair = "";
    List<String> items = [];
    List<DropdownMenuItem<String>> dropdownItemList = [];

    List taskNomination = widget.task;
    for (var i = 0; i < taskNomination.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: "",
          ),
        );
      } else {
        items.add(taskNomination[i-1]["AdiSoyadi"].toString());
        /*dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskNomination[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );*/
      }
    }
    items
        .forEach((word) {
      dropdownItemList.add(DropdownMenuItem(
        child: Text(word),
        value: word,
      ));
     /* if (wordPair.isEmpty) {
        wordPair = word + " ";

      } else {
        wordPair;
        if (items.indexWhere((item) {
          return (item == wordPair);
        }) == -1) {
          dropdownItemList.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }*/
    });
    return dropdownItemList;
  }

  taskRespDropdownList(String title) {
    String wordPair = "";
    List<String> items = [];
    List<DropdownMenuItem<String>> dropdownItemList = [];
    List taskResp = widget.task;
    for (var i = 0; i < taskResp.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: "",
          ),
        );
      } else {
        items.add(taskResp[i-1]["AdiSoyadi"].toString());
       /* dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskResp[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );*/
        print("..................item listttttttttt.................${items.length}");
      }
    }
    for(var word in items) {
      print("..................word plus.................${word}");
      dropdownItemList.add(DropdownMenuItem(
        child: Text(word),
        value: word,
      ));
 /*     if (wordPair.isEmpty) {
        wordPair = word + "";

      } else {
        wordPair;
        if (items.indexWhere((item) {

          return (item == wordPair);
        }) == -1) {
          //print("..................addd.................${wordPair}");
          dropdownItemList.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }*/
    };
    return dropdownItemList;
  }

  Future<void> _openDatePicker1(BuildContext context) async {
    dateTime1 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blueColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  Future<void> _openDatePicker2(BuildContext context) async {
    dateTime2 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blueColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  offerStateDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    //List state = widget.offerList;
    for (var i = 0; i < txtState.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              txtState[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future addTask(int? uyeId, gorevTanimi, gorevAtayan, gorevTipi, gorevSorumlu,
      baslangicTarihi, bitisTarihi, gorevDurumu, gorevAciklamasi) async {
    showBusinessLoginDialog();
    try {
      var response = await Dio().post(AppUrl.addTask, data: {
        "GorevID": 0,
        "UyeID": uyeId,
        "GorevTanimi": gorevTanimi,
        "GoreviAtayanID": 0,
        "GoreviAtayanAdiSoyadi": gorevAtayan,
        "GorevSorumlusuID": 0,
        "GorevTipi": gorevTipi,
        "GorevinDurumu": 0,
        "GorevinAciklamasi": gorevAciklamasi,
        "GorevBaslangic": baslangicTarihi,
        "GorevBitisTarihi": bitisTarihi,
        "OlusturulmaTarihi": "2022-04-20T10:51:35.496Z",
        "GorevSorumlusu": gorevSorumlu,
        "GorevBaslangicFormatli": "",
        "GorevBitisFormatli": "",
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Görev kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/task_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print(response);
    } on DioError catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${e.response!.data["message"]}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kapat"))
              ],
            );
          });
    }
  }

  showBusinessLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: _loginLoading,
              builder: (BuildContext context, Map value, Widget? child) {
                if (value["state"] == 0) {
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else if (value["state"] == 1) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/homepage", (Route<dynamic> route) => false);
                  });
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else {
                  return AlertDialog(
                    title: Text(value["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Tamam"))
                    ],
                  );
                }
              });
        }).then((value) => _loginLoading.value = {"state": 0, "message": ""});
  }

  void fetchData(
      int skipe,
      ) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().post(
        "https://crm.mnsbilisim.com/api/gorev/gorevler?_skipe=$skipe",
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
    task = task + modelClass.task;
    //int localOffset = offset + 15;
    setState(() {
      task;
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
