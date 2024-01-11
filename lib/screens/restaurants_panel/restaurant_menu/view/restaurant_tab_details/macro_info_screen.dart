import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';

class MacroInfoScreen extends StatefulWidget {
  Function moveToAddons;
  bool isEditable;

  MacroInfoScreen(
      {Key? key, required this.isEditable, required this.moveToAddons})
      : super(key: key);

  @override
  State<MacroInfoScreen> createState() => _MacroInfoScreenState(isEditable);
}

class _MacroInfoScreenState extends State<MacroInfoScreen> {
  bool isEditable = false;
  final RestMenuViewController restMenuViewController =
  Get.put(RestMenuViewController());

  _MacroInfoScreenState(bool isEditable) {
    this.isEditable = isEditable;
  }

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {

                  isEditable = restMenuViewController.isEditable.value;

                  return Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: KeyboardHider(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: double.infinity,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            // _profileFieldWidget("Calories", "Enter Calories"),
                            // restMenuViewController.caloriesController == null ?
                            WidgetText().customTextInputField(
                                restMenuViewController.caloriesController,
                                "Enter Calories",
                                "Calories",
                                TextInputType.number,
                                TextInputAction.next,
                                isEditable ? false : true,
                                readData: "${restMenuViewController
                                    .caloriesController.text}"
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),

                            SizedBox(
                              height: 5,
                            ),
                            // _profileFieldWidget("Fat", "Enter Fat in grams"),
                            WidgetText().customTextInputField(
                              restMenuViewController.fatController,
                              "Enter Fat in Grams",
                              "Fat",
                              TextInputType.number,
                              TextInputAction.next,
                              isEditable ? false : true,
                              readData: "${restMenuViewController.fatController
                                  .text + "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 5,
                            ),
                            // _profileFieldWidget("Carbs", "Enter Carbs in grams"),
                            WidgetText().customTextInputField(
                              restMenuViewController.carbsController,
                              "Enter Carbs in Grams",
                              "Carbs",
                              TextInputType.number,
                              TextInputAction.next,
                              isEditable ? false : true,
                              readData: "${restMenuViewController
                                  .carbsController.text + "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 5,
                            ),
                            // _profileFieldWidget("Protein", "Enter Protein in grams"),
                            WidgetText().customTextInputField(
                              restMenuViewController.proteinController,
                              "Enter Protein in Grams",
                              "Protein",
                              TextInputType.number,
                              TextInputAction.next,
                              isEditable ? false : true,
                              readData: "${restMenuViewController
                                  .proteinController.text + "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 40,
                            ),
                            isEditable
                                ? Row(
                              children: [
                                restMenuViewController.isMenuUpdated ==
                                    false
                                    ? InkWell(
                                  onTap: () async {
                                    // print('Carbs: ${restMenuViewController.carbsController.text.split('gm').first.toString()}');
                                    final params = jsonEncode({
                                      HttpConstants.PARAMS_MENUID:
                                      restMenuViewController
                                          .restMenuViewModel
                                          .data
                                          ?.menuId,
                                      HttpConstants.PARAMS_CALORIES:
                                      restMenuViewController
                                          .caloriesController
                                          .text,
                                      HttpConstants.PARAMS_CARBS:
                                      restMenuViewController
                                          .carbsController.text,
                                      HttpConstants.PARAMS_PROTEIN:
                                      restMenuViewController
                                          .proteinController
                                          .text,
                                      HttpConstants.PARAMS_FAT:
                                      restMenuViewController
                                          .fatController.text,
                                    });
                                    print('Params: ${params}');

                                    await restMenuViewController
                                        .updateMenuApi(params, isAdd: false);

                                    if (restMenuViewController
                                        .isMenuUpdated ==
                                        true) {
                                      var result = true;
                                      print('Result => $result');
                                      if (result) {
                                        setState(() {
                                          restMenuViewController
                                              .isMenuUpdated =
                                          false;
                                          // selectedEditMenuIndex = 1;
                                          widget.moveToAddons();
                                          // Get.back();
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        restMenuViewController
                                            .isMenuUpdated = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.fromLTRB(
                                        0, 10, 0, 10),
                                    decoration: BoxDecoration(
                                      color: Color(ORANGE),
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                      BorderRadius.all(
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
                                  onTap: () {},
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
                                    child: WidgetText
                                        .widgetPoppinsMediumText(
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
                            )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          })),
    );
  }
}
