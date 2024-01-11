import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';

class AddMacroInfoScreen extends StatefulWidget {
  Function moveToAddonsTab;
  AddMacroInfoScreen({Key? key, required this.moveToAddonsTab}) : super(key: key);

  @override
  State<AddMacroInfoScreen> createState() => _AddMacroInfoScreenState();
}

class _AddMacroInfoScreenState extends State<AddMacroInfoScreen> {
  final RestMenuViewController restMenuViewController =
      Get.put(RestMenuViewController());
  var menuId;
  String postfix = "gm";

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    menuId = restMenuViewController.addMenuModel.data?.menuId;
    print('MenuId: $menuId');
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
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Flexible(
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
                            WidgetText().customTextInputField(
                              restMenuViewController.caloriesController,
                              "Enter Calories",
                              "Calories",
                              TextInputType.number,
                              TextInputAction.next,
                              false, readData: "${restMenuViewController.caloriesController.text}",
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
                              false,readData: "${restMenuViewController.fatController.text+ "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 5,
                            ),
                            WidgetText().customTextInputField(
                              restMenuViewController.carbsController,
                              "Enter Carbs in Grams",
                              "Carbs",
                              TextInputType.number,
                              TextInputAction.next,
                              false,readData: "${restMenuViewController.carbsController.text+ "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            // _profileFieldWidget("Carbs", "Enter Carbs in grams"),
                            SizedBox(
                              height: 5,
                            ),
                            // _profileFieldWidget("Protein", "Enter Protein in grams"),
                            WidgetText().customTextInputField(
                              restMenuViewController.proteinController,
                              "Enter Protein in Grams",
                              "Protein",
                              TextInputType.number,
                              TextInputAction.done,
                              false,readData: "${restMenuViewController.proteinController.text+ "g"}",
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                restMenuViewController.isMenuUpdated == false
                                    ? InkWell(
                                        onTap: () async {
                                          if (menuId != null) {
                                            setState(() {
                                              restMenuViewController
                                                  .isMenuUpdated = true;
                                            });

                                            final params = jsonEncode({
                                              HttpConstants.PARAMS_MENUID:
                                                  menuId,
                                              HttpConstants.PARAMS_CALORIES:
                                                  restMenuViewController
                                                      .caloriesController.text,
                                              HttpConstants.PARAMS_CARBS:
                                                  restMenuViewController
                                                      .carbsController.text,
                                              HttpConstants.PARAMS_PROTEIN:
                                                  restMenuViewController
                                                      .proteinController.text,
                                              HttpConstants.PARAMS_FAT:
                                                  restMenuViewController
                                                      .fatController.text,
                                            });
                                            print('Params: ${params}');

                                            await restMenuViewController
                                                .updateMenuApi(params, isAdd: true);

                                            if (restMenuViewController
                                                    .isMenuUpdated ==
                                                true) {
                                              var result = true;
                                              print('Result => $result');
                                              if (result) {
                                                setState(() {
                                                  restMenuViewController
                                                      .isMenuUpdated = false;
                                                  // Get.back();
                                                  widget.moveToAddonsTab();
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                restMenuViewController
                                                    .isMenuUpdated = false;
                                              });
                                            }
                                          } else {
                                            showToastMessage(
                                                'Please Add Data in General Info Tab');
                                          }
                                        },
                                        child: Container(
                                          width: 120,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                    restMenuViewController.caloriesController
                                        .clear();
                                    restMenuViewController.carbsController
                                        .clear();
                                    restMenuViewController.proteinController
                                        .clear();
                                    restMenuViewController.fatController
                                        .clear();
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
                      ),
                    ),
                  ),
                ],
              );
      })),
    );
  }
}
