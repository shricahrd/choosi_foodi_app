import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_font_utils.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/add_restaurnt_controller.dart';
import '../restaurant_welcome_screen.dart';

class BankRestInfo extends StatefulWidget {
  dynamic mobile;
   BankRestInfo({Key? key, required this.mobile}) : super(key: key);

  @override
  State<BankRestInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankRestInfo> {
  final VendorAddRestaurantController vendorAddRestaurantController = Get.put(VendorAddRestaurantController());

  @override
  void initState() {
   print('cordinates : ${vendorAddRestaurantController.cordinates}');
   vendorAddRestaurantController.checkGps();
    updateBool();
   vendorAddRestaurantController.isAddRestaurant = false;
   super.initState();
  }

  updateBool(){
    print('updateBool');
    print('image: ${vendorAddRestaurantController.restImageFile}');
  }

  @override
  Widget build(BuildContext context) {

    // vendorAddRestaurantController.isAddRestaurant = false;

    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 20,),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child:
                GetBuilder<VendorAddRestaurantController>(builder: (logic) {

                 return Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        customTextInputField(
                          logic.accHolderNameCtr,
                          "Account Holder", TextInputType.text,
                          TextInputAction.next,
                          true
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.bankNameCtr,
                          "Bank", TextInputType.text,
                          TextInputAction.next,
                          true
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.branchNameCtr,
                          "Bank Branch", TextInputType.text,
                          TextInputAction.next,
                          true
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.accNoCtr,
                          "Account Number", TextInputType.number,
                          TextInputAction.next,
                          false, true
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.routingNoCtr,
                          "Routing Number", TextInputType.number,
                          TextInputAction.next,
                          false, true
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
       /*                 SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.abaNoCtr,
                          "Enter ABA Number",
                          "ABA Number", TextInputType.text,
                          TextInputAction.done,
                        ),
                        Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),*/
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            logic.isAddRestaurant == false ?
                            InkWell(
                              onTap: () async {
                                print('loadRestImage: ${logic.loadRestImage}');
                                print('loadRestImage: ${logic.restFileList}');
                                if (logic.loadRestImage == true) {
                                  Map<String, String> params = <String, String>{
                                    HttpConstants.PARAMS_MOBILE: widget.mobile,
                                    HttpConstants.PARAMS_REST_NAME: logic.restNameCtr.text,
                                    HttpConstants.PARAMS_REST_ADDRESS: logic.restAddressCtr.text,
                                    HttpConstants.PARAMS_REST_EMAIL: logic.restEmailCtr.text,
                                    HttpConstants.PARAMS_REST_MANAGER_NAME: logic.ownerNameCtr.text,
                                    HttpConstants.PARAMS_REST_MANAGER_MOBILE: logic.ownerNoCtr.text,
                                    HttpConstants.PARAMS_BANKNAME: logic.bankNameCtr.text,
                                    HttpConstants.PARAMS_BRANCHNAME: logic.branchNameCtr.text,
                                    HttpConstants.PARAMS_ACCNO: logic.accNoCtr.text,
                                    HttpConstants.PARAMS_HOLDERNAME: logic.accHolderNameCtr.text,
                                    HttpConstants.PARAMS_ROUTINGNO: logic.routingNoCtr.text,
                                    HttpConstants.PARAMS_REST_DELIVERYTIME: logic.restDeliveryTimeCtr.text.toString(),
                                    HttpConstants.PARAMS_CORDINATES: logic.cordinates,
                                    HttpConstants.PARAMS_IS_PROFILE_COMPLETE: "true",
                                  };
                                  print('Params: ${params}');
                                  print('ImageFile: ${logic.restFileList}');
                                  setState(() {
                                    logic.isAddRestaurant = true;
                                  });
                                  await logic
                                      .addRestaurantApi(params: params,
                                    imageKey1: HttpConstants.PARAMS_RESTAURANTIMG,
                                    imageFile: logic.restFileList
                                  );
                                  if (logic.addRestaurantModel.meta?.status == true) {
                                    setState(() {
                                      logic.isAddRestaurant = false;
                                      Get.offAll(() => RestaurantWelcomeScreen());
                                    });
                                  }
                                }else{
                                  showToastMessage('Please Add Restaurant Image first');
                                }

                                // Get.offAll(() => RestaurantWelcomeScreen());
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                  color: Color(ORANGE),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                                ),
                                alignment: Alignment.center,
                                child: WidgetText.widgetPoppinsMediumText(
                                  "Submit",
                                  Color(WHITE),
                                  14,
                                ),
                              ),
                            )
                            : Center(child: CircularProgressIndicator(color: Color(ORANGE),),),

                            SizedBox(
                              width: 10,
                            ),

                            InkWell(
                              onTap: () {
                                logic.accHolderNameCtr.clear();
                                logic.bankNameCtr.clear();
                                logic.branchNameCtr.clear();
                                logic.routingNoCtr.clear();
                                logic.accNoCtr.clear();
                                logic.restEmailCtr.clear();
                                logic.restAddressCtr.clear();
                                logic.restDeliveryTimeCtr.clear();
                                logic.restFileList.clear();
                                logic.restNameCtr.clear();
                                logic.ownerController.clear();
                                logic.ownerNameCtr.clear();
                                logic.ownerNoCtr.clear();
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Color(ORANGE), width: 1),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                  );
                })
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String lableText, TextInputType? keyboardType, TextInputAction? textInputAction,
      [bool name = false, bool isMobile = false]) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        color: Color(WHITE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: TextFormField(
        controller: editingController,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] :
        isMobile ? [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ] : [],
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: lableText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontRoboto,
            fontWeight: RobotoRegular,
          ),
        ),
        style: TextStyle(
          color: Color(BLACKINPUT),
          fontSize: 18,
          fontFamily: FontRoboto,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}
