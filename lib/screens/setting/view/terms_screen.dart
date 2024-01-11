import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../controller/terms_controller.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final TermsController _termsController = Get.put(TermsController());
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
    _termsController.isLoaderVisible = true;
    _termsController.callTermsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Terms & Conditions",  false),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<TermsController>(builder: (logic) {
                return logic.isLoaderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.termsModel.meta?.status == false
                        ? Center(
                            child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child:
                                    Text('Terms and Conditions Not Available')))
                        : ListView(
                            padding: EdgeInsets.all(15),
                            physics: BouncingScrollPhysics(),
                            children: [
                              WidgetText.widgetPoppinsRegularText(
                                logic.termsModel.data?.description.replaceAll(
                                    RegExp(r'<[^>]*>|&[^;]+;'),
                                    ' ') ?? "",
                                Color(BLACK),
                                12,
                              )
                            ],
                          );
              });
      })),
    );
  }
}

