import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../controller/rest_menu_view_controller.dart';
import 'package:intl/intl.dart';

class AddGeneralInfoScreen extends StatefulWidget {
  Function moveToImageTab;
   AddGeneralInfoScreen({Key? key, required this.moveToImageTab}) : super(key: key);

  @override
  State<AddGeneralInfoScreen> createState() => _AddGeneralInfoScreenState();
}

class _AddGeneralInfoScreenState extends State<AddGeneralInfoScreen> {
  final RestMenuViewController restMenuViewController = Get.put(RestMenuViewController());
  TextEditingController foodTypeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dishTypeController = new TextEditingController();
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
        // print('dish start: ${restMenuViewController.dishVisibilityStart}');
        var convertDate = DateFormat("h:mm").parse(restMenuViewController.dishVisibilityStart.toString());
        // print('convertDate: $convertDate');
        startDate = DateFormat().add_Hm().format(convertDate);
        print('cDate: $startDate');
      });
    }
  }

  Future<void> displayTimeDialogEnd() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    print('time: $time');
    if (time != null) {
      setState(() {
        restMenuViewController.dishVisibilityEnd = time.format(context);
        // print('dish end: ${restMenuViewController.dishVisibilityEnd}');
        var convertDate1 = DateFormat("h:mm").parse(restMenuViewController.dishVisibilityEnd);
        // print('convertDate: $convertDate1');
        endDate = DateFormat().add_Hm().format(convertDate1);
        print('endDate: $endDate');
      });
      }
  }

  @override
  void initState() {
    restMenuViewController.isMenuUpdated = false;
    if(restMenuViewController.foodTypeController.text.isNotEmpty){
      if(restMenuViewController.foodTypeController.text != null){
        for(int i=0; i<foodType.length; i++) {
          if(restMenuViewController.foodTypeController.text == foodType[i]){
            selectFoodType = restMenuViewController.foodTypeController.text;
          }
        }
      }
    }

    if(restMenuViewController.dishTypeController.text.isNotEmpty){
      if(restMenuViewController.dishTypeController.text != null){
        for(int i=0; i<dishType.length; i++) {
          if(restMenuViewController.dishTypeController.text == dishType[i]){
            selectdishType = restMenuViewController.dishTypeController.text;
          }
        }
      }
    }
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
                Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      customTextInputField(
                        restMenuViewController.dishNameController,
                        "Enter Dish Name",
                        "Dish Name", TextInputType.text,
                        TextInputAction.next,
                        true
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
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
                                visible: true, child: Image.asset(
                                ic_down_arrow,
                                height: 10,
                                width: 20,
                                color: Color(BLACK),
                              ),),
                              isExpanded: true,
                              hint: WidgetText.widgetPoppinsRegularText(
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
                                  restMenuViewController.foodTypeController
                                      .text = value.toString();
                                  // controller.text = value.toString();
                                });
                              },
                              items: foodType
                                  .map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Color(BLACK),
                                      fontSize: 16,
                                      fontFamily: FontPoppins,
                                      fontWeight: RobotoMedium,),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextInputField(
                        restMenuViewController.priceController,
                        "Enter Price",
                        "Price", TextInputType.number,
                        TextInputAction.next,
                        false, true
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      _descWidget('Description','Enter Description',
                          restMenuViewController.descriptionController),
                      SizedBox(
                        height: 10,
                      ),
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
                                ),),
                              isExpanded: true,
                              hint: WidgetText.widgetPoppinsRegularText(
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
                                  restMenuViewController.dishTypeController
                                      .text = value.toString();
                                });
                              },
                              items: dishType
                                  .map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Color(BLACK),
                                      fontSize: 16,
                                      fontFamily: FontPoppins,
                                      fontWeight: RobotoMedium,),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
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
                      _timeFieldWidget(
                          restMenuViewController.dishVisibilityStart,
                          restMenuViewController.dishVisibilityEnd),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          restMenuViewController.isMenuAdded == false ?
                          InkWell(
                            onTap: () async {
                              if (restMenuViewController.dishNameController.text
                                  .isNotEmpty &&
                                  restMenuViewController.priceController.text
                                      .isNotEmpty &&
                                  restMenuViewController.descriptionController
                                      .text.isNotEmpty &&
                                  restMenuViewController.dishVisibilityStart !=
                                      "" &&
                                  restMenuViewController.dishVisibilityEnd !=
                                      "") {
                                if (selectdishType != "Select") {
                                  setState(() {
                                    restMenuViewController.isMenuAdded = true;
                                  });


                                  await restMenuViewController.addMenuApi(
                                    dishName: restMenuViewController
                                        .dishNameController.text,
                                    dishType: selectdishType.toString(),
                                    foodType: selectFoodType.toString(),
                                    description: restMenuViewController
                                        .descriptionController.text,
                                    price: restMenuViewController
                                        .priceController
                                        .text,
                                    dishVisibilityStart: startDate.toString(),
                                    dishVisibilityEnd: endDate.toString(),);

                                  if (restMenuViewController.isMenuAdded ==
                                      true) {
                                    var result = true;
                                    print('Result => $result');
                                    if (result) {
                                      setState(() {
                                        restMenuViewController.isMenuAdded =
                                        false;
                                        var menuId = restMenuViewController
                                            .addMenuModel.data?.menuId;
                                        print('MenuId: $menuId');
                                        widget.moveToImageTab();
                                      });
                                    } else {
                                      setState(() {
                                        restMenuViewController.isMenuAdded =
                                        false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      restMenuViewController.isMenuAdded =
                                      false;
                                    });
                                  }
                                } else {
                                  showToastMessage("Please Select Type");
                                }
                              } else {
                                showToastMessage(
                                    "Please Enter Data in All Fields");
                              }
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(
                                color: Color(ORANGE),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                BorderRadius.all(Radius.circular(7)),
                              ),
                              alignment: Alignment.center,
                              child: WidgetText.widgetPoppinsMediumText(
                                "Submit",
                                Color(WHITE),
                                14,
                              ),
                            ),
                          ) : Center(child: CircularProgressIndicator(
                            color: Color(ORANGE),),),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                restMenuViewController.dishNameController
                                    .clear();
                                restMenuViewController.priceController.clear();
                                restMenuViewController.descriptionController
                                    .clear();
                                restMenuViewController.dishVisibilityStart = "";
                                restMenuViewController.dishVisibilityEnd = "";
                                selectFoodType = "Select";
                                selectdishType = "Select";
                                startDate = "";
                                endDate = "";
                              });
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                shape: BoxShape.rectangle,
                                border:
                                Border.all(color: Color(ORANGE), width: 1),
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
                );
              })
            ),
          ],
        ),
      ),
    );
  }

  Widget _descWidget(String title, String hint, TextEditingController controller) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: WidgetText.widgetRobotoRegularText(
              title,
              Color(0xff848383),
              18,
              align: TextAlign.end,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.left,
              maxLines: 4,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xff848383),
                  fontSize: 16,
                  fontFamily: FontPoppins,
                  fontWeight: PoppinsRegular,
                ),
                hintText: hint,
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
            height: 10,
          ),
       /*   Image.asset(
            ic_paragraph,
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 10,
          ),*/
          Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
        ],
      ),
    );
  }

  Widget _timeFieldWidget(String title, String title2) {
    return
    Container(
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
                      displayTimeDialogStart();
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
                      displayTimeDialogEnd();
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
      String hintText, String lableText, TextInputType? keyboardType, TextInputAction? textInputAction,
      [bool name = false, bool price = false, ]) {
    // final LoginController loginController = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
          child: WidgetText.widgetPoppinsText(lableText)
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
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] :
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
}
