import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../core/utils/app_color_utils.dart';
import '../../../../../../core/utils/app_font_utils.dart';
import '../../../../../../core/utils/app_strings_constants.dart';
import '../../../../../../core/utils/networkManager.dart';
import '../../../../../../core/widgets/widget_text.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/add_coupon_controller.dart';

class AddEditDealScreen extends StatefulWidget {
  bool isEdit = false;
  String? couponId;

  AddEditDealScreen({
    required this.isEdit,
    this.couponId,
    Key? key,
  }) : super(key: key,);

  @override
  State<AddEditDealScreen> createState() => _AddEditDealScreenState();
}

class _AddEditDealScreenState extends State<AddEditDealScreen> {
  final AddCouponController addCouponController =
      Get.put(AddCouponController());
  // ValueNotifier<bool> isRequiredLoader = ValueNotifier<bool>(false);

  @override
  void initState() {
    addCouponController.filterStartDate =
        formatterMonth.format(addCouponController.selectedIssueDate);
    addCouponController.filterMiliIssueDate =
        addCouponController.selectedIssueDate.millisecondsSinceEpoch;
    addCouponController.filterExpireDate =
        formatterMonth.format(addCouponController.selectedExpireDate);
    addCouponController.filterMiliExpireDate =
        addCouponController.selectedExpireDate.millisecondsSinceEpoch;

    debugPrint(
        "addCouponController.filterStartDate: ${addCouponController.filterStartDate}");
    // print('filterMiliIssueDate: ${addCouponController.filterMiliIssueDate}, filterMiliExpireDate: ${addCouponController.filterMiliExpireDate}');
    if (widget.isEdit == true) {
      addCouponController.getCouponDetails(widget.couponId.toString());
    }

    if (widget.isEdit == false) {
      addCouponController.isRequiredLoader.value = false;
    }else{
      addCouponController.isRequiredLoader.value = true;
    }
    super.initState();
  }


