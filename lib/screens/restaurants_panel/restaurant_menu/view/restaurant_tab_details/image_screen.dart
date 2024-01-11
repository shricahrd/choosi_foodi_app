import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';

class ImageScreen extends StatefulWidget {
  Function moveToMacroTab;
  bool isEditable;

  ImageScreen(
      {Key? key, required this.isEditable, required this.moveToMacroTab})
      : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState(isEditable);
}

class _ImageScreenState extends State<ImageScreen> {
  bool isEditable = false;

  final RestMenuViewController restMenuViewController =
  Get.put(RestMenuViewController());

  _ImageScreenState(bool isEditable) {
    this.isEditable = isEditable;
  }

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    print('LoadImage: ${restMenuViewController.loadImage}');
    print('MenuImage: ${restMenuViewController.menuImage}');
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                return Obx(() {
                  isEditable = restMenuViewController.isEditable.value;

                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          logic.loadImage == true
                              ? InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(
                                logic.imagefile,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height /
                                    2.3,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () async {
                              await logic.onAttachFilePicker();
                              setState(() {
                                if (logic.loadImage == true) {
                                  print('Imagefile: ${logic.imagefile}');
                                }
                              });
                            },
                          )
                              : logic.menuImage == ""
                              ? InkWell(
                            onTap: () async {
                              if (isEditable == true) {
                                await logic.onAttachFilePicker();
                                setState(() {
                                  if (logic.loadImage == true) {
                                    print(
                                        'Imagefile: ${logic.imagefile}');
                                  }
                                });
                              }
                            },
                            child: customUpload(
                                'Please Upload a Photo of the Menu Item'),
                          )
                              : Container(
                            margin:
                            EdgeInsets.fromLTRB(20, 20, 20, 2),
                            child: InkWell(
                              onTap: () async {
                                await logic.onAttachFilePicker();
                                setState(() {
                                  if (logic.loadImage == true) {
                                    print(
                                        'Imagefile: ${logic.imagefile}');
                                  }
                                });
                              },
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height /
                                    2.8,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  child: Image.network(
                                    logic.menuImage.toString(),
                                    // width: 130,
                                    // height: 100,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Color(ORANGE),
                                          value: loadingProgress
                                              .expectedTotalBytes != null
                                              ? loadingProgress
                                              .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return customUpload(
                                          'Please Upload a Photo of the Menu Item');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          isEditable
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              restMenuViewController.isMenuUpdated ==
                                  false
                                  ? InkWell(
                                onTap: () async {
                                  if (logic.loadImage == true) {
                                    await logic.updateImageMenuApi(
                                        restMenuViewController
                                            .restMenuViewModel
                                            .data!
                                            .menuId
                                            .toString(),
                                        logic.loadImage,
                                        HttpConstants
                                            .PARAMS_VENDORMENUIMG,
                                        logic.imagefile, isAdd: false
                                    );

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
                                          widget.moveToMacroTab();
                                          // logic.loadImage = false;
                                          restMenuViewController
                                              .getMenuDetailsApi(
                                              restMenuViewController
                                                  .restMenuViewModel
                                                  .data!
                                                  .menuId
                                                  .toString());
                                        });
                                      } else {
                                        setState(() {
                                          restMenuViewController
                                              .isMenuUpdated =
                                          false;
                                        });
                                      }
                                    }
                                  } else {
                                    showToastMessage(plzUploadImageMsg);
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
                                  : CircularProgressIndicator(
                                color: Color(ORANGE),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  /* await logic.onAttechFile();
                              setState(() {
                                if (logic.loadImage == true) {
                                  print('Imagefile: ${logic.imagefile}');
                                }
                              });*/
                                  setState(() {
                                    logic.loadImage = false;
                                    logic.menuImage = "";
                                  });
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
                                  child:
                                  WidgetText.widgetPoppinsMediumText(
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
                        ],
                      ),
                    ),
                  );
                });
              });
            })));
  }

  Widget customUpload(String lableText,) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
      child: DottedBorder(
        color: Color(DARKGREY),
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        dashPattern: [4, 4],
        strokeWidth: 1,
        padding: EdgeInsets.all(5),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2.8,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
    );
  }
}
