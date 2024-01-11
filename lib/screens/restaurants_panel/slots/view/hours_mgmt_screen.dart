import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/slot_controller.dart';
import 'add_hours_screen.dart';

class HoursMgmtScreen extends StatefulWidget {
  @override
  State<HoursMgmtScreen> createState() => _HoursMgmtScreenState();
}

class _HoursMgmtScreenState extends State<HoursMgmtScreen> {
  final SlotController slotController = Get.put(SlotController());
  String? selectStatus = "Choose Status";

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  String createdDate = "";

  List<String> statusList = [
    'Choose Status',
    'Open',
    'Close',
  ];

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      slotController.getSlotList(true, status: '');
    }
    super.initState();
  }

  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    return d12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Hours of Operation",true ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Color(ORANGE),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Color(BLACK),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: DropdownButton<String>(
                          underline: Container(),
                          selectedItemBuilder: (_) {
                            return statusList
                                .map((e) => Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        e,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                .toList();
                          },
                          isExpanded: true,
                          value: selectStatus,
                          icon: Image.asset(
                            ic_down_arrow,
                            height: 10,
                            width: 20,
                            color: Color(WHITE),
                          ),
                          items: statusList.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.black54),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectStatus = _;
                            });
                            if (selectStatus == 'Open') {
                              slotController.getSlotList(true,
                                  status: 'Active');
                            } else if (selectStatus == 'Close') {
                              slotController.getSlotList(true,
                                  status: 'deactive');
                            } else {
                              slotController.getSlotList(true, status: '');
                            }
                          },
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      await Get.to(() => AddHoursScreen(isEditable: false,));
                      setState(() {
                        slotController.getSlotList(true, status: '');
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      alignment: Alignment.center,
                      child: WidgetText.widgetPoppinsMediumText(
                        "Add",
                        Color(ORANGE),
                        16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GetBuilder<SlotController>(builder: (logic) {
                    return logic.isLoaderVisible == false
                        ? Expanded(
                            child: Container(
                              height: 210,
                              width: double.infinity,
                              child: logic.getSlotListModel.data?.length == 0
                                  ? Center(
                                      child: Container(
                                      child: Text('No Slot Found'),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          logic.getSlotListModel.data?.length,
                                      itemBuilder: (context, index) {
                                        parseTimeStampReport(int.parse(logic
                                                .getSlotListModel
                                                .data?[index]
                                                .createdAt
                                                .toString() ??
                                            ""));


                                        return InkWell(
                                          child: Card(
                                            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                            elevation: 5.0,
                                            shadowColor: Color(BLACK),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(WHITE),
                                                  borderRadius: BorderRadius.circular(10.0)),
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    15, 15, 15, 15),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                                                        /*        Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "$createdDateTxt: ",
                                                                Color(GREY3),
                                                                14),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                createdDate,
                                                                Color(BLACK),
                                                                14),
                                                      ],
                                                    ),*/
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                            "$timeSlotsTxt: ",
                                                            Color(GREY3),
                                                            14),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                            "${logic.getSlotListModel.data?[index].day ?? ""}",
                                                            Color(BLACK),
                                                            14),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20,),
                                                    GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: logic
                                                          .getSlotListModel
                                                          .data?[index]
                                                          .time
                                                          .length,
                                                      // itemCount: 10,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio: 2.5,
                                                              crossAxisSpacing: 40),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int timeIndex) {

                                                        return WidgetText
                                                            .widgetPoppinsMediumText(
                                                                // "${logic.getSlotListModel.data?[index].time[timeIndex].startTime ?? ""} to ${logic.getSlotListModel.data?[index].time[timeIndex].endTime ?? ""} ",
                                                                "${logic.getSlotListModel.data?[index].time[timeIndex].combineTime} ",
                                                                Color(BLACK2),
                                                                14);
                                                      },
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                                await Get.to(() =>
                                                                    AddHoursScreen(
                                                                  isEditable:
                                                                      true,
                                                                  slotID: logic
                                                                      .getSlotListModel
                                                                      .data?[
                                                                          index]
                                                                      .slotId,
                                                                ));
                                                            setState(() {
                                                              slotController
                                                                  .getSlotList(
                                                                      false,
                                                                      status: '');
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: MediaQuery.of(context).size.width / 5,
                                                            // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(WHITE),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                  color: Color(
                                                                      ORANGE),
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              7)),
                                                            ),
                                                            alignment:
                                                                Alignment.center,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  ic_edit_undeline,
                                                                  height: 10,
                                                                  width: 20,
                                                                  color: Color(
                                                                      ORANGE),
                                                                ),
                                                                SizedBox(width: 5,),
                                                                WidgetText
                                                                    .widgetPoppinsMediumText(
                                                                  "Edit",
                                                                  Color(ORANGE),
                                                                  13,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                                                         /*           SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(context).size.width / 3,
                                                          // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Color(ORANGE),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            border: Border.all(
                                                                color: Color(
                                                                    ORANGE),
                                                                width: 1),
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                7)),
                                                          ),
                                                          alignment: Alignment.center,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Image.asset(
                                                                ic_delete,
                                                                height: 15,
                                                                width: 20,
                                                                color: Color(
                                                                    WHITE),
                                                              ),
                                                              SizedBox(width: 5,),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                "Delete",
                                                                Color(WHITE),
                                                                13,
                                                              ),
                                                            ],
                                                          ),
                                                        ),*/
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                                onTap: () async {
                                                                        setState(() {
                                                                    if (logic
                                                                            .getSlotListModel
                                                                            .data?[
                                                                                index]
                                                                            .status ==
                                                                        active) {
                                                                      logic
                                                                          .getSlotListModel
                                                                          .data?[index].setStatusUpdated = true;
                                                                    } else {
                                                                      logic
                                                                          .getSlotListModel
                                                                          .data?[
                                                                              index]
                                                                          .setStatusUpdated = true;
                                                                    }
                                                                    debugPrint(
                                                                        'checked:this ${logic.getSlotListModel.data?[index].status}');
                                                                  });

                                                                  if (logic.getSlotListModel.data?[index].status == active) {
                                                                    await logic
                                                                        .callStatusUpdateAPI(
                                                                      slotId: logic
                                                                          .getSlotListModel
                                                                          .data![
                                                                              index]
                                                                          .slotId
                                                                          .toString(),
                                                                      status:
                                                                          deActive,
                                                                    );
                                                                    debugPrint(
                                                                        'addToCartBool timer => ${logic.isStatusChanged}');
                                                                    if (logic.isStatusChanged == true) {
                                                                      var result = true;
                                                                      debugPrint(
                                                                          'Result => $result');
                                                                      if (result) {
                                                                            setState(
                                                                            () {
                                                                          logic
                                                                              .getSlotListModel
                                                                              .data?[index]
                                                                              .setStatusUpdated = false;
                                                                        });
                                                                      }
                                                                    }
                                                                  } else {
                                                                    await logic.callStatusUpdateAPI(
                                                                        slotId: logic
                                                                            .getSlotListModel
                                                                            .data![
                                                                                index]
                                                                            .slotId
                                                                            .toString(),
                                                                        status:
                                                                            active);
                                                                    debugPrint(
                                                                        'addToCartBool timer => ${logic.isStatusChanged}');
                                                                    if (logic
                                                                            .isStatusChanged ==
                                                                        true) {
                                                                      var result =
                                                                          true;
                                                                      debugPrint(
                                                                          'Result => $result');
                                                                      if (result) {
                                                                        setState(
                                                                            () {
                                                                              logic
                                                                              .getSlotListModel
                                                                              .data?[index]
                                                                              .setStatusUpdated = false;
                                                                        });
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: 70,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: CupertinoColors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: logic.getSlotListModel.data?[index].status ==
                                                                                  active
                                                                              ? Color(
                                                                                  GREENCOLORICON)
                                                                              : Color(
                                                                                  LIGHTERGREYCOLORICON),
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5))),
                                                                  child: logic
                                                                              .getSlotListModel
                                                                              .data?[index]
                                                                              .status ==
                                                                          active
                                                                      ? Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Icon(
                                                                                CupertinoIcons.check_mark,
                                                                                color: Color(GREENCOLORICON)),
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                  shape: BoxShape.rectangle,
                                                                                  color: Color(GREENCOLORICON),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                              height:
                                                                                  30,
                                                                              width:
                                                                                  30,
                                                                            ),
                                                                            // SizedBox(width: 5,)
                                                                          ],
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                  shape: BoxShape.rectangle,
                                                                                  border: Border.all(color: Color(LIGHTERGREYCOLORICON), style: BorderStyle.solid, width: 1),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                              height:
                                                                                  30,
                                                                              width:
                                                                                  30,
                                                                            ),
                                                                            Icon(
                                                                                CupertinoIcons.clear,
                                                                                color: Color(LIGHTERGREYCOLORICON)),
                                                                          ],
                                                                        ),
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          );
                  }),
                ],
              );
      })),
    );
  }
}
