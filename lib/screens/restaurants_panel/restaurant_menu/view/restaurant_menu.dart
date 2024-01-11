import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/rest_menu_controller.dart';
import 'addMenu/add_restaurant_tab_screen.dart';

class RestaurantMenuScreen extends StatefulWidget {
  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  final RestMenuController restMenuController = Get.put(RestMenuController());
  TextEditingController searchMenuController = new TextEditingController();
  String? selectStatus = "Choose Status";

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  List statusList = [
    'Choose Status',
    'Active',
    'Inactive',
  ];

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      /*  restMenuController.firstLoad(status: '', search: '');
      restMenuController.controller = ScrollController()
        ..addListener(restMenuController.loadMore(status: '', search: ''));*/
      restMenuController.getMenuListApi(status: "", search: "");
    }
    super.initState();
  }

  // bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Menu",true ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: WidgetButton.widgetDefaultButton(
                        addMenuItem, onClickAddMenu),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          elevation: 5.0,
                          shadowColor: Color(BLACK),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(WHITE),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: DropdownButton(
                              underline: Container(),
                              borderRadius: BorderRadius.circular(10),
                              icon: Visibility(
                                visible: true,
                                child: Image.asset(
                                  ic_down_arrow,
                                  height: 10,
                                  width: 20,
                                  color: Color(DARKGREY),
                                ),
                              ),
                              isExpanded: true,
                              value: selectStatus == "Choose Status"
                                  ? statusList[0].toString()
                                  : selectStatus,
                              style: TextStyle(
                                color: Color(BLACK),
                                fontSize: 16,
                                fontFamily: FontPoppins,
                                fontWeight: PoppinsRegular,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectStatus = value.toString();
                                  // controller.text = value.toString();
                                  debugPrint('selectStatus : ${selectStatus}');
                                  if (selectStatus == "Choose Status") {
                                    restMenuController.getMenuListApi(
                                        status: "", search: "");
                                  } else {
                                    restMenuController.getMenuListApi(
                                        status: selectStatus.toString(),
                                        search: "");
                                  }
                                });
                              },
                              items: statusList.map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: selectStatus == "Choose Status"
                                          ? Color(HINTCOLOR)
                                          : Color(BLACK),
                                      fontSize: 14,
                                      fontFamily: FontRoboto,
                                      fontWeight: RobotoRegular,
                                    ),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Card(
                        margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                child:
                                    Icon(Icons.search, color: Color(HINTCOLOR)),
                                onTap: () {
                                  restMenuController.getMenuListApi(
                                      status: "",
                                      search: searchMenuController.text);
                                },
                              ),
                              hintStyle: TextStyle(
                                color: Color(HINTCOLOR),
                                fontSize: 16,
                                fontFamily: FontRoboto,
                                fontWeight: RobotoRegular,
                              ),
                              hintText: "Search",
                            ),
                            onChanged: (val) {
                              debugPrint('SearchKey: $val');
                              if (val == "") {
                                restMenuController.getMenuListApi(
                                    status: "",
                                    search: searchMenuController.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else {
                                debugPrint(
                                    'Search Complete: ${searchMenuController.text}');
                                restMenuController.getMenuListApi(
                                    status: "",
                                    search: searchMenuController.text);
                              }
                            },
                            onEditingComplete: () {
                              debugPrint(
                                  'Search Complete: ${searchMenuController.text}');
                              restMenuController.getMenuListApi(
                                  status: "",
                                  search: searchMenuController.text);
                            },
                            style: TextStyle(
                              color: Color(BLACK),
                              fontSize: 16,
                              fontFamily: FontRoboto,
                              fontWeight: RobotoMedium,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GetBuilder<RestMenuController>(builder: (logic) {
                    return logic.isLoaderVisible
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : logic.restMenuModel.meta?.status == false
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text('No Menu Found'),
                              )
                            : Expanded(
                                child: Container(
                                  height: 210,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          logic.restMenuModel.data?.length,
                                      itemBuilder: (context, index) {
                                        int seriolNo = index + 1;
                                        debugPrint('Status: ${seriolNo}');

                                        return InkWell(
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
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                                  "Menu Image",
                                                                  Color(
                                                                      SUBTEXT),
                                                                  14),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.1,
                                                              height: 100,
                                                              child:
                                                              logic.restMenuModel.data?[index].menuImg?.isEmpty ==
                                                                  true ||
                                                                  logic.restMenuModel.data?[index]
                                                                      .menuImg! ==
                                                                      null
                                                                  ? Image.asset(
                                                                ic_no_image,
                                                                fit: BoxFit
                                                                    .fill,
                                                              )
                                                                  : imageFromNetworkCache(logic
                                                                  .restMenuModel
                                                                  .data?[index]
                                                                  .menuImg
                                                                  ?.first
                                                                  .toString() ??
                                                                  "",
                                                                  height: 100),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "S.No.: ",
                                                            Color(SUBTEXT),
                                                            14),
                                                    logic.restMenuModel.data
                                                                ?.length ==
                                                            0
                                                        ? Text('')
                                                        : WidgetText
                                                            .widgetPoppinsMediumText(
                                                                seriolNo
                                                                    .toString(),
                                                                Color(BLACK),
                                                                14),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
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
                                                                "Dish Name",
                                                                Color(SUBTEXT),
                                                                14),
                                                        WidgetText.widgetPoppinsMediumText(
                                                            logic
                                                                    .restMenuModel
                                                                    .data?[
                                                                        index]
                                                                    .dishName
                                                                    .toString() ??
                                                                "",
                                                            Color(BLACK),
                                                            14),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Price",
                                                                Color(SUBTEXT),
                                                                14),
                                                        WidgetText
                                                            .widgetPoppinsMediumText(
                                                                "\$${logic.restMenuModel.data?[index].price.toString() ?? ""}",
                                                                Color(BLACK),
                                                                14),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        WidgetText
                                                            .widgetPoppinsRegularText(
                                                                "Status ",
                                                                Color(SUBTEXT),
                                                                14),
                                                        WidgetText.widgetPoppinsMediumText(
                                                            logic
                                                                        .restMenuModel
                                                                        .data?[
                                                                            index]
                                                                        .status ==
                                                                    'DEACTIVE'
                                                                ? 'INACTIVE'
                                                                : logic
                                                                        .restMenuModel
                                                                        .data?[
                                                                            index]
                                                                        .status ??
                                                                    "",
                                                            Color(BLACK),
                                                            14),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              RestaurantMenuTabScreen(
                                                                menuId: logic
                                                                    .restMenuModel
                                                                    .data![
                                                                        index]
                                                                    .menuId
                                                                    .toString(),
                                                                isEditable:
                                                                    false,
                                                              ));
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color(ORANGE),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            "View details",
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
                                                          debugPrint(
                                                              'MenuId: ${logic.restMenuModel.data![index].menuId}');
                                                          await Get.to(() =>
                                                              RestaurantMenuTabScreen(
                                                                menuId: logic
                                                                    .restMenuModel
                                                                    .data![
                                                                        index]
                                                                    .menuId
                                                                    .toString(),
                                                                isEditable:
                                                                    true,
                                                              ));
                                                          restMenuController
                                                              .getMenuListApi(
                                                                  status: "",
                                                                  search: "");
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
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
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            "Edit details",
                                                            Color(ORANGE),
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    logic
                                                                .restMenuModel
                                                                .data?[index]
                                                                .isStatusUpdated ==
                                                            false
                                                        ? InkWell(
                                                            onTap: () async {
                                                              if (logic
                                                                      .restMenuModel
                                                                      .data?[
                                                                          index]
                                                                      .status ==
                                                                  "ACTIVE") {
                                                                await logic.callStatusUpdateAPI(
                                                                    menuId: logic
                                                                        .restMenuModel
                                                                        .data![
                                                                            index]
                                                                        .menuId
                                                                        .toString(),
                                                                    status:
                                                                        'DEACTIVE');
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
                                                                          .restMenuModel
                                                                          .data?[
                                                                              index]
                                                                          .setStatusUpdated = false;
                                                                    });
                                                                  }
                                                                }
                                                              } else {
                                                                await logic.callStatusUpdateAPI(
                                                                    menuId: logic
                                                                        .restMenuModel
                                                                        .data![
                                                                            index]
                                                                        .menuId
                                                                        .toString(),
                                                                    status:
                                                                        'ACTIVE');
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
                                                                          .restMenuModel
                                                                          .data?[
                                                                              index]
                                                                          .setStatusUpdated = false;
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                              setState(() {
                                                                if (logic
                                                                        .restMenuModel
                                                                        .data?[
                                                                            index]
                                                                        .status ==
                                                                    "ACTIVE") {
                                                                  logic
                                                                      .restMenuModel
                                                                      .data?[
                                                                          index]
                                                                      .setStatusUpdated = true;
                                                                } else {
                                                                  logic
                                                                      .restMenuModel
                                                                      .data?[
                                                                          index]
                                                                      .setStatusUpdated = true;
                                                                }
                                                                debugPrint(
                                                                    'checked:this ${logic.restMenuModel.data?[index].status}');
                                                              });
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
                                                                      color: logic.restMenuModel.data?[index].status ==
                                                                              "ACTIVE"
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
                                                                          .restMenuModel
                                                                          .data?[
                                                                              index]
                                                                          .status ==
                                                                      "ACTIVE"
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
                                                                              shape: BoxShape.rectangle,
                                                                              color: Color(GREENCOLORICON),
                                                                              borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
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
                                        );
                                      }),
                                ),
                              );
                  }),
                ],
              );
      })),
    );
  }

  onClickAddMenu() async {
    await Get.to(() => AddRestaurantTabScreen());
    restMenuController.getMenuListApi(status: "", search: "");
    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RestaurantTabScreen()));
  }
}
