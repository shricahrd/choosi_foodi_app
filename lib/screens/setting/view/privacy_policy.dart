import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../controller/about_us_controller.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  final AboutUsController aboutUsController = Get.put(AboutUsController());

  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      callApi();
    }
    super.initState();
  }

  callApi(){
    setState(() {
      aboutUsController.isLoaderVisiblePP = true;
    });
    aboutUsController.callPrivacyPolicyAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context, "Privacy Policy",  false),
      body:  SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder<AboutUsController>(builder: (logic) {
              return logic.isLoaderVisiblePP
                  ? Center(
                  child: CircularProgressIndicator(
                    color: Color(ORANGE),
                  ))
                  : logic.aboutUsModel.meta?.status == false
                  ? Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Privacy Policy Not Available'),
                  ))
                  : ListView(
                          padding: EdgeInsets.all(15),
                          physics: BouncingScrollPhysics(),
                          children: [
                            WidgetText.widgetPoppinsRegularText(
                              logic.aboutUsModel.data?.description.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? "",
                              Color(BLACK),
                              12,
                            )
                          ],
                        );
            });
          }))
    );
  }
}
