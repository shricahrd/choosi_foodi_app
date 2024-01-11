import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';

class AddImageScreen extends StatefulWidget {
  Function moveToMacroTab;

  AddImageScreen({Key? key, required this.moveToMacroTab}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  final RestMenuViewController restMenuViewController =
      Get.put(RestMenuViewController());
  var imageUpload = false;
  var menuId;

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    menuId = restMenuViewController.addMenuModel.data?.menuId;
    print('MenuId: $menuId');
    FocusManager.instance.primaryFocus?.unfocus();
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
            : GetBuilder<RestMenuViewController>(builder: (logic) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        logic.loadImage == true
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  logic.imagefile,
                                  height:
                                      MediaQuery.of(context).size.height / 2.8,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : customUpload(
                                'Please Upload a Photo of the Menu Item'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            restMenuViewController.isMenuUpdated == false
                                ? InkWell(
                                    onTap: () async {
                                      if (restMenuViewController.addMenuModel.data?.menuId != null) {

                                        if(logic.loadImage == true) {
                                          setState(() {
                                            restMenuViewController
                                                .isMenuUpdated =
                                            true;
                                          });

                                          await logic.updateImageMenuApi(
                                              menuId,
                                              imageUpload,
                                              HttpConstants
                                                  .PARAMS_VENDORMENUIMG,
                                              logic.imagefile, isAdd: true);
                                          if (restMenuViewController
                                              .isMenuUpdated ==
                                              true) {
                                            setState(() {
                                              restMenuViewController
                                                  .isMenuUpdated = false;
                                              widget.moveToMacroTab();
                                            });
                                          } else {
                                            setState(() {
                                              restMenuViewController
                                                  .isMenuUpdated = false;
                                            });
                                          }
                                        }else{
                                          showToastMessage(plzUploadImageMsg);
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
                                      child: WidgetText.widgetPoppinsMediumText(
                                        submit,
                                        Color(WHITE),
                                        14,
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(
                                  color: Color(ORANGE),
                                ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  restMenuViewController.isMenuUpdated = false;
                                  logic.loadImage = false;
                                });
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
                      ],
                    ),
                  ),
                );
              });
      })),
    );
  }

  Widget customUpload(
    String lableText,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
      child: InkWell(
        onTap: () {
          if (restMenuViewController.addMenuModel.data?.menuId != null) {
            restMenuViewController.onAttachFilePicker();
            imageUpload = true;
          } else {
            showToastMessage('Please Add Data in General Info Tab');
          }
        },
        child: DottedBorder(
          color: Color(DARKGREY),
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          dashPattern: [4, 4],
          strokeWidth: 1,
          padding: EdgeInsets.all(5),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.8,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ic_upload_icon,
                  height: 100,
                  width: 130,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(8.0),
                  child: WidgetText.widgetPoppinsMediumText(
                    lableText,
                    Color(BLACK),
                    14,
                    align: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
