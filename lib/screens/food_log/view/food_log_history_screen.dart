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
import '../../../core/widgets/widget_card.dart';
import '../controller/food_log_controller.dart';
import '../model/food_log_list_model.dart';

class FoodLogHistoryScreen extends StatefulWidget {
  @override
  _FoodLogHistoryScreenState createState() => _FoodLogHistoryScreenState();
}

class _FoodLogHistoryScreenState extends State<FoodLogHistoryScreen> {
  final FoodLogController foodLogController = Get.put(FoodLogController());

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  String createdDate = "";
  late DateTime currentDate;

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      foodLogController.isLoaderVisible = true;
      foodLogController.callFoodLogListAPI();
    }
    super.initState();
  }

  @override
  void dispose() {
    foodLogController.foodLogFilterList.clear();
    super.dispose();
  }

  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMDY.format(date);
    createdDate = d12;
    foodLogController.foodLogListModel.data
        ?.sort((a, b) => createdDate.compareTo(createdDate));
    debugPrint('Sort List: $createdDate');
    if (createdDate.compareTo(createdDate) == 0) {
      debugPrint('api has same record of one date');
      debugPrint('createdDate same: ${createdDate}');
    } else if (createdDate.compareTo(createdDate) < 0) {
      debugPrint('api has different record of different date');
      debugPrint('createdDate uniq: ${createdDate}');
    }
    return d12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "History",false ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<FoodLogController>(builder: (logic) {

                return logic.isLoaderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.foodLogListModel.meta?.status == false
                        ? Center(
                            child: Container(
                            child: Text('Data Not Found'),
                          ))
                        : Container(
                  decoration: BoxDecoration(
                    color: Color(WHITE),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    width: double.infinity,
                                    child: ListView(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: logic
                                                .foodLogFilterMainList.length,
                                            itemBuilder: (context, index) {
                                              List<FoodData> foodLogFilterList = [];
                                              foodLogFilterList = logic
                                                  .foodLogFilterMainList[index]
                                                  .foodLogFilterList;

                                              // debugPrint('FoodStatus => ${logic.foodLogFilterList[index].itemDelete}');
                                              return Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(LIGHTDIVIDERCOLOR),
                                                    ),
                                                    height: 70,
                                                    padding: EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: WidgetText
                                                        .widgetRobotoRegularText(
                                                      logic
                                                          .foodLogFilterMainList[
                                                              index]
                                                          .date,
                                                      // "Today",
                                                      Color(ORANGE),
                                                      16,
                                                    ),
                                                  ),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount: foodLogFilterList
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(15),
                                                              padding: EdgeInsets.all(15),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Color(WHITE),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ORANGE),
                                                                    width: 1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            foodLogFilterList[index].dishName != null
                                                                                ? WidgetText.widgetPoppinsMediumText(
                                                                                    foodLogFilterList[index].dishName.toString(),
                                                                                    Color(BLACK),
                                                                                    16,
                                                                                  )
                                                                                : Container(),
                                                                            WidgetText
                                                                                .widgetPoppinsRegularText(
                                                                              foodLogFilterList[index].selectQuantity.toString() +
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
                                                                        onTap:
                                                                            () {
                                                                          showEditServeDialog(
                                                                              mContext:
                                                                                  context,
                                                                              foodlogId:
                                                                                  foodLogFilterList[index].foodLogId.toString(),
                                                                              dishName: foodLogFilterList[index].dishName.toString());
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          ic_edit_2,
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                          color: Color(
                                                                              ORANGE),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      InkWell(
                                                                              onTap: () {
                                                                                foodLogController.callDeleteMenuAPI(foodLogFilterList[index].foodLogId.toString());
                                                                              },
                                                                              child: Image.asset(
                                                                                ic_delete,
                                                                                width: 20,
                                                                                height: 20,
                                                                              ),
                                                                            )
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
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffF9F7F8),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              WidgetText.widgetPoppinsRegularText(
                                                                                "Calories",
                                                                                Color(BLACK),
                                                                                13,
                                                                              ),
                                                                              WidgetText.widgetPoppinsMediumText(
                                                                                foodLogFilterList[index].calclulateCalary.toString(),
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
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffF9F7F8),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              WidgetText.widgetPoppinsRegularText(
                                                                                "Fat",
                                                                                Color(BLACK),
                                                                                13,
                                                                              ),
                                                                              WidgetText.widgetPoppinsMediumText(
                                                                                foodLogFilterList[index].calclulateFat.toString() + "g",
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
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffF9F7F8),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              WidgetText.widgetPoppinsRegularText(
                                                                                "Carbs",
                                                                                Color(BLACK),
                                                                                13,
                                                                              ),
                                                                              WidgetText.widgetPoppinsMediumText(
                                                                                foodLogFilterList[index].calclulateCarbs.toString() + "g",
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
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xffF9F7F8),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              WidgetText.widgetPoppinsRegularText(
                                                                                "Protein",
                                                                                Color(BLACK),
                                                                                13,
                                                                              ),
                                                                              WidgetText.widgetPoppinsMediumText(
                                                                                foodLogFilterList[index].calclulateProtein.toString() + "g",
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
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                  totalCalculation(
                                                      foodLogFilterList, index),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        );
              });
      })),
    );
  }

  Widget totalCalculation(List<FoodData> foodLogFilterList, int i) {
    double resultCal = 0.0,
        resultFat = 0.0,
        resultCarbs = 0.0,
        resultProtein = 0.0;

    for (int i = 0; i < foodLogFilterList.length; i++) {
      if (foodLogFilterList[i].calories != null) {
        if (foodLogFilterList[i].calories!.isNotEmpty) {
          resultCal = resultCal +
              (double.parse(foodLogFilterList[i].calories.toString()) *
                  (double.parse(
                      foodLogFilterList[i].selectQuantity.toString())));
          // debugPrint('calories ----: $resultCal');
        }
      } else {
        resultCal = resultCal + 0.0;
      }

      if (foodLogFilterList[i].fat != null) {
        if (foodLogFilterList[i].fat!.isNotEmpty) {
          resultFat = resultFat +
              (double.parse(foodLogFilterList[i].fat.toString()) *
                  (double.parse(
                      foodLogFilterList[i].selectQuantity.toString())));
          // debugPrint('fat ----: $resultFat');
        }
      } else {
        resultFat = resultFat + 0.0;
      }

      if (foodLogFilterList[i].carbs != null) {
        if (foodLogFilterList[i].carbs!.isNotEmpty) {
          resultCarbs = resultCarbs +
              (double.parse(foodLogFilterList[i].carbs.toString()) *
                  (double.parse(
                      foodLogFilterList[i].selectQuantity.toString())));
          // debugPrint('carbs----: $resultCarbs');
        } else {
          resultCarbs = resultCarbs + 0.0;
        }
      }

      if (foodLogFilterList[i].protein != null) {
        if (foodLogFilterList[i].protein!.isNotEmpty) {
          resultProtein = resultProtein +
              (double.parse(foodLogFilterList[i].protein.toString()) *
                  (double.parse(
                      foodLogFilterList[i].selectQuantity.toString())));
          // debugPrint('protein----: $resultProtein');

        } else {
          resultProtein = resultProtein + 0.0;
        }
      }
    }
    //
    // debugPrint('caloriesTotal -----: $resultCal');
    // debugPrint('fatTotal -----: $resultFat');
    // debugPrint('carbsTotal -----: $resultCarbs');
    // debugPrint('proteinTotal -----: $resultProtein');

    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(WHITE),
        shape: BoxShape.rectangle,
        border: Border.all(color: Color(ORANGE), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F7F8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Calories",
                        Color(BLACK),
                        13,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        resultCal.toString(),
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F7F8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Fat",
                        Color(BLACK),
                        13,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        resultFat.toString() + "g",
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F7F8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Carbs",
                        Color(BLACK),
                        13,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        resultCarbs.toString() + "g",
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F7F8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Protein",
                        Color(BLACK),
                        13,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        resultProtein.toString() + "g",
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
              decoration: BoxDecoration(
                color: Color(WHITE),
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(WHITE),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
              decoration: BoxDecoration(
                color: Color(WHITE),
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(WHITE),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
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
                            debugPrint('ServeQty: $serveQty');
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
