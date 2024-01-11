import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/widgets/widget_card.dart';
import 'add_edit_deals_screen.dart';
import '../controller/coupon_list_controller.dart';
import 'deal_details_screen.dart';

class DealsScreen extends StatefulWidget {
  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  final CouponListController couponListController =
      Get.put(CouponListController());
  String? selectStatus = "Choose Status";

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  TextEditingController searchMenuController = new TextEditingController();
  List<String> statusList = [
    choose_status,
    'Active',
    'Inactive',
  ];

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      couponListController.getCouponList(true, status: '', search: '');
    }
    super.initState();
  }

  // logic.getCouponList.data?[index].showInApp == true

  // bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Deals", true ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
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
                                        style: TextStyle(
                                          color: Color(WHITE),
                                          fontSize: 14,
                                          fontFamily: FontPoppins,
                                          fontWeight: PoppinsRegular,
                                        ),
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
                                style: TextStyle(
                                  color: Color(BLACK),
                                  fontSize: 14,
                                  fontFamily: FontPoppins,
                                  fontWeight: PoppinsRegular,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectStatus = _;
                            });
                            if (selectStatus == 'Choose Status') {
                              couponListController.getCouponList(true,
                                  status: '', search: '');
                            } else {
                              if (selectStatus == 'Inactive') {
                                couponListController.getCouponList(true,
                                    status: 'DEACTIVE', search: '');
                              } else {
                                couponListController.getCouponList(true,
                                    status: selectStatus.toString(),
                                    search: '');
                              }
                            }
                            /*    if(selectStatus == 'Active'){
                              couponListController.getCouponList(true, status: 'Active');
                            }else if(selectStatus == 'Inactive'){
                              couponListController.getCouponList(true, status: 'deactive');
                            }else{
                              couponListController.getCouponList(true, status: '');
                            }*/
                          },
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      await Get.to(() => AddEditDealScreen(
                            isEdit: false,
                          ));
                      setState(() {
                        couponListController.getCouponList(true,
                            status: '', search: '');
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
                        "Add Deal",
                        Color(ORANGE),
                        16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Color(WHITE),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Color(BLACK),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextFormField(
                        controller: searchMenuController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: InkWell(
                            child: Icon(Icons.search, color: Color(HINTCOLOR)),
                            onTap: () {},
                          ),
                          hintStyle: TextStyle(
                            color: Color(HINTCOLOR),
                            fontSize: 16,
                            fontFamily: FontRoboto,
                            fontWeight: RobotoRegular,
                          ),
                          hintText: search,
                        ),
                        onChanged: (val) {
                          print('SearchKey: $val');
                          if (val == '') {
                            couponListController.getCouponList(true,
                                status: '', search: '');
                          }
                        },
                        onEditingComplete: () {
                          print(
                              'Search Complete: ${searchMenuController.text}');
                          if (selectStatus == 'Choose Status') {
                            couponListController.getCouponList(true,
                                status: '', search: searchMenuController.text);
                          } else {
                            couponListController.getCouponList(true,
                                status: selectStatus.toString(),
                                search: searchMenuController.text);
                          }
                        },
                        style: TextStyle(
                          color: Color(BLACK),
                          fontSize: 16,
                          fontFamily: FontRoboto,
                          fontWeight: RobotoMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: GetBuilder<CouponListController>(builder: (logic) {
                    return logic.isLoaderVisible
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : logic.getCouponListModel.meta?.status == false
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text('No Deals Found'),
                              )
                            : Container(
                                height: 210,
                                width: double.infinity,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        logic.getCouponListModel.data?.length ??
                                            1,
                                    itemBuilder: (context, index) {
                                      dynamic serialNo = index + 1;
                                      String? selectCouponType = select;
                                      selectCouponType = getSelectedCouponType(
                                          logic.getCouponListModel.data?[index]
                                                  .couponType ??
                                              "");
                                      print(
                                          'selectCouponType: $selectCouponType');

                                      return Card(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        color: Color(WHITE),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        shadowColor: Color(BLACK),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(WHITE),
                                              borderRadius: BorderRadius.circular(10.0)),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            sno + " : ",
                                                            Color(GREY3),
                                                            13),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            serialNo.toString(),
                                                            Color(BLACK),
                                                            13),
                                                    Spacer(),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            coupon_name + ": ",
                                                            Color(GREY3),
                                                            13),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            // "Test 8",
                                                            logic
                                                                    .getCouponListModel
                                                                    .data?[index]
                                                                    .couponName ??
                                                                "",
                                                            Color(BLACK),
                                                            13),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 0),
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color: Color(ORANGE),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                      coupon_type,
                                                                      Color(
                                                                          GREY3),
                                                                      13),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                      // logic.getCouponListModel.data?[index].couponType ?? "",
                                                                      selectCouponType ??
                                                                          "",
                                                                      Color(
                                                                          BLACK),
                                                                      13),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              WidgetText.widgetRobotoMediumText(
                                                                  logic.getCouponListModel.data?[index]
                                                                              .discountIn ==
                                                                          "ABSOLUTE"
                                                                      ? "\$${logic.getCouponListModel.data?[index].discount.toString() ?? ""}"
                                                                      : "${logic.getCouponListModel.data?[index].discount.toString() ?? ""}%",
                                                                  Color(ORANGE),
                                                                  16),
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                      "(Discount)",
                                                                      Color(
                                                                          GREY3),
                                                                      12),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                              discount_in,
                                                              Color(GREY3),
                                                              13),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText.widgetRobotoMediumText(
                                                          logic
                                                                  .getCouponListModel
                                                                  .data?[index]
                                                                  .discountIn ??
                                                              "",
                                                          Color(BLACK),
                                                          13),
                                                      /*    SizedBox(
                                                      height: 15,
                                                    ),
                                                    WidgetText.widgetPoppinsRegularText(
                                                            show_in_app,
                                                            Color(GREY3),
                                                            13),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    WidgetText
                                                        .widgetRobotoMediumText(
                                                        logic.getCouponListModel.data?[index].showInApp == true ?
                                                            "Yes" : "No",
                                                            Color(BLACK),
                                                            13),*/
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Get.to(() =>
                                                              DealDetailsScreen(
                                                                  serialNo,
                                                                  logic
                                                                          .getCouponListModel
                                                                          .data?[
                                                                              index]
                                                                          .couponId
                                                                          .toString() ??
                                                                      ""));
                                                          logic.getCouponList(
                                                              false,
                                                              status: '',
                                                              search: '');
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 10, 0, 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(ORANGE),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            7)),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            view_detail,
                                                            Color(WHITE),
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Get.to(() =>
                                                              AddEditDealScreen(
                                                                isEdit: true,
                                                                couponId: logic
                                                                    .getCouponListModel
                                                                    .data?[index]
                                                                    .couponId
                                                                    .toString(),
                                                              ));
                                                          setState(() {
                                                            couponListController
                                                                .getCouponList(
                                                                    false,
                                                                    status: '',
                                                                    search: '');
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 10, 0, 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(WHITE),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            border: Border.all(
                                                                color:
                                                                    Color(ORANGE),
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
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
                                                                color:
                                                                    Color(ORANGE),
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                edit,
                                                                Color(ORANGE),
                                                                12,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    logic
                                                                .getCouponListModel
                                                                .data?[index]
                                                                .isStatusUpdated ==
                                                            false
                                                        ? InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                if (logic
                                                                        .getCouponListModel
                                                                        .data?[
                                                                            index]
                                                                        .status ==
                                                                    active) {
                                                                  logic
                                                                      .getCouponListModel
                                                                      .data?[
                                                                          index]
                                                                      .setStatusUpdated = true;
                                                                } else {
                                                                  logic
                                                                      .getCouponListModel
                                                                      .data?[
                                                                          index]
                                                                      .setStatusUpdated = true;
                                                                }
                                                                print(
                                                                    'checked:this ${logic.getCouponListModel.data?[index].status}');
                                                              });

                                                              if (logic
                                                                      .getCouponListModel
                                                                      .data?[
                                                                          index]
                                                                      .status ==
                                                                  active) {
                                                                await logic
                                                                    .callStatusUpdateAPI(
                                                                  couponId: logic
                                                                      .getCouponListModel
                                                                      .data![
                                                                          index]
                                                                      .couponId
                                                                      .toString(),
                                                                  status:
                                                                      deActive,
                                                                );
                                                                print(
                                                                    'addToCartBool timer => ${logic.isStatusChanged}');
                                                                if (logic
                                                                        .isStatusChanged ==
                                                                    true) {
                                                                  var result =
                                                                      true;
                                                                  print(
                                                                      'Result => $result');
                                                                  if (result) {
                                                                    setState(() {
                                                                      logic
                                                                          .getCouponListModel
                                                                          .data?[
                                                                              index]
                                                                          .setStatusUpdated = false;
                                                                    });
                                                                  }
                                                                }
                                                              } else {
                                                                await logic.callStatusUpdateAPI(
                                                                    couponId: logic
                                                                        .getCouponListModel
                                                                        .data![
                                                                            index]
                                                                        .couponId
                                                                        .toString(),
                                                                    status:
                                                                        active);
                                                                print(
                                                                    'addToCartBool timer => ${logic.isStatusChanged}');
                                                                if (logic
                                                                        .isStatusChanged ==
                                                                    true) {
                                                                  var result =
                                                                      true;
                                                                  print(
                                                                      'Result => $result');
                                                                  if (result) {
                                                                    setState(() {
                                                                      logic
                                                                          .getCouponListModel
                                                                          .data?[
                                                                              index]
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
                                                                  color:
                                                                      CupertinoColors
                                                                          .white,
                                                                  border: Border.all(
                                                                      color: logic.getCouponListModel.data?[index].status ==
                                                                              active
                                                                          ? Color(
                                                                              GREENCOLORICON)
                                                                          : Color(
                                                                              LIGHTERGREYCOLORICON),
                                                                      style: BorderStyle
                                                                          .solid,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: logic
                                                                          .getCouponListModel
                                                                          .data?[
                                                                              index]
                                                                          .status ==
                                                                      active
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Icon(
                                                                            CupertinoIcons
                                                                                .check_mark,
                                                                            color:
                                                                                Color(GREENCOLORICON)),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              shape:
                                                                                  BoxShape.rectangle,
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
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape
                                                                                  .rectangle,
                                                                              border: Border.all(
                                                                                  color: Color(LIGHTERGREYCOLORICON),
                                                                                  style: BorderStyle.solid,
                                                                                  width: 1),
                                                                              borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        Icon(
                                                                            CupertinoIcons
                                                                                .clear,
                                                                            color:
                                                                                Color(LIGHTERGREYCOLORICON)),
                                                                      ],
                                                                    ),
                                                            ),
                                                          )
                                                        : Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Color(ORANGE),
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
                              );
                  })),
                ],
              );
      })),
    );
  }
}
