import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/app_color_utils.dart';
import '../../../../../../core/utils/app_font_utils.dart';
import '../../../../../../core/utils/app_strings_constants.dart';
import '../../../../../../core/utils/networkManager.dart';
import '../../../../../../core/widgets/widget_text.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/add_slot_controller.dart';
import '../controller/slot_controller.dart';

class AddHoursScreen extends StatefulWidget {
  bool isEditable;
  var slotID;
  AddHoursScreen({
    Key? key,required this.isEditable, this.slotID
  }) : super(key: key);

  @override
  State<AddHoursScreen> createState() => _AddHoursScreenState();
}

class _AddHoursScreenState extends State<AddHoursScreen> {
  final SlotController slotController = Get.put(SlotController());
  final AddEditHoursController _addEditHoursController = Get.put(AddEditHoursController());
  // bool isLoader = true;

  @override
  void initState() {
    _addEditHoursController.isLoaderVisible = true;
    if(widget.isEditable){
      _addEditHoursController.callGetSlotDetails(widget.slotID);
    }else{
      _addEditHoursController.addSlotTime();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Add Slot",  true),
      body: SafeArea(
        child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : SingleChildScrollView(
                      child:  GetBuilder<AddEditHoursController>(builder: (logic) {
                        return
                          logic.isLoaderVisible == true
                              ? Center(
                              child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              ))
                              :
                          Container(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                elevation: 5.0,
                                shadowColor: Color(BLACK),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        borderRadius: BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      selectedItemBuilder: (_) {
                                        return logic.dayList
                                            .map((e) => Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ))
                                            .toList();
                                      },
                                      isExpanded: true,
                                      value: logic.selectDay,
                                      icon: Image.asset(
                                        ic_down_arrow,
                                        height: 10,
                                        width: 20,
                                        color: Color(BLACK),
                                      ),
                                      items: logic.dayList.map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(
                                            value,
                                            style:
                                            TextStyle(color: Colors.black54),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          logic.selectDay = val;
                                          debugPrint('selectDay : ${logic.selectDay}');
                                        });
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    logic.addSlotTime();
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: WidgetText.widgetPoppinsMediumText(
                                    "Add Slots",
                                    Color(ORANGE),
                                    16,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: logic.timeModelList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      // color: Color(GREY7),
                                      elevation: 5.0,
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(10.0),
                                      // ),
                                      shadowColor: Color(BLACK),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(GREY7),
                                            borderRadius: BorderRadius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                      "Start time",
                                                      Color(DARKGREY),
                                                      17,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          logic.removeSlotTime(index);
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        ic_delete_btn,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: /*selectStartHours.isEmpty ? Container() :*/
                                                    DropdownButton(
                                                      // underline: Container(),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      icon: Visibility(
                                                        visible: true,
                                                        child: Image.asset(
                                                          ic_down_arrow,
                                                          height: 10,
                                                          width: 20,
                                                          color: Color(BLACK),
                                                        ),
                                                      ),
                                                      isExpanded: true,
                                                      value: logic.timeModelList[index]
                                                          .startHour
                                                          .toString(),
                                                      //           value:   timeModelList[index].startHour.isEmpty ||  timeModelList[index].startHour == null
                                                      // ?   timeModelList[index].startHour[0].toString()
                                                      // :  timeModelList[index].startHour.toString(),
                                                      style: TextStyle(
                                                        color: Color(BLACK),
                                                        fontSize: 16,
                                                        fontFamily: FontPoppins,
                                                        fontWeight: PoppinsRegular,
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          logic.timeModelList[index]
                                                              .startHour =
                                                              value.toString();
                                                          print(
                                                              'selectStartHours: ${logic.timeModelList[index].startHour}');
                                                        });
                                                      },
                                                      items: logic.startHoursList
                                                          .map((dynamic value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          child: Center(
                                                            child: Text(
                                                              value.toString(),
                                                              style: TextStyle(
                                                                color: Color(BLACK),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                FontRoboto,
                                                                fontWeight:
                                                                RobotoRegular,
                                                              ),
                                                            ),
                                                          ),
                                                          value: value.toString(),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 20),
                                                      child: Text(':')),
                                                  Expanded(
                                                    child: DropdownButton(
                                                      // underline: Container(),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      icon: Visibility(
                                                        visible: true,
                                                        child: Image.asset(
                                                          ic_down_arrow,
                                                          height: 10,
                                                          width: 20,
                                                          color: Color(BLACK),
                                                        ),
                                                      ),
                                                      isExpanded: true,
                                                      // value: selectStartMinutes ?? "",
                                                      value: logic.timeModelList[index]
                                                          .startMinute
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Color(BLACK),
                                                        fontSize: 16,
                                                        fontFamily: FontPoppins,
                                                        fontWeight: PoppinsRegular,
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          logic.timeModelList[index]
                                                              .startMinute =
                                                              value.toString();
                                                          print(
                                                              'selectStartMinutes: ${logic.timeModelList[index].startMinute}');
                                                        });
                                                      },
                                                      items: logic.startMinutesList
                                                          .map((dynamic value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          child: Center(
                                                            child: Text(
                                                              value.toString(),
                                                              style:
                                                              const TextStyle(
                                                                color: Color(BLACK),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                FontRoboto,
                                                                fontWeight:
                                                                RobotoRegular,
                                                              ),
                                                            ),
                                                          ),
                                                          value: value.toString(),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  7)),
                                                          border: Border.all(
                                                              color: Color(
                                                                  LIGHTGREYCOLORICON))),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  logic.timeModelList[
                                                                  index]
                                                                      .startMorning =
                                                                  true;
                                                                  print('AM');
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: logic.timeModelList[
                                                                  index]
                                                                      .startMorning ==
                                                                      true
                                                                      ? Color(
                                                                      ORANGE)
                                                                      : Color(
                                                                      WHITE),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          7),
                                                                      bottomLeft: Radius
                                                                          .circular(
                                                                          7)),
                                                                ),
                                                                padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                                height: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                      'AM',
                                                                      style: TextStyle(
                                                                          color: logic.timeModelList[index]
                                                                              .startMorning ==
                                                                              true
                                                                              ? Colors
                                                                              .white
                                                                              : Color(
                                                                              ORANGE)),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  logic.timeModelList[
                                                                  index]
                                                                      .startMorning =
                                                                  false;
                                                                  print('PM');
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: logic.timeModelList[
                                                                  index]
                                                                      .startMorning ==
                                                                      true
                                                                      ? Color(WHITE)
                                                                      : Color(
                                                                      ORANGE),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                          7),
                                                                      bottomRight: Radius
                                                                          .circular(
                                                                          7)),
                                                                ),
                                                                padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                                height: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                      'PM',
                                                                      style: TextStyle(
                                                                          color: logic.timeModelList[index]
                                                                              .startMorning ==
                                                                              true
                                                                              ? Color(
                                                                              ORANGE)
                                                                              : Colors
                                                                              .white),
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              WidgetText.widgetPoppinsRegularText(
                                                "Close time",
                                                Color(DARKGREY),
                                                17,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropdownButton(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      icon: Visibility(
                                                        visible: true,
                                                        child: Image.asset(
                                                          ic_down_arrow,
                                                          height: 10,
                                                          width: 20,
                                                          color: Color(BLACK),
                                                        ),
                                                      ),
                                                      isExpanded: true,
                                                      value: logic.timeModelList[index]
                                                          .endHour ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Color(BLACK),
                                                        fontSize: 16,
                                                        fontFamily: FontPoppins,
                                                        fontWeight: PoppinsRegular,
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          logic.timeModelList[index]
                                                              .endHour =
                                                              value.toString();
                                                          print(
                                                              'selectEndHours: ${logic.timeModelList[index].endHour}');
                                                        });
                                                      },
                                                      items: logic.endHoursList
                                                          .map((dynamic value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          child: Center(
                                                            child: Text(
                                                              value,
                                                              style:
                                                              const TextStyle(
                                                                color: Color(BLACK),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                FontRoboto,
                                                                fontWeight:
                                                                RobotoRegular,
                                                              ),
                                                            ),
                                                          ),
                                                          value: value,
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 20),
                                                      child: Text(':')),
                                                  Expanded(
                                                    child: DropdownButton(
                                                      // underline: Container(),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      icon: Visibility(
                                                        visible: true,
                                                        child: Image.asset(
                                                          ic_down_arrow,
                                                          height: 10,
                                                          width: 20,
                                                          color: Color(BLACK),
                                                        ),
                                                      ),
                                                      isExpanded: true,
                                                      value: logic.timeModelList[index]
                                                          .endMinute ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Color(BLACK),
                                                        fontSize: 16,
                                                        fontFamily: FontPoppins,
                                                        fontWeight: PoppinsRegular,
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          logic.timeModelList[index]
                                                              .endMinute =
                                                              value.toString();
                                                          print(
                                                              'selectEndMinutes: ${logic.timeModelList[index].endMinute}');
                                                        });
                                                      },
                                                      items: logic.endMinutesList
                                                          .map((dynamic value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          child: Center(
                                                            child: Text(
                                                              value.toString(),
                                                              style:
                                                              const TextStyle(
                                                                color: Color(BLACK),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                FontRoboto,
                                                                fontWeight:
                                                                RobotoRegular,
                                                              ),
                                                            ),
                                                          ),
                                                          value: value.toString(),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  7)),
                                                          border: Border.all(
                                                              color: Color(
                                                                  LIGHTGREYCOLORICON))),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  logic.timeModelList[
                                                                  index]
                                                                      .endMorning =
                                                                  true;
                                                                  print('AM');
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: logic.timeModelList[
                                                                  index]
                                                                      .endMorning
                                                                      ? Color(
                                                                      ORANGE)
                                                                      : Color(
                                                                      WHITE),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          7),
                                                                      bottomLeft: Radius
                                                                          .circular(
                                                                          7)),
                                                                ),
                                                                padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                                height: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                      'AM',
                                                                      style: TextStyle(
                                                                          color: logic.timeModelList[
                                                                          index]
                                                                              .endMorning
                                                                              ? Colors
                                                                              .white
                                                                              : Color(
                                                                              ORANGE)),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  logic.timeModelList[
                                                                  index]
                                                                      .endMorning =
                                                                  false;
                                                                  print('PM');
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: logic.timeModelList[
                                                                  index]
                                                                      .endMorning
                                                                      ? Color(WHITE)
                                                                      : Color(
                                                                      ORANGE),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                          7),
                                                                      bottomRight: Radius
                                                                          .circular(
                                                                          7)),
                                                                ),
                                                                padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                                height: 40,
                                                                child: Center(
                                                                    child: Text(
                                                                      'PM',
                                                                      style: TextStyle(
                                                                          color: logic.timeModelList[
                                                                          index]
                                                                              .endMorning
                                                                              ? Color(
                                                                              ORANGE)
                                                                              : Colors
                                                                              .white),
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    !logic.isSlotAdded ?
                                    InkWell(
                                      onTap: () async {
                                        if(logic.selectDay!= "Select Day"){
                                          debugPrint('timeList len: ${logic.timeModelList.length}');
                                          await logic.convertTo24HoursList();

                                          if(widget.isEditable == false){
                                            final params = jsonEncode({
                                              HttpConstants.PARAMS_DAY: logic.selectDay?.toUpperCase().toString(),
                                              HttpConstants.PARAMS_TIME: logic.timeList,
                                            });
                                            debugPrint('params: $params');
                                            await logic.addNewSlotApi(params: params);
                                            if (logic.metaModel.meta?.status == true) {
                                              Get.back(result: true);
                                            }
                                          }else{
                                            final params = jsonEncode({
                                              HttpConstants.PARAMS_DAY: logic.selectDay?.toUpperCase().toString(),
                                              HttpConstants.PARAMS_REST_SLOT_ID: widget.slotID.toString(),
                                              HttpConstants.PARAMS_TIME: logic.timeList,
                                            });
                                            debugPrint('params: $params');
                                            await logic.editSlotApi(params: params);
                                            if (logic.metaModel.meta?.status == true) {
                                              Get.back(result: true);
                                            }
                                          }
                                        }else{
                                          showToastMessage("Please select day first");
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color(ORANGE),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        alignment: Alignment.center,
                                        child: WidgetText
                                            .widgetPoppinsMediumText(
                                          "Submit",
                                          Color(WHITE),
                                          14,
                                        ),
                                      ),
                                    )
                                        : Center(
                                      child: CircularProgressIndicator(
                                        color: Color(ORANGE),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          logic.selectDay = "Select Day";
                                          logic.timeModelList.clear();
                                          logic.addSlotTime();
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        padding:
                                        EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        alignment: Alignment.center,
                                        child: WidgetText.widgetPoppinsMediumText(
                                          "Reset",
                                          Color(ORANGE),
                                          14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
        }),
      ),
    );
  }
}
