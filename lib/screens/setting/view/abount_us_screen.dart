import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../controller/about_us_controller.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());

  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      aboutUsController.callAboutUsAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context,"About Us",false ),
        body: SafeArea(
            child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<AboutUsController>(builder: (logic) {
                  return logic.isLoaderVisible
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ))
                      : logic.aboutUsModel.meta?.status == false
                          ? Center(
                              child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text('About Us Not Available'),
                            ))
                          : ListView(
                              padding: EdgeInsets.all(15),
                              physics: BouncingScrollPhysics(),
                              children: [
                                WidgetText.widgetPoppinsMediumText(
                                  logic.aboutUsModel.data?.title ?? "",
                                  Color(BLACK),
                                  18,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                  logic.aboutUsModel.data?.description.replaceAll(
                                      RegExp(r'<[^>]*>|&[^;]+;'),
                                      ' ') ?? "",
                                  Color(BLACK),
                                  12,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                           /*     WidgetText.widgetPoppinsMediumText(
                                  "Choosi Foodi's Mission",
                                  Color(BLACK),
                                  18,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                                  Color(BLACK),
                                  12,
                                ),
                                SizedBox(
                                  height: 15,
                                ),*/
                              ],
                            );
                });
        })));
  }
}
