import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/controller/restaurant_mobile_controller.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/tabs/signup_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../routes/all_routes.dart';

class RestaurantMobileNoScreen extends StatefulWidget {
  @override
  State<RestaurantMobileNoScreen> createState() =>
      _RestaurantMobileNoScreenState();
}

class _RestaurantMobileNoScreenState extends State<RestaurantMobileNoScreen> {
  final RestaurantMobileController restaurantMobileController =
      Get.put(RestaurantMobileController());

//   final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void initState() {
    restaurantMobileController.isLoaderVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    restaurantMobileController.isLoaderVisible = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: GetBuilder<RestaurantMobileController>(builder: (logic) {
          return appLoader(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.offAllNamed(AllRoutes.start);
                      },
                      child: Image.asset(
                        ic_right_side_arrow,
                        width: 25,
                        color: Color(ORANGE),
                        height: 20,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            app_icon,
                            width: 35,
                            height: 35,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          WidgetText.widgetRobotoMediumText(
                            "Sign Up",
                            Color(ORANGE),
                            28,
                            align: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                    flex: 3,
                    fit: FlexFit.tight,
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                          color: Color(GREY),
                        ),
                        child: customTextInputField(
                            logic.mobileController,
                            "Enter Mobile Number",
                            "Mobile",
                            TextInputType.number),
                      ),
                    ),
                    flex: 3,
                    fit: FlexFit.tight,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 30),
                            child: WidgetButton.widgetDefaultButton("Next",
                                () async {
                              if (_networkController.connectionType != 0) {
                                if (logic.mobileController.text.isNotEmpty) {
                                  if (logic.mobileController.length == 10) {
                                    // Get.to(() => RestaurantOTPVerifyScreen(mobile: logic.mobileController.text, ),);
                                    logic.callMobileVerifyAPI(
                                        mobile:
                                            "${logic.mobileController.text}");
                                  } else {
                                    showToastMessage(
                                        "Please enter 10 digit mobile number");
                                  }
                                } else {
                                  showToastMessage(
                                      "Please enter mobile number");
                                }
                              } else {
                                showToastMessage(check_internet);
                              }
                            })),
                      ],
                    ),
                    flex: 6,
                    fit: FlexFit.tight,
                  )
                ],
              ),
              isLoading: !logic.isLoaderVisible);
        }),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(40, 20, 40, 2),
          child: WidgetText.widgetRegularText(
            lableText,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 2, 40, 10),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon: Text("+1",
                  style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 16,
                    fontFamily: FontRoboto,
                    fontWeight: RobotoMedium,
                  )),
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontRoboto,
              fontWeight: RobotoMedium,
            ),
          ),
        )
      ],
    );
  }
}
