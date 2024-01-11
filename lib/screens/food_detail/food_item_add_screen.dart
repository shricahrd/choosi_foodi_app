import 'dart:convert';

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_round_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../restaurant_details/controller/restaurant_details_controller.dart';
import '../restaurant_details/model/post_food_model.dart';
import '../restaurant_details/model/restaurant_details_model.dart';

class FoodItemAddScreen extends StatefulWidget {

   List<OtherAddonsItem>? otherAddonsList;
   String foodTitle;
  dynamic menuId, selectQty, restId;

   FoodItemAddScreen({Key? key, required this.foodTitle, required this.otherAddonsList,
     required this.menuId,  required this.selectQty, required this.restId, })
      : super(key: key);

  @override
  _FoodItemAddScreenState createState() =>
      _FoodItemAddScreenState(otherAddonsList!);
}

class _FoodItemAddScreenState extends State<FoodItemAddScreen> {
  final RestaurantDetailsController restController =
  Get.put(RestaurantDetailsController());
  List<OtherAddonsItem> otherAddonsList = [];
  int _proteinValue = 0;
  int _sauceChoices = 0;
  bool isAddToCart = false;

  _FoodItemAddScreenState( List<OtherAddonsItem> otherAddonsList) {
    this.otherAddonsList = otherAddonsList;
  }

  List<PostFoodModel> postFoodModel= [];


  @override
  void initState() {
  print('otherAddonsList: ${otherAddonsList.length}');
  print('item init ====> : ${jsonEncode(postFoodModel.map((data) => data.toMap()).toList())}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Food items",
                  Color(BLACK),
                  18,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: WidgetText.widgetPoppinsRegularText(
                    // "Food Item Title",
                    widget.foodTitle,
                    Color(BLACK),
                    20,
                  ),
                ),
              /*  Center(
                  child: WidgetText.widgetPoppinsRegularText(
                    "lorem ipsum dolor sit amet",
                    Color(DARKGREY),
                    15,
                  ),
                ),*/

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: otherAddonsList.length,
                  itemBuilder: (context, index) {

                    List<OptionsItem>? optionList = [];
                    optionList = otherAddonsList[index].options;

                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Align(
                            child: WidgetText.widgetPoppinsRegularText(
                              // "Protein Option",
                              otherAddonsList[index].title,
                              Color(BLACK),
                              20,
                            ),
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          WidgetText.widgetPoppinsRegularText(
                            "Select 1",
                            Color(SUBTEXT),
                            16,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: optionList?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child:  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for(int i=0; i<(optionList?.length ?? 0); i++) {
                                          if (optionList![i].isSelect == true) {
                                            optionList[i].setCheckedOption = false;
                                          }
                                        }
                                        optionList![index].setCheckedOption = true;
                                       /* if(optionList[index].isSelect == true){
                                          postFoodModel.add(PostFoodModel(title: otherAddonsList[index].title,option: optionList[index].option ));
                                          print('item before reverse ====> : ${jsonEncode(postFoodModel.map((data) => data.toMap()).toList())}');
                                        }*/
                                      });
                                    },
                                    child:
                                    optionList![index].isSelect
                                        ? WidgetRoundRadioButton.selectRadioButton(
                                        // "Veggie"
                                      optionList[index].option,
                                    )
                                        : WidgetRoundRadioButton
                                        .unselectedRoundRadioButton(
                                      optionList[index].option,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*WidgetText.widgetPoppinsRegularText(
                        "All Special Instructions",
                        Color(BLACK),
                        18,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Add any instructions for your order here...",
                        Color(BLACK),
                        14,
                      ),
                      SizedBox(
                        height: 15,
                      ),*/
                      isAddToCart == true ? Center(
                        child:
                        CircularProgressIndicator(
                          color:
                          Color(ORANGE),
                        ),
                      ) :
                      InkWell(
                        onTap: () async {

                          for(int i=0; i<otherAddonsList.length; i++){
                            for(int j=0; j<(otherAddonsList[i].options?.length ?? 0) ; j++) {
                              if (otherAddonsList[i].options?[j].isSelect == true) {
                                postFoodModel.add(PostFoodModel(title: otherAddonsList[i].title,
                                    option: otherAddonsList[i].options?[j].option ?? ""));
                                print('item before reverse ====> : ${jsonEncode(
                                    postFoodModel.map((data) => data.toMap()).toList())}');
                              }
                            }
                          }
                          setState(() {
                            isAddToCart = true;
                          });
                          await restController.postAddCardApi(restId: widget
                              .restId.toString(),
                              menuId: widget.menuId.toString(),selectQty: widget.selectQty, isAddOn: true, otherAddList: postFoodModel);
                          setState(() {
                            isAddToCart = false;
                            Navigator.of(context).pop(true);
                          });
                        },
                        child: Container(
                          width: 130,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                            color: Color(ORANGE),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          alignment: Alignment.center,
                          child: WidgetText.widgetPoppinsMediumText(
                            "Add to order",
                            Color(WHITE),
                            14,
                          ),
                        ),
                      ) ,
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClickAddToOrder() {
    Navigator.of(context).pop(true);
  }
}
