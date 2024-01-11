import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_font_utils.dart';
import '../../../../../core/utils/app_images_utils.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../../core/widgets/widget_card.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/profile_rest_controller.dart';
import '../../controller/update_rest_profile_controller.dart';
import 'package:file_picker/file_picker.dart';

class OwnerInfo extends StatefulWidget {
  Function moveToRestTab;

  OwnerInfo({Key? key, required this.moveToRestTab}) : super(key: key);

  @override
  State<OwnerInfo> createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  final VendorProfileGetController vendorProfileGetController =
  Get.put(VendorProfileGetController());
  final UpdateRestProfileController updateRestProfileController =
  Get.put(UpdateRestProfileController());
  late File file;
  List<File> docFileList = [];
  bool loadDoc = false;
  PlatformFile? platformFile;

   onAttachMultipleDocFile() async {
     if(Platform.isAndroid) {
       final android = await updateRestProfileController.plugin.androidInfo;
       var status = (android.version.sdkInt < 33
           ? await Permission.storage.status
           : PermissionStatus.granted);

       if (android.version.sdkInt < 33) {
         status = await updateRestProfileController.permissionStorage.request();
       }

       if (status.isGranted) {
         openMultiFile();
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
     }else{
       openMultiFile();
     }
  }

  openMultiFile() async {
    List<PlatformFile> platformFile = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );

    if (result != null) {
      debugPrint('Result not null');
      platformFile = result.files;
      debugPrint('platformFile len: ${platformFile.length}');
      for (int i = 0; i < platformFile.length; i++) {
        // platformFile.add(result.files[i]);
        final kb = platformFile[i].size / 1024;
        final mb = kb / 1024;
        final size = (mb >= 1)
            ? '${mb.toStringAsFixed(2)} MB'
            : '${kb.toStringAsFixed(2)} KB';
        debugPrint('File size: $size');

        var pickedPath = result.files[i].path;
        setState(() {
          docFileList.add(File(pickedPath!));
        });
        debugPrint("docFile Len ${docFileList.length}");
        debugPrint("docFile path ${docFileList[i].path}");
      }
      setState(() {
        loadDoc = true;
      });
      debugPrint('Call Api');
      if (loadDoc == true) {
        await updateRestProfileController.updateProfileMultiDocApi(
            imageKey: HttpConstants.PARAMS_VENDORDOC, imageFile: docFileList);
        setState(() {
          if (updateRestProfileController.isLoaderVisible == true) {
            var result = true;
            debugPrint('Result => $result');
            if (result) {
              updateRestProfileController.isLoaderVisible = false;
              vendorProfileGetController.getUserProfile();
            }
          }
        });
      }
    } else {
      loadDoc = false;
      debugPrint('No doc selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : GetBuilder(
                init: vendorProfileGetController,
                builder: (getLogic) {
              return GetBuilder<UpdateRestProfileController>(builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: double.infinity,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            customTextInputField(
                                vendorProfileGetController.ownerNameCtr,
                                "Owner Name",
                                TextInputType.text,
                                TextInputAction.next,
                                false,
                                true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                                vendorProfileGetController.ownerNoCtr,
                                "Owner Contact Number",
                                TextInputType.number,
                                TextInputAction.next,
                                true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                              vendorProfileGetController.ownerEmailCtr,
                              "Owner Email",
                              TextInputType.emailAddress,
                              TextInputAction.next,
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 20, 2),
                                  child:
                                  // WidgetText.widgetPoppinsText('Owner Image')
                                  WidgetText.widgetPoppinsRegularText(
                                    "Owner Image",
                                    Color(GREYLABELPOPINS),
                                    14,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(GREY), // Border color
                                        width: 1.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 20, 20, 2),
                                  child: logic.loadImage == true
                                      ? InkWell(
                                    onTap: () {
                                      openCameraNGallery(logic, context);
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: Image.file(
                                        logic.imagefile,
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                      : vendorProfileGetController
                                      .vendorProfileModel
                                      .data
                                      ?.vendorImg ==
                                      null ||
                                      vendorProfileGetController
                                          .vendorProfileModel
                                          .data!
                                          .vendorImg!
                                          .isEmpty &&
                                          logic.loadImage == false
                                      ? DottedBorder(
                                    color: Color(DARKGREY),
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [4, 4],
                                    strokeWidth: 1,
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: () {
                                        openCameraNGallery(logic, context);
                                      },
                                      child: Container(
                                        width: 75,
                                        height: 75,
                                        child: Image.asset(
                                          ic_upload_icon,
                                          height: 55,
                                          width: 70,
                                        ),
                                      ),
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () {
                                      openCameraNGallery(logic, context);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: ClipRRect(
                                        borderRadius: new BorderRadius.circular(
                                            10.0),
                                        child: Image.network(
                                          vendorProfileGetController
                                              .vendorProfileModel
                                              .data!
                                              .vendorImg!
                                              .first,
                                          width: 75,
                                          height: 75,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext
                                          context,
                                              Widget child,
                                              ImageChunkEvent?
                                              loadingProgress) {
                                            if (loadingProgress ==
                                                null) return child;
                                            return Align(
                                              alignment: Alignment
                                                  .centerLeft,
                                              child:
                                              CircularProgressIndicator(
                                                color: Color(ORANGE),
                                                value: loadingProgress
                                                    .expectedTotalBytes !=
                                                    null
                                                    ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (context,
                                              error, stackTrace) {
                                            return Image.asset(
                                              ic_no_image,
                                              width: 75,
                                              height: 75,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  // WidgetText.widgetPoppinsText(legalDocs),
                                  WidgetText.widgetPoppinsRegularText(
                                    legalDocs,
                                    Color(GREYLABELPOPINS),
                                    14,
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                            vendorProfileGetController
                                                .vendorProfileModel
                                                .data
                                                ?.vendorDocument
                                                ?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return vendorProfileGetController
                                                  .vendorProfileModel
                                                  .data
                                                  ?.vendorImg ==
                                                  null &&
                                                  loadDoc == false
                                                  ? DottedBorder(
                                                color: Color(DARKGREY),
                                                borderType:
                                                BorderType.RRect,
                                                radius:
                                                Radius.circular(10),
                                                dashPattern: [4, 4],
                                                strokeWidth: 1,
                                                padding:
                                                EdgeInsets.all(5),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      onAttachMultipleDocFile();
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 78,
                                                    height: 100,
                                                    child: Image.asset(
                                                      ic_upload_icon,
                                                      width: 65,
                                                      height: 65,
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : InkWell(
                                                child: Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                        left: 20),
                                                    child: Image.asset(
                                                      ic_pdf,
                                                      width: 78,
                                                      height: 100,
                                                      fit: BoxFit.fill,
                                                    )),
                                                onTap: () {
                                                  onAttachMultipleDocFile();
                                                  // Get.to(()=> WidgetWebview(url: vendorProfileGetController.vendorProfileModel.data?.vendorDocument?[index].toString() ?? "",));
                                                },
                                              );
                                            }),
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
                                                onAttachMultipleDocFile();
                                              });
                                            },
                                            child: Container(
                                              width: 78,
                                              height: 100,
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
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                logic.isLoaderVisible == false
                                    ? InkWell(
                                  onTap: () async {
                                    if (vendorProfileGetController
                                        .ownerNameCtr
                                        .text
                                        .isNotEmpty &&
                                        vendorProfileGetController
                                            .ownerNoCtr.text.isNotEmpty &&
                                        vendorProfileGetController
                                            .ownerEmailCtr
                                            .text
                                            .isNotEmpty) {
                                      setState(() {
                                        updateRestProfileController
                                            .isLoaderVisible = true;
                                      });

                                      if (logic.loadImage == true) {
                                        Map<String, String> params =
                                        <String, String>{
                                          HttpConstants.PARAMS_VENDORNAME:
                                          vendorProfileGetController
                                              .ownerNameCtr.text,
                                          HttpConstants.PARAMS_MOBILE:
                                          vendorProfileGetController
                                              .ownerNoCtr.text,
                                          HttpConstants.PARAMS_EMAIL:
                                          vendorProfileGetController
                                              .ownerEmailCtr.text,
                                        };

                                        debugPrint('Params: ${params}');

                                        await logic.updateProfileApi(
                                            params: params,
                                            image: logic.loadImage,
                                            imageKey1: HttpConstants
                                                .PARAMS_VENDORIMAGE,
                                            imageFile: logic.imagefile);
                                      } else {
                                        final params = jsonEncode({
                                          HttpConstants.PARAMS_VENDORNAME:
                                          vendorProfileGetController
                                              .ownerNameCtr.text,
                                          HttpConstants.PARAMS_MOBILE:
                                          vendorProfileGetController
                                              .ownerNoCtr.text,
                                          HttpConstants.PARAMS_EMAIL:
                                          vendorProfileGetController
                                              .ownerEmailCtr.text,
                                        });
                                        debugPrint('Params: ${params}');
                                        await logic.updateProfileApi(
                                            params: params,
                                            image: logic.loadImage,
                                            imageKey1: HttpConstants
                                                .PARAMS_VENDORIMAGE);
                                      }
                                      if (logic.isLoaderVisible == true) {
                                        var result = true;
                                        debugPrint('Result => $result');
                                        if (result) {
                                          setState(() {
                                            logic.isLoaderVisible = false;
                                            widget.moveToRestTab();
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
                                    setState(() {
                                      vendorProfileGetController.ownerEmailCtr
                                          .clear();
                                      // vendorProfileGetController.ownerNoCtr.clear();
                                      vendorProfileGetController.ownerNameCtr
                                          .clear();
                                      vendorProfileGetController.loadRestImage =
                                      false;
                                      vendorProfileGetController
                                          .vendorProfileModel.data?.vendorImg
                                          ?.clear();
                                      vendorProfileGetController
                                          .vendorProfileModel
                                          .data
                                          ?.vendorDocument
                                          ?.clear();
                                      loadDoc = false;
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
                  ],
                );
              });
            });
          })),
    );
  }

  openCameraNGallery(UpdateRestProfileController logic, BuildContext context) {
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

  Widget customTextInputField(TextEditingController editingController,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool isReadOnly = false,
        bool name = false]) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        color: Color(WHITE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: TextFormField(
        controller: editingController,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        readOnly: isReadOnly,
        textInputAction: textInputAction,
        inputFormatters: name
            ? [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
        ]
            : [],
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: lableText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
        ),
        style: TextStyle(
          color: isReadOnly ? Color(HINTCOLOR) : Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}
