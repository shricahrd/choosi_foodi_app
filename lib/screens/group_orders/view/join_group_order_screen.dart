import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../restaurant_details/view/restaurant_details_screen.dart';
import '../controller/join_group_order_controller.dart';

class JoinGroupOrderScreen extends StatefulWidget {
  String groupId;

  JoinGroupOrderScreen(this.groupId);

  @override
  _JoinGroupOrderScreenState createState() => _JoinGroupOrderScreenState();
}

class _JoinGroupOrderScreenState extends State<JoinGroupOrderScreen> {
  final JoinGroupOrderController joinGroupOrderController =
      Get.put(JoinGroupOrderController());
  final _networkController = Get.find<GetXNetworkManager>();
  dynamic userId;

  @override
  void initState() {
    if (_networkController.connectionType != 0) {
      joinGroupOrderController.callGroupOrderDetailsAPI(
          groupId: widget.groupId);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
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
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Join group order",
                  Color(BLACK),
                  18,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<JoinGroupOrderController>(builder: (logic) {
                return logic.isGroupDetailsVisible
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ),
                      )
                    : Container(
                        child: Card(
                          margin: EdgeInsets.all(20),
                          color: Color(WHITE),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                            ),
                            // height: double.infinity,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              // physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      app_icon,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: WidgetText.widgetPoppinsMediumText(
                                      "Join Group Order?",
                                      Color(BLACK),
                                      22,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: WidgetText.widgetPoppinsRegularText(
                                        "When you join the order you can\nadd any item, all items will be\ndelivered together.",
                                        Color(SUBTEXT),
                                        16,
                                        align: TextAlign.center),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    alignment: Alignment.topLeft,
                                    child: WidgetText.widgetPoppinsMediumText(
                                        "Details", Color(BLACK), 18,
                                        align: TextAlign.start),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    alignment: Alignment.topLeft,
                                    child: logic.groupDetailsModel.data
                                                ?.restaurantName ==
                                            null
                                        ? Text('Order From  :')
                                        : WidgetText.widgetPoppinsRegularText(
                                            "Order From  :  " +
                                                logic.groupDetailsModel.data!
                                                    .restaurantName
                                                    .toString(),
                                            Color(BLACK),
                                            16,
                                            align: TextAlign.start),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    alignment: Alignment.topLeft,
                                    child: logic.groupDetailsModel.data
                                                ?.address ==
                                            ""
                                        ? Text('Delivery to :')
                                        : WidgetText.widgetPoppinsRegularText(
                                            "Delivery to :  " +
                                                logic.groupDetailsModel.data!
                                                    .address
                                                    .toString(),
                                            Color(BLACK),
                                            16,
                                            align: TextAlign.start),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    alignment: Alignment.topLeft,
                                    child: logic.groupDetailsModel.data
                                                ?.spendingLimit ==
                                            null
                                        ? Text('Spending Limit :')
                                        : WidgetText.widgetPoppinsRegularText(
                                            "Spending Limit : \$" +
                                                logic.groupDetailsModel.data!
                                                    .spendingLimit
                                                    .toString(),
                                            Color(BLACK),
                                            16,
                                            align: TextAlign.start),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  logic.isLoaderVisible == false
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Color(WHITE),
                                          ),
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 20),
                                          child:
                                              WidgetButton.widgetDefaultButton(
                                                  "Join group order", () async {
                                            await logic.callJoinGroupApi(groupId:  widget.groupId);
                                            if (logic.deleteCartModel.meta
                                                    ?.status ==
                                                true) {
                                              setState(() {
                                                RestaurantDetailsScreen
                                                    .setIsGroupOrder(true);
                                                // FoodDetailScreen.setIsGroupOrder(true);
                                                Get.offAll(() =>
                                                    RestaurantDetailsScreen(
                                                      restaurantid: logic.restId,
                                                    ));
                                              });
                                            }
                                          }),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                          color: Color(ORANGE),
                                        ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              });
      })),
    );
  }
}
