import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_font_utils.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/profile_rest_controller.dart';
import '../../controller/update_rest_profile_controller.dart';

class BankInfo extends StatefulWidget {
  Function moveToCategoryTab;

  BankInfo({Key? key, required this.moveToCategoryTab}) : super(key: key);

  @override
  State<BankInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  final VendorProfileGetController vendorProfileGetController =
      Get.put(VendorProfileGetController());
  final UpdateRestProfileController updateRestProfileController =
      Get.put(UpdateRestProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child:
                    GetBuilder<GetXNetworkManager>(builder: (networkManager) {
                  return networkManager.connectionType == 0
                      ? Center(child: Text(check_internet))
                      : Container(
                          padding: EdgeInsets.all(25),
                          width: double.infinity,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              WidgetText().customTextInputField2(
                                  vendorProfileGetController.bankNameCtr,
                                  bank, TextInputType.text,
                                  TextInputAction.next,
                                  true
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                           /*   WidgetText().customTextInputField2(
                                  vendorProfileGetController.branchNameCtr,
                                  bankBranch, TextInputType.text,
                                  TextInputAction.next,
                                  true
                              ),*/
                              customTextInputField(
                                vendorProfileGetController.branchNameCtr,
                                bankBranch,
                                TextInputType.text,
                                TextInputAction.next,
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              WidgetText().customTextInputField2(
                                  vendorProfileGetController.accHolderNameCtr,
                                  accountHolder, TextInputType.text,
                                  TextInputAction.next,
                                  true
                              ),
                              // customTextInputField(
                              //   vendorProfileGetController.accHolderNameCtr,
                              //   accountHolder,
                              //   TextInputType.text,
                              //   TextInputAction.next,
                              // ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              WidgetText().customTextInputField2(
                                  vendorProfileGetController.accNoCtr,
                                  accountNumber, TextInputType.number,
                                  TextInputAction.next,
                                  false, true
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                vendorProfileGetController.routingNoCtr,
                                routingNumber,
                                TextInputType.text,
                                TextInputAction.next,
                              ),
                           /*   Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                vendorProfileGetController.abaNoCtr,
                                "Enter ABA Number",
                                "ABA Number",
                                TextInputType.text,
                                TextInputAction.done,
                              ),*/
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  updateRestProfileController.isLoaderVisible ==
                                          false
                                      ? InkWell(
                                          onTap: () async {
                                            if (vendorProfileGetController
                                                    .accHolderNameCtr
                                                    .text
                                                    .isNotEmpty &&
                                                vendorProfileGetController
                                                    .bankNameCtr
                                                    .text
                                                    .isNotEmpty &&
                                                vendorProfileGetController
                                                    .branchNameCtr
                                                    .text
                                                    .isNotEmpty &&
                                                vendorProfileGetController
                                                    .routingNoCtr
                                                    .text
                                                    .isNotEmpty &&
                                                vendorProfileGetController
                                                    .accNoCtr.text.isNotEmpty) {
                                              setState(() {
                                                updateRestProfileController
                                                    .isLoaderVisible = true;
                                              });
                                              final params = jsonEncode({
                                                "bankInformation": {
                                                  HttpConstants.PARAMS_ACCNO:
                                                      vendorProfileGetController
                                                          .accNoCtr.text,
                                                  HttpConstants.PARAMS_BANKNAME:
                                                      vendorProfileGetController
                                                          .bankNameCtr.text,
                                                  HttpConstants
                                                          .PARAMS_BRANCHNAME:
                                                      vendorProfileGetController
                                                          .branchNameCtr.text,
                                                  HttpConstants
                                                          .PARAMS_HOLDERNAME:
                                                      vendorProfileGetController
                                                          .accHolderNameCtr
                                                          .text,
                                                  HttpConstants
                                                          .PARAMS_ROUTINGNO:
                                                      vendorProfileGetController
                                                          .routingNoCtr.text,
                                                }
                                              });
                                              print('Params: ${params}');

                                              await updateRestProfileController
                                                  .updateProfileApi(
                                                      params: params,
                                                      image: false,
                                                      imageKey1: "");

                                              if (updateRestProfileController
                                                      .isLoaderVisible ==
                                                  true) {
                                                var result = true;
                                                print('Result => $result');
                                                if (result) {
                                                  setState(() {
                                                    updateRestProfileController
                                                            .isLoaderVisible =
                                                        false;
                                                    widget.moveToCategoryTab();
                                                  });
                                                }
                                              }
                                            } else {
                                              showToastMessage(
                                                  "Please Enter All Fields");
                                            }
                                          },
                                          child: Container(
                                            width: 120,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            decoration: BoxDecoration(
                                              color: Color(ORANGE),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            alignment: Alignment.center,
                                            child: WidgetText
                                                .widgetPoppinsMediumText(
                                              "Submit",
                                              Color(WHITE),
                                              14,
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                            color: Color(ORANGE),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      vendorProfileGetController
                                          .accHolderNameCtr
                                          .clear();
                                      vendorProfileGetController.bankNameCtr
                                          .clear();
                                      vendorProfileGetController.branchNameCtr
                                          .clear();
                                      vendorProfileGetController.routingNoCtr
                                          .clear();
                                      vendorProfileGetController.accNoCtr
                                          .clear();
                                    },
                                    child: Container(
                                      width: 120,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: Color(ORANGE), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
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
                })),
          ],
        ),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String labelText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool isPassword = false]) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        color: Color(WHITE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: TextFormField(
        obscureText: isPassword,
        controller: editingController,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
        ),
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}
