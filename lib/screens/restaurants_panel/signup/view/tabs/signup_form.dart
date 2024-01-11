import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_font_utils.dart';
import '../../../../../core/utils/app_images_utils.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../../core/widgets/widget_button.dart';
import '../../../../../core/widgets/widget_card.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/add_restaurnt_controller.dart';

class SignupForm extends StatefulWidget {
  String mobile;
  Function moveToRestTab;
  SignupForm({Key? key, required this.mobile, required this.moveToRestTab}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // TextEditingController ownerController = new TextEditingController();
  // TextEditingController emailController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();
  // TextEditingController cPwdController = new TextEditingController();
  VendorAddRestaurantController vendorAddRestaurantController = Get.put(VendorAddRestaurantController());
  var imageUpload = false;

  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void initState() {
    print('Mobile: ${widget.mobile}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(WHITE),
        body: SafeArea(
            child: GetBuilder<VendorAddRestaurantController>(builder: (logic) {
          // bool emailValid = RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text);
          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(logic.emailController.text);

          return KeyboardHider(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        customTextInputField(
                            logic.ownerController,
                          "Enter Owner Name",
                          "Owner Name",
                          TextInputType.text,
                          TextInputAction.next,true
                        ),
                        customTextInputField(
                          logic.emailController,
                          "Enter your Email",
                          "Email",
                          TextInputType.emailAddress,
                          TextInputAction.next,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 2),
                              child: WidgetText.widgetRegularText(
                                'Upload Profile Image',
                                align: TextAlign.end,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
                              child: logic.loadImage == true
                                  ? GestureDetector(
                                    onTap: ()  {
                                      openCameraNGallery(logic, context);
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          logic.imagefile,
                                          height: 80,
                                          width: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                  )
                                  : DottedBorder(
                                      color: Color(DARKGREY),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      dashPattern: [4, 4],
                                      strokeWidth: 1,
                                      padding: EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () async {
                                          openCameraNGallery(logic, context);
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 90,
                                          child: Image.asset(
                                            ic_upload_icon,
                                            height: 55,
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),

                  /*      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 2),
                              child:
                              WidgetText.widgetRegularText(
                                'Upload Legal Documents',
                                align: TextAlign.end,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
                              child: Row(
                                children: [
                                  logic.loadDoc == true
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            ic_pdf,
                                            width: 78,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ))
                                      : DottedBorder(
                                          color: Color(DARKGREY),
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          dashPattern: [4, 4],
                                          strokeWidth: 1,
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height: 80,
                                            width: 90,
                                            child: Image.asset(
                                              ic_upload_icon,
                                              height: 55,
                                              width: 70,
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DottedBorder(
                                    color: Color(DARKGREY),
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [4, 4],
                                    strokeWidth: 1,
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          logic.onAttachDocFile();
                                          imageUpload = true;
                                        });
                                      },
                                      child: Container(
                                        height: 80,
                                        width: 90,
                                        child: Image.asset(
                                          ic_plus_icon,
                                          height: 5,
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),*/
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 2),
                              child:
                              WidgetText.widgetRegularText(
                                'Upload Legal Documents',
                                align: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 100,
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB( logic.docFileList.length == 0 ?10 : 20, 10, 20, 2),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:BouncingScrollPhysics(),
                                          scrollDirection:Axis.horizontal,
                                          itemCount: logic.docFileList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 10),
                                               child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    child: Image.asset(
                                                      ic_pdf,
                                                      width: 78,
                                                      height: 100,
                                                      fit: BoxFit.fill,
                                                    ))
                                            );
                                              }),
                                      SizedBox(
                                        width: 10,
                                      ),

                                      logic.docFileList.length == 0 ?
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: DottedBorder(
                                          color: Color(DARKGREY),
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          dashPattern: [4, 4],
                                          strokeWidth: 1,
                                          padding: EdgeInsets.all(5),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                logic.onAttachMultipleDocFile(true);
                                              });
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 90,
                                              child: Image.asset(
                                                ic_upload_icon,
                                                height: 55,
                                                width: 70,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) : Container(),
                                      DottedBorder(
                                        color: Color(DARKGREY),
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10),
                                        dashPattern: [4, 4],
                                        strokeWidth: 1,
                                        padding: EdgeInsets.all(5),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              logic.onAttachMultipleDocFile(true);
                                            });
                                          },
                                          child: Container(
                                            height: 80,
                                            width: 90,
                                            child: Image.asset(
                                              ic_plus_icon,
                                              height: 5,
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),

                        // customUpload("Upload Profile Image"),
                        // customLegalUpload("Upload Legal Documents"),
                        customTextInputField(
                          logic.passwordController,
                          "Enter Password",
                          "Password",
                          TextInputType.visiblePassword,
                          TextInputAction.next,
                          false, true,
                        ),
                        customTextInputField(
                            logic.cPwdController,
                            "Enter Confirm Password",
                            "Confirm Password",
                            TextInputType.visiblePassword,
                            TextInputAction.done,
                            false, true),
                        SizedBox(
                          height: 20,
                        ),

                        logic.isLoaderVisible == false?
                        Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: WidgetButton.widgetDefaultButton(
                                    submit, () async {
                                  if (_networkController.connectionType != 0) {
                                    if ( logic.ownerController.text.isNotEmpty &&
                                        logic.emailController.text.isNotEmpty &&
                                        logic.passwordController.text.isNotEmpty) {
                                      if (emailValid == true) {
                                        if ( logic.passwordController.text ==
                                            logic.cPwdController.text) {
                                        if ( logic.passwordController.text.length >= 6) {
                                          if(logic.loadMultiDoc == true && logic.loadImage == true) {
                                            await logic.updateSignupApi(
                                                email:  logic.emailController.text,
                                                name:  logic.ownerController.text,
                                                password:  logic.passwordController
                                                    .text,
                                                mobile: widget.mobile
                                                    .toString(),
                                                image: imageUpload,
                                                imagekey1: HttpConstants
                                                    .PARAMS_VENDORIMAGE,
                                                imagekey2: HttpConstants
                                                    .PARAMS_VENDORDOC);

                                            if (logic.vendorRegisterModel.meta
                                                ?.status == true) {
                                              setState(() {
                                                widget.moveToRestTab();
                                              });
                                            }
                                          }else {
                                            showToastMessage(plzUploadImageDocMsg);
                                          }
                                        }else {
                                          showToastMessage(
                                              plzEnter6DigiyPwdMsg);
                                        }
                                        } else {
                                          showToastMessage(
                                              pwdNotMatchMsg);
                                        }
                                      } else {
                                        showToastMessage(
                                            plzEnterProperEmailMsg);
                                      }
                                    } else {
                                      showToastMessage(
                                          allFieldReqMsg);
                                    }
                                  } else {
                                    showToastMessage(check_internet);
                                  }
                              /*    setState(() {
                                    widget.moveToRestTab();
                                  });*/
                                }))
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Color(ORANGE),
                                ),
                              ),

                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ))
              ],
            ),
          );
        })));
  }

  openCameraNGallery(VendorAddRestaurantController logic, BuildContext context) {
    pickImageFromDevice(context: context, openCamera: () async {
      final status = await logic.permissionCamera.request();
      if (status.isGranted) {
        logic.getFromCamera(context);
      } else if (status.isPermanentlyDenied) {
        showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
        Future.delayed(const Duration(
            seconds: 3), () async {
          await openAppSettings();
        });
        // permissionsRequested = false;
      } else {
        showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
        debugPrint('Camera permission denied.');
      }
    }, openGallery: () async {
      if (Platform.isIOS) {
        logic.getFromGallery(context);
      } else {
        final android = await logic.plugin.androidInfo;
        var status = (android.version.sdkInt < 33
            ? await Permission.storage.status
            : PermissionStatus.granted);

        if (android.version.sdkInt < 33) {
          status = await logic.permissionStorage.request();
        }

        if (status.isGranted) {
          logic.getFromGallery(context);
        } else if (status.isPermanentlyDenied) {
          showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
          Future.delayed(const Duration(
              seconds: 3), () async {
            await openAppSettings();
          });
        } else {
          showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
          // Permission denied
          debugPrint('Camera permission denied.');
        }
      }
    });
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false, bool hidePassword = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
          child: WidgetText.widgetRegularText(
            lableText,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
          decoration: BoxDecoration(
            color: Color(WHITE),
            shape: BoxShape.rectangle,
            border: Border.all(color: Color(ORANGE), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: TextFormField(
            obscureText: hidePassword,
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
              inputFormatters:
              name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val) {
              setState(() {});
            },
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontRoboto,
              fontWeight: RobotoMedium,
            ),
          ),
        )
      ],
    );
  }

  Widget customUpload(
    String lableText,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
          child: WidgetText.widgetRobotoRegularText(
            lableText,
            Color(LABLECOLOR),
            18,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
          child: DottedBorder(
            color: Color(DARKGREY),
            borderType: BorderType.RRect,
            radius: Radius.circular(10),
            dashPattern: [4, 4],
            strokeWidth: 1,
            padding: EdgeInsets.all(5),
            child: Container(
              height: 80,
              width: 90,
              child: Image.asset(
                ic_upload_icon,
                height: 55,
                width: 70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customLegalUpload(
    String lableText,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
          child: Row(
            children: [
              WidgetText.widgetRobotoRegularText(
                lableText,
                Color(LABLECOLOR),
                18,
                align: TextAlign.end,
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                ic_i_icon,
                height: 15,
                width: 15,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
          child: Row(
            children: [
              DottedBorder(
                color: Color(DARKGREY),
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [4, 4],
                strokeWidth: 1,
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 80,
                  width: 90,
                  child: Image.asset(
                    ic_upload_icon,
                    height: 55,
                    width: 70,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              DottedBorder(
                color: Color(DARKGREY),
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [4, 4],
                strokeWidth: 1,
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 80,
                  width: 90,
                  child: Image.asset(
                    ic_plus_icon,
                    height: 5,
                    width: 5,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
