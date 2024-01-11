import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_round_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/group_order_controller.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'add_group_user_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  String restaurantId;
  dynamic isPickupAvail;
  List cordinates;

  CreateGroupScreen({required this.restaurantId, required this.isPickupAvail, required this.cordinates});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController spendingLimitController = TextEditingController();
  String address1 = "", address2 = "";
  int _paymentType = 1;
  String orderType = "DELIVERY";
  final GroupOrderController groupOrderController = Get.put(GroupOrderController());
  List<Contact>? contacts;
  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void initState() {
    getAddressData();
    debugPrint('RestId : ${widget.restaurantId}');
    debugPrint('cordinates : ${widget.cordinates}');
    debugPrint('Rest isPickupAvail : ${widget.isPickupAvail}');
    super.initState();
  }

  getAddressData() async {
    address1 = (await AppPreferences.getAddress1())!;
    address2 = (await AppPreferences.getAddress2())!;
    debugPrint('address1: $address1, address2: $address2');
    if(address1 == "" && address1 == null){
      showToastMessage('Please Set the address first');
      debugPrint('Address1: $address1');
    }else{
      debugPrint('Address1 else: $address1');
    }
    setState(() {});
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
                    "Create Group Order",
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
        child:
        GetBuilder<GroupOrderController>(builder: (logic) {
          return SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(20),
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          "Add group name",
                          Color(BLACK),
                          20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customTextInputField(
                            groupNameController, "Enter group name",
                            "", TextInputType.text),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _paymentType = 1;
                                  orderType = "DELIVERY";
                                  debugPrint('orderType: $orderType');
                                });
                              },
                              child: _paymentType == 1
                                  ? WidgetRoundRadioButton
                                  .selectRadioButton("Delivery")
                                  : WidgetRoundRadioButton
                                  .unselectedRadioButton("Delivery", Color(ORANGE)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            widget.isPickupAvail == true?
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                 if(widget.isPickupAvail == true) {
                                   _paymentType = 2;
                                   orderType = "PICKUP";
                                   debugPrint('orderType: $orderType');
                                 }
                                });
                              },
                              child: _paymentType == 2
                                  ? WidgetRoundRadioButton
                                  .selectRadioButton("Pickup")
                                  : WidgetRoundRadioButton
                                    .unselectedRadioButton("Pickup", Color(ORANGE)),
                            ) : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ic_location_pin,
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: WidgetText.widgetPoppinsRegularText(
                                address1 + ", " + address2,
                                // "121 Vegan Avue, Columbus, OH 43258",
                                Color(BLACK),
                                14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customTextInputField(spendingLimitController,
                            "Enter spending limit", "", TextInputType.number),
                        SizedBox(
                          height: 20,
                        ),
                          logic.isAddGroupPosted ?
                          Center(
                              child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              )) :
                          Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                            ),
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: WidgetButton.widgetDefaultButton(
                                "Create", () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                            if(_networkController.connectionType != 0) {
                              if (groupNameController.text.isNotEmpty) {
                                if (spendingLimitController.text.isNotEmpty) {
                                  late Map<String, dynamic> params;
                                  late dynamic mapParams;

                                  params = <String, dynamic>{
                                    HttpConstants.PARAMS_RESTID: widget.restaurantId,
                                    HttpConstants.PARAMS_GROUPNAME: groupNameController.text,
                                    HttpConstants.PARAMS_ORDERTYPE: orderType,
                                    HttpConstants.PARAMS_SPENDING_LIMIT: spendingLimitController.text,
                                    HttpConstants.PARAMS_ADDRESS: address1 + ", " + address2,
                                  };
                                  if(orderType == 'DELIVERY') {
                                    params[HttpConstants.PARAMS_CORDINATES] = widget.cordinates;
                                  }
                                  mapParams = jsonEncode(params);
                                  debugPrint('MapParams: $mapParams');
                                  debugPrint('Params: $params');
                                  await logic.callAddGroupApi(params: mapParams);
                                  if (logic.addGroupModel.meta?.status == true) {
                                    setState(() {
                                      // logic.isAddGroupPosted = false;
                                      var groupId = logic.addGroupModel.data
                                          ?.groupId;
                                      debugPrint('GroupId: $groupId');
                                      if (groupId != null) {
                                        Get.to(() =>
                                            AddGroupScreen(
                                              isViewGroup: false,
                                              groupName: groupNameController
                                                  .text, groupId: groupId, restaurantId: widget.restaurantId,));
                                      }
                                    });
                                  }
                                } else {
                                  showToastMessage(
                                      'Please Add Spending Limit');
                                }
                              } else {
                                showToastMessage('Please Add Group Name');
                              }
                            }else{
                              showToastMessage(check_internet);
                            }
                              // Get.to(()=>  AddGroupScreen(groupName: groupNameController.text,groupId: '62de267879d7a2fe7eb2011b',));
                            }),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          );
        }
        ),
      ),
    );
  }

  Widget customTextInputField(TextEditingController controller, String hintText,
      String lableText, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
        color: Color(WHITE),
        shape: BoxShape.rectangle,
        border: Border.all(color: Color(BLACK), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(LIGHTERHINTCOLOR),
            fontSize: 16,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
          hintText: hintText,
        ),
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
        ),
      ),
    );
  }
}
