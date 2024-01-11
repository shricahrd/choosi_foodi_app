import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../base_application/base_application.dart';
import '../../controller/group_order/group_orderdetails_controller.dart';

class TrackGroupOrderScreen extends StatefulWidget {
  String orderId = "";
  bool isGroupOrder = true;
  TrackGroupOrderScreen({required this.orderId, required this.isGroupOrder});

  @override
  _TrackGroupOrderScreenState createState() => _TrackGroupOrderScreenState(orderId, isGroupOrder);
}

class _TrackGroupOrderScreenState extends State<TrackGroupOrderScreen> {

  final GroupOrderDetailsController groupOrderDetailsController = Get.put(GroupOrderDetailsController());
  String orderId = "";
  bool isGroupOrder = true;

  _TrackGroupOrderScreenState(String orderId, bool isGroupOrder) {
    this.orderId = orderId;
    this.isGroupOrder = isGroupOrder;
  }

  dynamic orderStatus;
  bool trackStatus = false;
  int current_step = 3;
  String orderData = "";
  String createdDate = "";

  @override
  void initState() {
    debugPrint('isGroupOrder: $isGroupOrder');
    callApi();
    super.initState();
  }

  callApi() async {
    await groupOrderDetailsController.callViewOrderDetailsAPI(orderId);
    checkTrackStatus(groupOrderDetailsController.groupOrderDetailsModel.data?.orderStatus.toString() ?? "");
    print('OrderStatusFilter: ${groupOrderDetailsController.groupOrderDetailsModel.data?.orderStatus}');
  }

