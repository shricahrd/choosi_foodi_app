import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/faq_controller.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedIndex = -1;

  // foodiFactController
  final FAQController faqController = Get.put(FAQController());

  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      faqController.callGetFaqListAPI();
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
              WidgetText.widgetPoppinsRegularText(
                "FAQ's",
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
              : GetBuilder<FAQController>(builder: (logic) {
                  return logic.isLoaderVisible
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ))
                      : logic.faqListModel.meta?.status == false
                          ? Center(
                              child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text('Faq List Not Available'),
                            ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: WidgetText.widgetPoppinsMediumText(
                                    "We are happy to help",
                                    Color(ORANGE),
                                    18,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  color: Color(LIGHTDIVIDERCOLOR),
                                  height: 2,
                                  thickness: 2,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: logic.faqListModel.data?.length,
                                    itemBuilder: (context, index) {
                                      // bool showDetail = true;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (selectedIndex == index) {
                                                  selectedIndex = -1;
                                                } else {
                                                  selectedIndex = index;
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:
                                                logic.faqListModel.data?[index].question == null ? Text(''):
                                                    WidgetText
                                                        .widgetPoppinsMediumText(
                                                      logic.faqListModel.data![index].question.toString(),
                                                      Color(BLACK),
                                                      16,
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    // showDetail == true
                                                    index == selectedIndex
                                                        ? ic_down_arrow
                                                        : ic_left_side_arrow,
                                                    height: 15,
                                                    color: Color(ORANGE),
                                                    width: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          // showDetail == true
                                          index == selectedIndex
                                              ? Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 10, 15, 0),
                                                  child:
                                            logic.faqListModel.data?[index].answer == null ? Text(''):
                                            WidgetText
                                                .widgetPoppinsMediumText(logic.faqListModel.data![index].answer.toString(),
                                              Color(SUBTEXT),
                                              13,
                                            ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Color(DIVIDERCOLOR)),
                                        ],
                                      );
                                    },
                                  ),
                                  flex: 1,
                                  fit: FlexFit.tight,
                                ),
                              ],
                            );
                });
        }),
      ),
    );
  }
}
