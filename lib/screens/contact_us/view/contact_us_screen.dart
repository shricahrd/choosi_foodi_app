import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../../model/login/user_data_model.dart';
import '../controller/contact_us_controller.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final ContactUsGetController contactUsController =
      Get.put(ContactUsGetController());

  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  late UserDataModel userDataModel;

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      contactUsController.callGetContactInfoAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context,"Contact Us",false ),
        body: SafeArea(
            child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<ContactUsGetController>(
                  builder: (logic) {
                    return logic.isLoaderVisible
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : ListView(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            physics: BouncingScrollPhysics(),
                            children: [
                              Card(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 7.5),
                                elevation: 5.0,
                                shadowColor: Color(BLACK),
                                child:
                                    logic.contactInfoModel.meta?.status == false
                                        ? Container(
                                            child: Text('No Contacts Found'),
                                          )
                                        : Container(
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 15, 15, 0),
                                                  child: WidgetText
                                                      .widgetPoppinsRegularText(
                                                          "Email",
                                                          Color(0xff575757),
                                                          16),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 5, 15, 15),
                                                  child: logic.contactInfoModel.data
                                                              ?.email ==
                                                          null
                                                      ? WidgetText
                                                          .widgetPoppinsMediumText(
                                                              "info@choosifoodi.com",
                                                              Color(BLACK),
                                                              16)
                                                      : WidgetText
                                                          .widgetPoppinsMediumText(
                                                              logic
                                                                  .contactInfoModel
                                                                  .data!
                                                                  .email
                                                                  .toString(),
                                                              Color(BLACK),
                                                              16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                           /*     Divider(
                                                  color: Color(LIGHTDIVIDERCOLOR),
                                                  height: 2,
                                                  thickness: 2,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 15, 15, 0),
                                                  child: WidgetText
                                                      .widgetPoppinsRegularText(
                                                          "Phone number",
                                                          Color(0xff575757),
                                                          16),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 5, 15, 15),
                                                  child: logic.contactInfoModel
                                                              .data?.mobile ==
                                                          null
                                                      ? WidgetText
                                                          .widgetPoppinsMediumText(
                                                              "+91 9966554488",
                                                              Color(BLACK),
                                                              16)
                                                      : WidgetText
                                                          .widgetPoppinsMediumText(
                                                              logic
                                                                  .contactInfoModel
                                                                  .data!
                                                                  .mobile
                                                                  .toString(),
                                                              Color(BLACK),
                                                              16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),*/
                                              ],
                                            ),
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 7.5, 0, 0),
                                child: WidgetText.widgetPoppinsMediumText(
                                  "Contact Us",
                                  Color(BLACK),
                                  18,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: WidgetText.widgetPoppinsRegularText(
                                  sendMsg,
                                  Color(0xff646161),
                                  14,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              customTextInputField(
                                  nameController,
                                  "Enter your name",
                                  "Name*",
                                  TextInputType.text,
                                  TextInputAction.next,
                                  1),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                  emailController,
                                  "Enter your email",
                                  "Email*",
                                  TextInputType.emailAddress,
                                  TextInputAction.next,
                                  1),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                  messageController,
                                  "Enter your message",
                                  "Message*",
                                  TextInputType.text,
                                  TextInputAction.done,
                                  3),
                              SizedBox(
                                height: 20,
                              ),
                              contactUsController.isMessageSend == false
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 15),
                                      child: WidgetButton.widgetDefaultButton(
                                          "Send", () async {
                                        bool emailValid =
                                            RegExp(r'\S+@\S+\.\S+')
                                                .hasMatch(emailController.text);
                                        mobileController.text = logic
                                            .contactInfoModel.data!.mobile
                                            .toString();

                                        if (nameController.text.isNotEmpty &&
                                            emailController.text.isNotEmpty &&
                                            messageController.text.isNotEmpty) {
                                          if (emailValid == true) {
                                            setState(() {
                                              contactUsController
                                                  .isMessageSend = true;
                                            });
                                            await contactUsController
                                                .postContactUs(
                                                    email: emailController
                                                        .text
                                                        .toString(),
                                                    message:
                                                        messageController
                                                            .text
                                                            .toString(),
                                                    name:
                                                        nameController
                                                            .text
                                                            .toString(),
                                                    mobile: mobileController
                                                        .text
                                                        .toString());

                                            if (contactUsController
                                                    .isMessageSend ==
                                                true) {
                                              setState(() {
                                                contactUsController
                                                    .isMessageSend = false;
                                                Get.back();
                                              });
                                            } else {
                                              setState(() {
                                                contactUsController
                                                    .isMessageSend = false;
                                              });
                                            }
                                          } else {
                                            showToastMessage(
                                                plzEnterProperEmailMsg);
                                          }
                                        } else {
                                          showToastMessage(
                                              'Please enter all required fields.');
                                        }
                                      }),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Color(ORANGE),
                                      ),
                                    ),
                            ],
                          );
                  },
                );
        })));
  }
}

Widget customTextInputField(
    TextEditingController editingController,
    String hintText,
    String lableText,
    TextInputType? keyboardType,
    TextInputAction action,
    int maxLine) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText.widgetPoppinsMediumText(
          lableText,
          Color(0xff676767),
          14,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Color(LIGHTGREYCOLORICON)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: TextFormField(
            maxLines: maxLine,
            controller: editingController,
            textAlign: TextAlign.start,
            textInputAction: action,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
              hintText: "",
            ),
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontPoppins,
              fontWeight: PoppinsRegular,
            ),
          ),
        )
      ],
    ),
  );
}