  checkTrackStatus(String orderStatus){
    if(orderStatus == "1"){
      setState((){
        orderData = "Order received";
        print('orderData: $orderData');
        current_step = 0;
        print('current_step: $current_step');
      });
    }else  if(orderStatus == "2"){
      setState((){
        orderData = "Being prepared";
        print('orderData: $orderData');
        current_step = 1;
        print('current_step: $current_step');
      });
    }else  if(orderStatus == "3"){
      setState((){
        // orderData = "Cooked";
        orderData = "Ready for Pickup";
        print('orderData: $orderData');
        current_step = 2;
        print('current_step: $current_step');
      });
    }else  if(orderStatus == "4"){
      setState((){
        // orderData = "Packed";
        orderData = "Picked Up";
        print('orderData: $orderData');
        current_step = 3;
        print('current_step: $current_step');
      });
    }/*else  if(orderStatus == "5"){
      setState((){
        orderData = "Shipped";
        print('orderData: $orderData');
        current_step = 2;
        print('current_step: $current_step');
      });
    }else  if(orderStatus == "6"){
      setState((){
        current_step = 3;
        print('current_step: $current_step');
      });
    }*/
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
          title: WidgetText.widgetPoppinsRegularText(
            "Order Received",
            Color(SUBTEXT),
            16,
          ),
          content: Text(''),
          isActive: current_step >= 0,
          state: current_step == 0 ? StepState.editing: StepState.complete
      ),
      Step(
          title: WidgetText.widgetPoppinsRegularText(
            'Being Prepared',
            Color(SUBTEXT),
            16,
          ),
          content: Text(''),
          isActive: current_step >= 1,
          state: current_step == 1 ? StepState.editing: StepState.complete
      ),
      Step(
          title: WidgetText.widgetPoppinsRegularText(
            // 'Out for Delivery',
            'Ready for Pickup',
            Color(SUBTEXT),
            16,
          ),
          content: Text(''),
          isActive: current_step >= 2,
          state: current_step == 2 ? StepState.editing: StepState.complete
      ),
      Step(
          title: WidgetText.widgetPoppinsRegularText(
            // 'Delivered',
            'Picked Up',
            Color(SUBTEXT),
            16,
          ),
          content: Text(''),
          isActive: current_step >= 3,
          state: current_step == 3 ? StepState.editing: StepState.complete
      ),
    ];
    return _steps;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isGroupOrder == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BaseApplication()),
                  (r) => false);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(WHITE),
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
                  onTap: () {
                    if(isGroupOrder == false){
                      Get.offAll(() => BaseApplication());
                    }
                  },
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
                  "Order Status",
                  Color(BLACK),
                  18,
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder<GroupOrderDetailsController>(builder: (logic) {
                    return logic.isViewOrderVisible
                        ? Center(
                        child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ))
                        : logic.groupOrderDetailsModel.meta?.status == false
                        ? Center(
                        child: Container(
                          child: Text('No Data Found'),
                        )): ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15),
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(WHITE),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Color(ORANGE), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                        "Date: ",
                                        Color(SUBTEXT),
                                        12,
                                      ),
                                      WidgetText.widgetPoppinsMediumText(
                                        logic.orderPlacedDate,
                                        Color(BLACK),
                                        12,
                                      ),
                                      Expanded(child: Container()),
                                      DotsIndicator(
                                        dotsCount: 1,
                                        position: 0,
                                        decorator: DotsDecorator(
                                          color: Colors.black87, // Inactive color
                                          activeColor: Color(ORANGE),
                                        ),
                                      ),
                                      WidgetText.widgetPoppinsMediumText(
                                        orderData,
                                        Color(ORANGE),
                                        12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  logic.groupOrderDetailsModel
                                      .data?.restaurantData?.restaurantImg.isEmpty == true
                                      ? Image.asset(
                                    ic_no_image,
                                    width: 80,
                                    height: 70,
                                    fit: BoxFit.fill,
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0),
                                    child: Image.network(
                                      logic.groupOrderDetailsModel
                                          .data?.restaurantData?.restaurantImg.first.toString() ?? "",
                                      width: 80,
                                      height: 70,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context,
                                          error, stackTrace) {
                                        return Image.asset(
                                          ic_no_image,
                                          width: 80,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WidgetText
                                            .widgetPoppinsMediumText(
                                          logic
                                              .groupOrderDetailsModel.data?.restaurantData?.restaurantName.toString() ?? "",
                                          Color(BLACK),
                                          16,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            WidgetText
                                                .widgetPoppinsRegularText(
                                              "Total : ",
                                              Color(ORANGE),
                                              14,
                                            ),
                                            logic.groupOrderDetailsModel.data
                                                ?.total ==
                                                null
                                                ? Text("")
                                                : WidgetText
                                                .widgetPoppinsMediumText(
                                              "\$" +
                                                  (logic
                                                      .groupOrderDetailsModel.data?.total.toStringAsFixed(2) ?? ""),
                                              Color(ORANGE),
                                              14,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // logic.getFilterGOModel[widget.index].

                                          WidgetText.widgetPoppinsRegularText(
                                            "Calories",
                                            Color(BLACK),
                                            13,
                                          ),
                                          WidgetText.widgetPoppinsMediumText(
                                            logic.groupOrderDetailsModel.data?.productDetails[0].cartMenu[0].caloriesTotal.toString() ?? "",
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
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF9F7F8),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                            "Fat",
                                            Color(BLACK),
                                            13,
                                          ),
                                        WidgetText.widgetPoppinsMediumText(
                                            ( logic.groupOrderDetailsModel.data?.productDetails[0].cartMenu[0].fatTotal.toString() ?? "") + "g",
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
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF9F7F8),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                            "Carbs",
                                            Color(BLACK),
                                            13,
                                          ),
                                         WidgetText.widgetPoppinsMediumText(
                                            ( logic.groupOrderDetailsModel.data?.productDetails[0].cartMenu[0].carbsTotal.toString() ?? "") + "g",
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
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF9F7F8),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          WidgetText.widgetPoppinsRegularText(
                                            "Protein",
                                            Color(BLACK),
                                            13,
                                          ),
                                           WidgetText.widgetPoppinsMediumText(
                                            ( logic.groupOrderDetailsModel.data?.productDetails[0].cartMenu[0].proteinTotal.toString() ?? "") + "g",
                                            Color(SUBTEXT),
                                            14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Theme(
                                  data: ThemeData(
                                    primarySwatch: Colors.orange,
                                    primaryTextTheme: TextTheme(
                                      caption: TextStyle(
                                        color: Color(SUBTEXT),
                                        fontSize: 16,
                                        fontFamily: FontPoppins,
                                        fontWeight: PoppinsRegular,
                                      ),
                                    ),
                                    colorScheme:
                                        ColorScheme.light(primary: Colors.orange),
                                  ),
                                  child: Stepper(
                                    controlsBuilder: (context, _) {
                                      return Container();
                                    },
                                    currentStep: this.current_step,
                                    steps: _mySteps(),
                                    // steps: steps,
                                    type: StepperType.vertical,
                                    onStepTapped: (step) {
                                      setState(() {
                                      });
                                    },
                                    onStepContinue: () {
                                    },
                                    onStepCancel: () {
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
          }),
        ),
      ),
    );
  }
}