  openGallery(AddCouponController logic) async {
    if (Platform.isIOS) {
      logic.getFromGallery(context);
    }else{
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,  widget.isEdit == true ? update_coupon : add_coupon,true ),
      body: SafeArea(child: GetBuilder<AddCouponController>(builder: (logic) {
        return Column(
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
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsText(coupon_type),
                                    IgnorePointer(
                                      ignoring: logic.isEditable ? false : true,
                                      child: DropdownButton(
                                        underline: Container(),
                                        borderRadius: BorderRadius.circular(10),
                                        icon: Visibility(
                                          visible: true,
                                          child: Image.asset(
                                            ic_down_arrow,
                                            height: 10,
                                            width: 20,
                                            color: Color(BLACK),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint:
                                            WidgetText.widgetPoppinsRegularText(
                                          select_coupon_type,
                                          Color(BLACK),
                                          18,
                                        ),
                                        value: logic.selectCouponType == select
                                            ? logic.couponType[0].toString()
                                            : logic.selectCouponType,
                                        style: TextStyle(
                                          color: Color(BLACK),
                                          fontSize: 16,
                                          fontFamily: FontPoppins,
                                          fontWeight: PoppinsRegular,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            logic.selectCouponType =
                                                value.toString();
                                            print(
                                                'selectCouponType: ${logic.selectCouponType}');
                                          });
                                        },
                                        items: logic.couponType
                                            .map((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: logic.selectCouponType ==
                                                        select
                                                    ? Color(SUBTEXT)
                                                    : Color(BLACK),
                                                // Color(BLACK),
                                                fontSize: 16,
                                                fontFamily: FontPoppins,
                                                fontWeight: RobotoRegular,
                                              ),
                                            ),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                logic.couponNameCtrl,
                                coupon_name,
                                "Name",
                                TextInputType.text,
                                TextInputAction.next,
                                true,
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              /*    SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsText(audience),
                                    IgnorePointer(
                                      ignoring: logic.isEditable ? false : true,
                                      child: DropdownButton(
                                        underline: Container(),
                                        borderRadius: BorderRadius.circular(10),
                                        icon: Visibility(
                                          visible: true,
                                          child: Image.asset(
                                            ic_down_arrow,
                                            height: 10,
                                            width: 20,
                                            color: Color(BLACK),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint:
                                            WidgetText.widgetPoppinsRegularText(
                                          "Select Coupon Type",
                                          Color(BLACK),
                                          18,
                                        ),
                                        value: logic.selectCouponForType == "Select"
                                            ? logic.couponForType[0].toString()
                                            : logic.selectCouponForType,
                                        style: TextStyle(
                                          color: Color(BLACK),
                                          fontSize: 16,
                                          fontFamily: FontPoppins,
                                          fontWeight: PoppinsRegular,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            logic.selectCouponForType =
                                                value.toString();
                                            // controller.text = value.toString();
                                          });
                                        },
                                        items:
                                        logic.couponForType.map((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: logic.selectCouponForType ==
                                                        "Select"
                                                    ? Color(SUBTEXT)
                                                    : Color(BLACK),
                                                // Color(BLACK),
                                                fontSize: 16,
                                                fontFamily: FontPoppins,
                                                fontWeight: RobotoRegular,
                                              ),
                                            ),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),*/
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsText('Discount In'),
                                    IgnorePointer(
                                      ignoring: logic.isEditable ? false : true,
                                      child: DropdownButton(
                                        underline: Container(),
                                        borderRadius: BorderRadius.circular(10),
                                        icon: Visibility(
                                          visible: true,
                                          child: Image.asset(
                                            ic_down_arrow,
                                            height: 10,
                                            width: 20,
                                            color: Color(BLACK),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint:
                                            WidgetText.widgetPoppinsRegularText(
                                          "Select Discount In",
                                          Color(BLACK),
                                          18,
                                        ),
                                        value: logic.selectDiscountIn == select
                                            ? logic.discountInType[0].toString()
                                            : logic.selectDiscountIn.toString(),
                                        style: TextStyle(
                                          color: Color(BLACK),
                                          fontSize: 16,
                                          fontFamily: FontPoppins,
                                          fontWeight: PoppinsRegular,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            logic.selectDiscountIn =
                                                value.toString();
                                          });
                                        },
                                        items: logic.discountInType
                                            .map((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: logic.selectDiscountIn ==
                                                        select
                                                    ? Color(SUBTEXT)
                                                    : Color(BLACK),
                                                // Color(BLACK),
                                                fontSize: 16,
                                                fontFamily: FontPoppins,
                                                fontWeight: RobotoRegular,
                                              ),
                                            ),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                  logic.discountCtrl,
                                  "Enter Discount",
                                  "Discount",
                                  TextInputType.number,
                                  TextInputAction.next,
                                  false,
                                  true),
                              /* customTextInputField(
                                logic.showInAppCtrl,
                                "Yes/No",
                                "Show In App",
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
                              customTextInputField(
                                logic.maxDiscountCtrl,
                                "Enter Max Discount",
                                "Maximum Discount",
                                TextInputType.number,
                                TextInputAction.next,
                                  false, true
                              ),*/
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              logic.selectCouponType == static ||
                                      logic.selectCouponType ==
                                          staticWithCart ||
                                      logic.selectCouponType ==
                                          staticWithPeriodic ||
                                      logic.selectCouponType ==
                                          staticWithPeriodicCart
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /*customTextInputField(
                                          logic.useCountCtrl,
                                          "Enter Use Count",
                                          "Use Count",
                                          TextInputType.number,
                                          TextInputAction.next,
                                            false, true
                                        ),
                                        Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(DIVIDERCOLOR)),
                                        SizedBox(
                                          height: 8,
                                        ),*/
                                        customTextInputField(
                                            logic.perUseCountCtrl,
                                            "Enter Uses Per User",
                                            perUseCount,
                                            TextInputType.number,
                                            TextInputAction.next,
                                            false,
                                            true),
                                        Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(DIVIDERCOLOR)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              logic.selectCouponType == staticWithCart ||
                                      logic.selectCouponType ==
                                          staticWithPeriodicCart ||
                                      logic.selectCouponType == offerWithCart ||
                                      logic.selectCouponType ==
                                          offerWithPeriodicCart
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customTextInputField(
                                            logic.minCartCtrl,
                                            "Enter Amount",
                                            min_spend,
                                            TextInputType.number,
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
                                        /*   customTextInputField(
                                          logic.maxCartCtrl,
                                          "Enter Amount",
                                          "Maximum Cart Amount",
                                          TextInputType.number,
                                          TextInputAction.next,
                                            false, true
                                        ),
                                        Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(DIVIDERCOLOR)),
                                        SizedBox(
                                          height: 10,
                                        ),*/
                                      ],
                                    )
                                  : Container(),
                              /*     logic.selectCouponType == offer ||
                                  logic.selectCouponType == offerWithCart ||
                                  logic.selectCouponType == offerWithPeriodic ||
                                  logic.selectCouponType == offerWithPeriodicCart
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customTextInputField(
                                          logic.totalNoCouponCtrl,
                                          "Enter Total Number Coupon",
                                          "Total Number Coupon",
                                          TextInputType.number,
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
                                      ],
                                    )
                                  : Container(),*/
                              logic.selectCouponType == staticWithPeriodic ||
                                      logic.selectCouponType ==
                                          staticWithPeriodicCart ||
                                      logic.selectCouponType ==
                                          offerWithPeriodic ||
                                      logic.selectCouponType ==
                                          offerWithPeriodicCart
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: WidgetText
                                              .widgetPoppinsRegularText(
                                                  "Issue Date",
                                                  Color(GREYLABELPOPINS),
                                                  16),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: InkWell(
                                            onTap: () {
                                              logic.selectIssueDate(context);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  logic.filterStartDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(BLACK),
                                                    fontSize: 16,
                                                    fontFamily: FontPoppins,
                                                    fontWeight: RobotoMedium,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons.date_range,
                                                      size: 20.0,
                                                      color: Color(DARKGREY),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(DIVIDERCOLOR)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: WidgetText
                                              .widgetPoppinsRegularText(
                                                  "Expiry Date",
                                                  Color(GREYLABELPOPINS),
                                                  16),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: InkWell(
                                            onTap: () {
                                              logic.selectExpireDate(context);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  logic.filterExpireDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(BLACK),
                                                    fontSize: 16,
                                                    fontFamily: FontPoppins,
                                                    fontWeight: RobotoMedium,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons.date_range,
                                                      size: 20.0,
                                                      color: Color(DARKGREY),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(DIVIDERCOLOR)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              customTextInputField(
                                logic.descCtrl,
                                "Enter Description",
                                "Description",
                                TextInputType.text,
                                TextInputAction.done,
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: WidgetText.widgetPoppinsRegularText(
                                    "Image", Color(GREYLABELPOPINS), 16),
                              ),
                              logic.loadImage == true
                                  ? InkWell(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.file(
                                          logic.imagefile,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return customUpload(
                                                'Drag and Drop Your File(s) Here To Upload Or Click Here');
                                          },
                                        ),
                                      ),
                                      onTap: () async {
                                        openGallery(logic);

                                       /* debugPrint('loadImage: ${logic.loadImage}');
                                        setState(() {
                                          debugPrint("isRequiredLoader value in pic : ${logic.isRequiredLoader.value}");
                                        });*/
                                      },
                                    )
                                  : logic.apiImage == ""
                                      ? customUpload(
                                          'Drag and Drop Your File(s) Here To Upload Or Click Here')
                                      : InkWell(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              logic.apiImage.toString(),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2.3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
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
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return customUpload(
                                                    'Drag and Drop Your File(s) Here To Upload Or Click Here');
                                                //   Image.asset(
                                                //   ic_upload_icon,
                                                //   height: MediaQuery.of(context).size.height / 2.3,
                                                //   width: MediaQuery.of(context).size.width,
                                                //   fit: BoxFit.fill,
                                                // );
                                              },
                                            ),
                                          ),
                                          onTap: () async {
                                            openGallery(logic);
                                           /* await logic.onAttachFilePicker();
                                            debugPrint('Imagefile: ${logic.imagefile}');
                                            setState(() {
                                              debugPrint("isRequiredLoader value in pic : ${logic.isRequiredLoader.value}");
                                            });*/
                                          },
                                        ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  logic.isCouponLoader == false
                                      ? InkWell(
                                          onTap: () async {
                                            debugPrint("selectCouponType: ${logic.selectCouponType}, loadImage: ${logic.loadImage}, api image: ${logic.apiImage}");
                                            debugPrint("isRequiredLoader value: ${logic.isRequiredLoader.value}");
                                            logic.isRequiredLoader.value = await logic.checkReqFields();
                                            debugPrint("isRequiredLoader value: ${logic.isRequiredLoader.value}");
                                            if (logic.isRequiredLoader.value == true) {
                                              await logic.selectCouponList(
                                                  logic.selectCouponType
                                                      .toString(),
                                                  widget.isEdit);
                                              print('data back:');
                                              Get.back(result: true);
                                            }
                                        /*    if (logic.selectCouponType != select) {
                                              if (logic.loadImage == true ||
                                                  logic.apiImage != "") {

                                              } else {
                                                setState(() {
                                                  isRequiredLoader.value = false;
                                                  showToastMessage(uploadPicMsg);
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                isRequiredLoader.value = false;
                                                showToastMessage(select_coupon_type);
                                              });
                                            }*/
                                            // logic.addCouponApi(logic.params);
                                          },
                                          child: Container(
                                            width: 120,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            decoration: BoxDecoration(
                                              color: logic.isRequiredLoader.value ==
                                                      true
                                                  ? Color(ORANGE)
                                                  : Color(GREY6),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                  color: logic.isRequiredLoader.value ==
                                                          true
                                                      ? Color(ORANGE)
                                                      : Color(GREY6),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            alignment: Alignment.center,
                                            child: WidgetText
                                                .widgetPoppinsMediumText(
                                              "Save",
                                              Color(WHITE),
                                              12,
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
                                    onTap: () async {
                                      setState(() {
                                        logic.selectDiscountIn = select;
                                        logic.selectCouponType = select;
                                        logic.selectCouponForType = select;
                                        logic.couponNameCtrl.clear();
                                        logic.discountCtrl.clear();
                                        logic.maxDiscountCtrl.clear();
                                        logic.maxCartCtrl.clear();
                                        logic.minCartCtrl.clear();
                                        logic.useCountCtrl.clear();
                                        logic.perUseCountCtrl.clear();
                                        logic.descCtrl.clear();
                                        logic.filterStartDate = "";
                                        logic.filterExpireDate = "";
                                        logic.loadImage = false;
                                        logic.isRequiredLoader.value = false;
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
                                      child: WidgetText.widgetPoppinsMediumText(
                                        "Reset",
                                        Color(ORANGE),
                                        12,
                                      ),
                                    ),
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
        );
      })),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false,
      isDigit = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 2),
            child: WidgetText.widgetPoppinsText(lableText)),
        Container(
          margin: EdgeInsets.fromLTRB(10, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: name
                ? [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z 0-9 ]")),
                  ]
                : isDigit
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}')),
                        LengthLimitingTextInputFormatter(5)
                      ]
                    : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val)  {
              if(val.isEmpty){
                setState(() {
                  addCouponController.isRequiredLoader.value = false;
                  showToastMessage(reqFieldMsg);
                });
              }
            },
            onFieldSubmitted: (val) async {
              addCouponController.isRequiredLoader.value = await addCouponController.checkReqFields();
            },
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontPoppins,
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
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: InkWell(
        onTap: () {
          openGallery(addCouponController);
          // addCouponController.getFromGallery(context);
        },
        child: DottedBorder(
          color: Color(DARKGREY),
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          dashPattern: [4, 4],
          strokeWidth: 1,
          padding: EdgeInsets.all(5),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
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
