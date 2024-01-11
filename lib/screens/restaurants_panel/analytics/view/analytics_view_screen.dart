import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../../restaurant_menu/view/restaurant_tab_screen.dart';
import '../controller/analytics_controller.dart';

class RestaurantAnalytics extends StatefulWidget {
  @override
  State<RestaurantAnalytics> createState() => _RestaurantAnalyticsState();
}

class _RestaurantAnalyticsState extends State<RestaurantAnalytics> {
  TextEditingController textInputField = TextEditingController();
  double fontSize = 13;
  AnalyticsRestController _analyticsRestController =
      Get.put(AnalyticsRestController());

  @override
  void initState() {
    callApi("");
    super.initState();
  }

  callApi(String search) {
    _analyticsRestController.callApi(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Analytics", true),
      body: Container(
        child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<AnalyticsRestController>(builder: (logic) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: textInputField,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(GREY1),
                                  fontSize: 14,
                                  fontFamily: FontPoppins,
                                  fontWeight: PoppinsRegular,
                                ),
                                hintText: "Search by dish",
                              ),
                              onChanged: (data){
                                callApi(data);
                              },
                              style: TextStyle(
                                color: Color(BLACK),
                                fontSize: 14,
                                fontFamily: FontPoppins,
                                fontWeight: PoppinsRegular,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: WidgetButton.widgetDefaultButton(
                              export_excel, (){
                                if(logic.analyticsModel.data?.isNotEmpty == true){
                                  logic.createExcel();
                                }
                          }),
                        ),
                        Expanded(
                          child: logic.isLoaderVisible
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Color(ORANGE),
                                ))
                              : logic.analyticsModel.meta?.status == false ||
                                      logic.analyticsModel.data?.isEmpty == true
                                  ? Center(
                                      child: Container(
                                        child: Text('Analytics List Not Found'),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          logic.analyticsModel.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                if(logic.analyticsModel.data?[index].menuId != null) {
                                                  Get.to(() =>
                                                      RestaurantMenuTabScreen(
                                                        menuId: logic
                                                            .analyticsModel
                                                            .data?[index]
                                                            .menuId
                                                            .toString() ?? "",
                                                        isEditable:
                                                        false,
                                                      ));
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2.8,
                                                        height: 120,
                                                        child: logic
                                                                    .analyticsModel
                                                                    .data?[index]
                                                                    .menuImg
                                                                    .isEmpty ==
                                                                true
                                                            ? imageFromNetworkCache(
                                                                "",
                                                                height: 120)
                                                            : imageFromNetworkCache(
                                                                logic
                                                                        .analyticsModel
                                                                        .data?[
                                                                            index]
                                                                        .menuImg
                                                                        .first ??
                                                                    "",
                                                                height: 120),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      flex: 6,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                                  "Dish Name",
                                                                  Color(GREY3),
                                                                  fontSize),
                                                          WidgetText
                                                              .widgetPoppinsMediumOverflowText(
                                                            logic
                                                                    .analyticsModel
                                                                    .data?[index]
                                                                    .dishName ??
                                                                "",
                                                            Color(BLACK2),
                                                            fontSize,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                                  "Total Sale Quantity",
                                                                  Color(GREY3),
                                                                  fontSize),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetText.widgetPoppinsMediumText(
                                                              logic
                                                                      .analyticsModel
                                                                      .data?[
                                                                          index]
                                                                      .totalSale
                                                                      .toString() ??
                                                                  "",
                                                              Color(BLACK2),
                                                              fontSize),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Divider(
                                                color: Color(DARKGREY),
                                                height: 1,
                                                thickness: 0,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                        )
                      ],
                    ),
                  );
                });
        }),
      ),
    );
  }
}
