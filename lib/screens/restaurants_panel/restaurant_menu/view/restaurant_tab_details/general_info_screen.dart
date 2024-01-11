import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';
import 'package:intl/intl.dart';

class GeneralInfoScreen extends StatefulWidget {
  bool isEditable;
  Function moveToImageTab;

  GeneralInfoScreen(
      {Key? key, required this.isEditable, required this.moveToImageTab})
      : super(key: key);

  @override
  State<GeneralInfoScreen> createState() => _GeneralInfoScreenState(isEditable);
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  late bool isEditable;

  _GeneralInfoScreenState(bool isEditable) {
    this.isEditable = isEditable;
  }

  final RestMenuViewController restMenuViewController =
  Get.put(RestMenuViewController());
  String? selectFoodType = "Select";
  String? selectdishType = "Select";
  var startDate, endDate;

  List foodType = [
    'Select',
    'Vegetarian',
    'Vegan',
    'Pescatarian',
    'Keto',
    'Dairy Free'
  ];
  List dishType = [
    'Select',
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  Future<void> displayTimeDialogStart() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        restMenuViewController.dishVisibilityStart = time.format(context);
        var convertDate = DateFormat("h:mm").parse(
            restMenuViewController.dishVisibilityStart);
        startDate = DateFormat().add_Hm().format(convertDate);
        print('cDate: $startDate');
      });
    }
  }

  Future<void> displayTimeDialogEnd() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        restMenuViewController.dishVisibilityEnd = time.format(context);
        var convertDate1 = DateFormat("h:mm").parse(
            restMenuViewController.dishVisibilityEnd);
        print('convertDate: $convertDate1');
        endDate = DateFormat().add_Hm().format(convertDate1);
        print('endDate: $endDate');
      });
    }
  }

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    print('isEditable: $isEditable');
    if (restMenuViewController.foodTypeController.text.isNotEmpty) {
      if (restMenuViewController.foodTypeController.text != null) {
        for (int i = 0; i < foodType.length; i++) {
          if (restMenuViewController.foodTypeController.text == foodType[i]) {
            selectFoodType = restMenuViewController.foodTypeController.text;
          }
        }
      }
    }

    if (restMenuViewController.dishTypeController.text.isNotEmpty) {
      if (restMenuViewController.dishTypeController.text != null) {
        for (int i = 0; i < dishType.length; i++) {
          if (restMenuViewController.dishTypeController.text == dishType[i]) {
            selectdishType = restMenuViewController.dishTypeController.text;
          }
        }
      }
    }

    // startDate = restMenuViewController.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child:
                GetBuilder<GetXNetworkManager>(builder: (networkManager) {
                  return networkManager.connectionType == 0
                      ? Center(
                      child: Text(check_internet)) :
                  Obx(() {

                    isEditable = restMenuViewController.isEditable.value;

                    return Container(
                      padding: EdgeInsets.all(25),
                      width: double.infinity,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          customTextInputField(
                            restMenuViewController.dishNameController,
                            "Enter Dish Name",
                            "Dish Name",
                            TextInputType.text,
                            TextInputAction.next,
                            isEditable ? false : true,
                          ),
                          Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(DIVIDERCOLOR)),
                          SizedBox(
                            height: 10,
                          ),
                          isEditable == false ?
                          Column(
                            children: [
                              customTextInputField(
                                restMenuViewController.foodTypeController,
                                dietrySpec,
                                dietrySpec,
                                TextInputType.text,
                                TextInputAction.next,
                                isEditable ? false : true,
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ) : Container(),
                          isEditable == true ?
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsText(dietrySpec),
                                    DropdownButton(
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
                                        selDietrySpec,
                                        Color(BLACK),
                                        18,
                                      ),
                                      value: selectFoodType == "Select"
                                          ? foodType[0].toString()
                                          : selectFoodType,
                                      style: TextStyle(
                                        color: Color(BLACK),
                                        fontSize: 16,
                                        fontFamily: FontPoppins,
                                        fontWeight: PoppinsRegular,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectFoodType = value.toString();
                                          restMenuViewController
                                              .foodTypeController
                                              .text = value.toString();
                                          restMenuViewController
                                              .restMenuViewModel
                                              .data!
                                              .setFoodType =
                                              selectFoodType.toString();
                                          // controller.text = value.toString();
                                        });
                                      },
                                      items: foodType.map((dynamic value) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Color(BLACK),
                                              fontSize: 16,
                                              fontFamily: FontPoppins,
                                              fontWeight: RobotoMedium,
                                            ),
                                          ),
                                          value: value,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ) : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          isEditable == false ?
                          customPriceTextInputField(
                            "Price",
                            "\$${restMenuViewController.priceController.text
                                .toString()}",
                          ) : customTextInputField(
                              restMenuViewController.priceController,
                              "Enter Price",
                              "Price",
                              TextInputType.number,
                              TextInputAction.next,
                              isEditable ? false : true,
                              true
                          ),
                          Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(DIVIDERCOLOR)),
                          SizedBox(
                            height: 10,
                          ),
                          _descWidget(
                            'Description',
                            restMenuViewController.descriptionController,
                            isEditable ? false : true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          isEditable == false ?
                          Column(
                            children: [
                              customTextInputField(
                                restMenuViewController.dishTypeController,
                                "Select Dish Type",
                                "Dish Type",
                                TextInputType.text,
                                TextInputAction.next,
                                isEditable ? false : true,
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ) : Container(),
                          isEditable == true ?
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsText('Dish Type'),
                                    DropdownButton(
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
                                        "Select Dish Type",
                                        Color(BLACK),
                                        18,
                                      ),
                                      value: selectdishType == "Select"
                                          ? dishType[0].toString()
                                          : selectdishType,
                                      style: TextStyle(
                                        color: Color(BLACK),
                                        fontSize: 16,
                                        fontFamily: FontPoppins,
                                        fontWeight: PoppinsRegular,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectdishType = value.toString();
                                          restMenuViewController
                                              .dishTypeController
                                              .text = value.toString();
                                        });
                                      },
                                      items: dishType.map((dynamic value) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Color(BLACK),
                                              fontSize: 16,
                                              fontFamily: FontPoppins,
                                              fontWeight: RobotoMedium,
                                            ),
                                          ),
                                          value: value,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(DIVIDERCOLOR)),
                            ],
                          ) : Container(),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: WidgetText.widgetPoppinsRegularText(
                              'Dish Visibility',
                              Color(0xff848383),
                              16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          restMenuViewController.dishVisibilityStart == ""
                              ? _timeFieldWidget('12:33 PM', '12:33 PM')
                              : _timeFieldWidget(
                              restMenuViewController
                                  .dishVisibilityStart,
                              restMenuViewController.dishVisibilityEnd),
                          SizedBox(
                            height: 20,
                          ),
                          isEditable
                              ? Row(
                            children: [
                              restMenuViewController.isMenuUpdated ==
                                  false
                                  ? InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (startDate == null) {
                                      startDate = restMenuViewController
                                          .dishVisibilityStart;
                                    }

                                    if (endDate == null) {
                                      endDate = restMenuViewController
                                          .dishVisibilityEnd;
                                    }
                                  });


                                  if (selectdishType !=
                                      "Select") {
                                    final params = {
                                      HttpConstants.PARAMS_MENUID:
                                      restMenuViewController
                                          .restMenuViewModel
                                          .data
                                          ?.menuId,
                                      HttpConstants
                                          .PARAMS_DISHNAME:
                                      restMenuViewController
                                          .dishNameController
                                          .text,
                                      HttpConstants
                                          .PARAMS_PRICE:
                                      restMenuViewController
                                          .priceController
                                          .text,
                                      HttpConstants
                                          .PARAMS_DESCIPTION:
                                      restMenuViewController
                                          .descriptionController
                                          .text,
                                      HttpConstants
                                          .PARAMS_DISH_TYPE:
                                      selectdishType,
                                      HttpConstants
                                          .PARAMS_DISHVISIBLE_START:
                                      startDate,
                                      HttpConstants
                                          .PARAMS_DISHVISIBLE_END:
                                      endDate,
                                    };
                                    print('Params: ${params}');

                                    if (selectFoodType != "Select") {
                                      params[HttpConstants.PARAMS_FOODTYPE] =
                                          selectFoodType;
                                    }


                                    await restMenuViewController.updateMenuApi(
                                        jsonEncode(params), isAdd: false);

                                    if (restMenuViewController.isMenuUpdated ==
                                        true) {
                                      var result = true;
                                      print('Result => $result');
                                      if (result) {
                                        setState(() {
                                          restMenuViewController
                                              .getMenuDetailsApi(
                                              restMenuViewController
                                                  .restMenuViewModel.data!
                                                  .menuId.toString());
                                          restMenuViewController.isMenuUpdated =
                                          false;
                                          widget.moveToImageTab();
                                        });
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      restMenuViewController.isMenuUpdated =
                                      false;
                                      showToastMessage(selDishTypeTxt);
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
                                child:
                                CircularProgressIndicator(
                                  color: Color(ORANGE),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    restMenuViewController
                                        .dishNameController
                                        .clear();
                                    restMenuViewController
                                        .priceController
                                        .clear();
                                    restMenuViewController
                                        .descriptionController
                                        .clear();
                                    restMenuViewController
                                        .dishVisibilityStart = "";
                                    restMenuViewController
                                        .dishVisibilityEnd = "";
                                    selectFoodType = "Select";
                                    selectdishType = "Select";
                                    startDate = "";
                                    endDate = "";
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  padding: EdgeInsets.fromLTRB(
                                      0, 10, 0, 10),
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Color(ORANGE),
                                        width: 1),
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
                    );
                  });
                }))
          ],
        ),
      ),
    );
  }

  Widget _descWidget(String title,
      TextEditingController controller,
      bool isReadOnly,) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child:
            WidgetText.widgetPoppinsText(title),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              textAlign: TextAlign.left,
              maxLines: 4,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xff848383),
                  fontSize: 16,
                  fontFamily: FontPoppins,
                  fontWeight: RobotoMedium,
                ),
                hintText: title,
              ),
              style: TextStyle(
                color: Color(BLACK),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: RobotoMedium,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
        ],
      ),
    );
  }

  Widget _timeFieldWidget(String title, String title2) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15),
                  child:
                  WidgetText.widgetPoppinsText('Start'),
                ),
                InkWell(
                  onTap: () {
                    if (isEditable) {
                      displayTimeDialogStart();
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          title,
                          Color(BLACK),
                          16,
                        ),
                        Image.asset(
                          ic_timer_icon,
                          height: 20,
                          width: 20,
                          color: Color(BLACK),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 25),
                  child:
                  WidgetText.widgetPoppinsText('End'),
                ),
                InkWell(
                  onTap: () {
                    if (isEditable) {
                      displayTimeDialogEnd();
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          title2,
                          Color(BLACK),
                          16,
                        ),
                        Image.asset(
                          ic_timer_icon,
                          height: 20,
                          width: 20,
                          color: Color(BLACK),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      bool isReadOnly, [bool price = false,]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child:
            WidgetText.widgetPoppinsText(lableText)
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            readOnly: isReadOnly,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters:
            price ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(5),
            ] : [],
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

  Widget customPriceTextInputField(String lableText, String value,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child:
            WidgetText.widgetPoppinsText(lableText)
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: Text(value.toString(), style: TextStyle(
            color: Color(BLACK),
            fontSize: 18,
            fontFamily: FontPoppins,
            fontWeight: PoppinsMedium,
          ),),
        )
      ],
    );
  }

}
