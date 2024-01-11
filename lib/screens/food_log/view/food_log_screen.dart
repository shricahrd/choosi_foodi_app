import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/food_log_controller.dart';
import 'food_log_history_screen.dart';

class FoodLogScreen extends StatefulWidget {
  @override
  _FoodLogScreenState createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends State<FoodLogScreen> {
  final FoodLogController foodLogController = Get.put(FoodLogController());

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  String createdDate = "";
  late DateTime currentDate;

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      foodLogController.callFoodLogListAPI();
    }
    super.initState();
  }

  @override
  void dispose() {
    foodLogController.foodLogFilterList.clear();
    super.dispose();
  }

/*  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMDY.format(date);
    createdDate = d12;
    currentDate = DateTime.now();
    var cDate = formatterMDY.format(currentDate);
    print('cDate: $cDate');
    print('apiDate: $createdDate');

    if(cDate.compareTo(createdDate) < 0){
      print('Current date is Before apidate');
    }
    if(cDate.compareTo(createdDate) == 0){
      print("Both date time are at same moment.");
    }
    return d12;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(GREY),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              WidgetText.widgetPoppinsRegularText(
                "Food Log",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            alignment: Alignment.centerRight,
            child: InkWell(
              child: WidgetText.widgetPoppinsRegularText(
                "View History",
                Color(ORANGE),
                14,
              ),
              onTap: () async {
                await Get.to(()=> FoodLogHistoryScreen());
                if(foodLogController.foodLogListModel.meta?.status == true){
                  foodLogController.foodLogFilterList.clear();
                  foodLogController.callFoodLogListAPI();
                }
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => FoodLogHistoryScreen()));
              },
            ),
          )
        ],
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<FoodLogController>(builder: (logic) {
                return logic.isLoaderTodayVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.foodLogFilterList.length == 0
                        ? Container(
                            child: Center(
                            child: WidgetText.widgetPoppinsMediumText(
                                todatFoodLogEmptyTxt, Color(BLACK), 16),
                          ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                alignment: Alignment.centerLeft,
                                child: WidgetText.widgetRobotoRegularText(
                                  "Today",
                                  Color(ORANGE),
                                  16,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  child: ListView(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              logic.foodLogFilterList.length,
                                          itemBuilder: (context, index) {
                                            // parseTimeStampReport(int.parse( logic.foodLogFilterList[index].createdAt.toString()));

                                            return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 0),
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Color(WHITE),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(ORANGE),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            logic
                                                                        .foodLogFilterList[
                                                                            index]
                                                                        .dishName !=
                                                                    null
                                                                ? WidgetText
                                                                    .widgetPoppinsMediumText(
                                                                    logic
                                                                        .foodLogFilterList[
                                                                            index]
                                                                        .dishName
                                                                        .toString(),
                                                                    Color(
                                                                        BLACK),
                                                                    16,
                                                                  )
                                                                : Container(),
                                                            WidgetText
                                                                .widgetPoppinsRegularText(
                                                              logic
                                                                      .foodLogFilterList[
                                                                          index]
                                                                      .selectQuantity
                                                                      .toString() +
                                                                  " Serving",
                                                              Color(SUBTEXT),
                                                              16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditServeDialog(
                                                              mContext: context,
                                                              foodlogId: logic
                                                                  .foodLogFilterList[
                                                                      index]
                                                                  .foodLogId
                                                                  .toString(),
                                                              dishName: logic
                                                                  .foodLogFilterList[
                                                                      index]
                                                                  .dishName
                                                                  .toString());
                                                        },
                                                        child: Image.asset(
                                                          ic_edit_2,
                                                          width: 20,
                                                          height: 20,
                                                          color: Color(ORANGE),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Image.asset(
                                                          ic_delete,
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 15, 0, 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF9F7F8),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "Calories",
                                                                Color(BLACK),
                                                                13,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                logic
                                                                    .foodLogFilterList[
                                                                        index]
                                                                    .calclulateCalary
                                                                    .toString(),
                                                                Color(SUBTEXT),
                                                                14,
                                                              )
                                                              // : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 15, 0, 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF9F7F8),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "Fat",
                                                                Color(BLACK),
                                                                13,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                logic
                                                                        .foodLogFilterList[
                                                                            index]
                                                                        .calclulateFat
                                                                        .toString() +
                                                                    "g",
                                                                Color(SUBTEXT),
                                                                14,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 15, 0, 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF9F7F8),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "Carbs",
                                                                Color(BLACK),
                                                                13,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                logic
                                                                        .foodLogFilterList[
                                                                            index]
                                                                        .calclulateCarbs
                                                                        .toString() +
                                                                    "g",
                                                                Color(SUBTEXT),
                                                                14,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 15, 0, 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF9F7F8),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "Protein",
                                                                Color(BLACK),
                                                                13,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                logic
                                                                        .foodLogFilterList[
                                                                            index]
                                                                        .calclulateProtein
                                                                        .toString() +
                                                                    "g",
                                                                Color(SUBTEXT),
                                                                14,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Total",
                                              Color(BLACK),
                                              16,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 15, 0, 15),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF9F7F8),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                          "Calories",
                                                          Color(BLACK),
                                                          13,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                          logic.caloriesCTotal
                                                              .toString(),
                                                          Color(SUBTEXT),
                                                          14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 15, 0, 15),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF9F7F8),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                          "Fat",
                                                          Color(BLACK),
                                                          13,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                          logic.fatCTotal
                                                                  .toString() +
                                                              "g",
                                                          Color(SUBTEXT),
                                                          14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 15, 0, 15),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF9F7F8),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                          "Carbs",
                                                          Color(BLACK),
                                                          13,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                          logic.carbsCTotal
                                                                  .toString() +
                                                              "g",
                                                          Color(SUBTEXT),
                                                          14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 15, 0, 15),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF9F7F8),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                          "Protein",
                                                          Color(BLACK),
                                                          13,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                          logic.proteinCTotal
                                                                  .toString() +
                                                              "g",
                                                          Color(SUBTEXT),
                                                          14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
              });
      })),
    );
  }

  void cancelOrderDialog(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              height: 270,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        elevation: 5,
                        color: Color(WHITE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            ic_cross,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                      "Cancel your order",
                      Color(BLACK),
                      18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                    "Reason for cancelation",
                    Color(BLACK),
                    14,
                  ),
                  Card(
                    elevation: 3,
                    color: Color(WHITE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              child: WidgetText.widgetPoppinsRegularText(
                                "--- Select Reason ---",
                                Color(BLACK),
                                12,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Image.asset(
                            ic_down_arrow,
                            height: 10,
                            width: 10,
                            color: Color(BLACK),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WidgetButton.widgetDefaultButton("Submit", () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          );
        });
  }

  void showEditServeDialog({
    required BuildContext mContext,
    required String dishName,
    required String foodlogId,
  }) {
    TextEditingController updateLogController = TextEditingController();
    int serveQty = 0;

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 260,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        elevation: 5,
                        color: Color(WHITE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            ic_cross,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                      dishName,
                      Color(BLACK),
                      18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    elevation: 5,
                    color: Color(WHITE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        controller: updateLogController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xff8C8989),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                          hintText: "Enter your servings",
                        ),
                        onChanged: (val) {
                          setState(() {
                            serveQty = int.parse(val);
                            print('ServeQty: $serveQty');
                          });
                        },
                        style: TextStyle(
                          color: Color(0xff3E4958),
                          fontSize: 16,
                          fontFamily: FontPoppins,
                          fontWeight: PoppinsRegular,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GetBuilder<FoodLogController>(builder: (logic) {
                    return Row(
                      children: [
                        Expanded(
                            child:
                                WidgetButton.widgetDefaultButton("Cancel", () {
                          Navigator.pop(context);
                        })),
                        SizedBox(
                          width: 10,
                        ),
                        logic.isLogUpdated == false
                            ? Expanded(
                                child: WidgetButton.widgetDefaultButton(
                                    "Submit", () async {
                                if (serveQty != 0) {
                                  setState(() {
                                    logic.isLogUpdated = true;
                                  });
                                  await logic.callUpdateLogAPI(
                                      foodLogId: foodlogId,
                                      selectQuantity: updateLogController.text);
                                  if (logic.isLogUpdated == true) {
                                    setState(() {
                                      logic.isLogUpdated = false;
                                      Navigator.pop(context);
                                    });
                                    // Future.delayed(
                                    //     const Duration(milliseconds: 2000), () {
                                    //
                                    // });
                                  }
                                } else {
                                  showToastMessage('Minimum select 1 Quantity');
                                }
                              }))
                            : Center(
                                child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              )),
                      ],
                    );
                  })
                ],
              ),
            ),
          );
        });
  }
}
