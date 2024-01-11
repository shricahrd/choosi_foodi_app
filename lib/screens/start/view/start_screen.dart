import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/login/vendorLogin/vendor_data_model.dart';
import 'package:choosifoodi/screens/start/controller/start_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/utils/app_strings_constants.dart';

UserDataModel? userDataModel = null;
VendorDataModel? vendorDataModel = null;

class StartScreen extends GetView<StartController> {

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No', style: TextStyle(color: Colors.orange),),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            SystemNavigator.pop();
           },
          child: Text('Yes', style: TextStyle(color: Colors.orange),),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Color(WHITE),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    app_logo,
                    width: 50,
                    height: 50,
                  ),
                ),
                flex: 6,
              ),
              Expanded(
                child: GetBuilder<StartController>(
                builder: (logic) {
                  return
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(GREY),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          child:
                              WidgetButton.widgetOrangeButton(login, () {
                                logic.checkIsLogin();
                              }, fontSize: 20.0, buttonSize: 50.0),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WidgetText.widgetRobotoRegularText(
                              "Don’t Have an Account?",
                              Color(BLACK),
                              16,
                              align: TextAlign.end,
                            ),
                            TextButton(
                              child: WidgetText.widgetRobotoMediumText(
                                "Sign Up",
                                Color(ORANGE),
                                20,
                                align: TextAlign.end,
                              ),
                              onPressed: () {
                                logic.onClickSignUp();
                                // onClickSignUp
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
                ),
                flex: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}