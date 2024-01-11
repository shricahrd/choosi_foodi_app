import 'dart:convert';
import 'package:choosifoodi/core/widgets/widget_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/profile_rest_controller.dart';
import '../../controller/update_rest_profile_controller.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final VendorProfileGetController vendorProfileGetController =
      Get.put(VendorProfileGetController());
  final UpdateRestProfileController updateRestProfileController =
      Get.put(UpdateRestProfileController());

// create an instance
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();
  int selectedIndex = 0, selectedFoodTypeIndex = 0;
  List rootCategoryList = [];
  List subCategoryList = [];
  List foodTypeList = [];

  List<Map> availablefoodType = [
    {"name": "Vegetarian", "isChecked": false},
    {"name": "Vegan", "isChecked": false},
    {
      "name": "Pescatarian",
      "isChecked": false,
    },
    {"name": "Keto", "isChecked": false},
    {"name": "Dairy Free", "isChecked": false},
  ];

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      getCategory();
      getFoodTypeCheck();
    }
    super.initState();
  }

  getCategory() async {
    await vendorProfileGetController.getCategory();
    if (vendorProfileGetController.isCategoryLoaded == true) {
      getRootCategoryCheck();
      // getSubCategoryCheck();
    }
  }

  getFoodTypeCheck() {
    print('Inside foodcheck');
    print(
        'food len : ${vendorProfileGetController.vendorProfileModel.data?.restaurant?.foodTypes?.length}');
    print('available foodType len : ${availablefoodType.length}');
    for (int j = 0; j < availablefoodType.length; j++) {
      for (int i = 0;
          i <
              (vendorProfileGetController
                      .vendorProfileModel.data?.restaurant?.foodTypes?.length ??
                  0);
          i++) {
        if (vendorProfileGetController
                .vendorProfileModel.data?.restaurant?.foodTypes?[i] ==
            availablefoodType[j]['name']) {
          availablefoodType[j]["isChecked"] = true;
        }
      }
    }
  }

  getRootCategoryCheck() {
    var categoryLen = vendorProfileGetController.categoryModel.data?.length;
    if (categoryLen != null) {
      for (int i = 0; i < categoryLen; i++) {
        if (vendorProfileGetController
            .vendorProfileModel.data!.restaurant!.rootCategoryIds!
            .contains(
                vendorProfileGetController.categoryModel.data?[i].categoryId)) {
          setState(() {
            vendorProfileGetController.categoryModel.data?[i].setRootChecked =
                true;
            print('Match');
          });
        }
      }
    }
  }

/*  getSubCategoryCheck() {
    print('In SubCategory');
    var categoryLen = vendorProfileGetController.categoryModel.data?.length;
    print('CategoryLen: $categoryLen');
    if (categoryLen != null) {
      for (int i = 0; i < categoryLen; i++) {
        var subcategoryLen = vendorProfileGetController
            .categoryModel.data?[i].subcategory?.length;
        print('Sub CategoryLen: ${subcategoryLen}');
        for (int j = 0; j < subcategoryLen!; j++) {
          if (vendorProfileGetController
              .vendorProfileModel.data!.restaurant!.categoryIds!
              .contains(vendorProfileGetController
                  .categoryModel.data?[i].subcategory?[j].categoryId)) {
            print('Sub Category Match');
            setState(() {
              vendorProfileGetController.categoryModel.data?[i].subcategory?[j]
                  .setSubCategoryChecked = true;
            });
          }
        }
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        body: SafeArea(
            child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: WidgetText.widgetPoppinsMediumText(
                            category, Color(BLACK), 18),
                      ),
                    ),
                    GetBuilder<VendorProfileGetController>(builder: (logic) {
                      return logic.isCategoryLoaded == true
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: logic.categoryModel.data?.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (selectedIndex == index) {
                                            selectedIndex = -1;
                                          } else {
                                            selectedIndex = index;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (logic
                                                          .categoryModel
                                                          .data?[index]
                                                          .isCheckedRoot ==
                                                      true) {
                                                    logic
                                                        .categoryModel
                                                        .data?[index]
                                                        .setRootChecked = false;
                                                    print('UnCheck');
                                                  } else {
                                                    logic
                                                        .categoryModel
                                                        .data?[index]
                                                        .setRootChecked = true;
                                                  }
                                                  print(
                                                      'checked:this ${logic.categoryModel.data?[index].isCheckedRoot}');
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  WidgetCheckBox
                                                      .widgetCheckBoxText(logic
                                                                  .categoryModel
                                                                  .data?[index]
                                                                  .isCheckedRoot ==
                                                              true
                                                          ? true
                                                          : false),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    logic
                                                            .categoryModel
                                                            .data?[index]
                                                            .categoryName
                                                            .toString() ??
                                                        "",
                                                    // categoryName[index],
                                                    // "Sandip",
                                                    Color(BLACK),
                                                    16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  color: Color(ORANGE)));
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    // foodTypeWidget(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: WidgetText.widgetPoppinsMediumText(
                            dietrySpec, Color(BLACK), 18),
                      ),
                    ),

                    Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: availablefoodType.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    availablefoodType[index]["isChecked"] = !availablefoodType[index]["isChecked"];
                                  });
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      WidgetCheckBox.widgetCheckBoxText(availablefoodType[index]['isChecked'] == true
                                          ? true
                                          : false),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                        availablefoodType[index]['name'].toString(),
                                        // categoryName[index],
                                        // "Sandip",
                                        Color(BLACK),
                                        16,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),

                    updateRestProfileController.isLoaderVisible == false
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      for (int i = 0;
                                          i < availablefoodType.length;
                                          i++) {
                                        if (availablefoodType[i]["isChecked"] ==
                                            true) {
                                          foodTypeList.add(
                                              availablefoodType[i]["name"]);
                                        }
                                      }
                                      var rootLength =
                                          vendorProfileGetController
                                              .categoryModel.data?.length;
                                      if (rootLength != null) {
                                        for (int i = 0; i < rootLength; i++) {
                                          if (vendorProfileGetController
                                                  .categoryModel
                                                  .data![i]
                                                  .isCheckedRoot ==
                                              true) {
                                            rootCategoryList.add(
                                                vendorProfileGetController
                                                    .categoryModel
                                                    .data![i]
                                                    .categoryId);
                                          }
                                        }
                                      }
                                      final params = jsonEncode({
                                        HttpConstants.PARAMS_ROOTCATEGORYID:
                                            rootCategoryList,
                                        HttpConstants.PARAMS_FOODTYPES:
                                            foodTypeList,
                                      });
                                      setState(() {
                                        updateRestProfileController
                                            .isLoaderVisible = true;
                                      });
                                      await updateRestProfileController
                                          .updateProfileApi(
                                              params: params,
                                              image: false,
                                              imageKey1: "");
                                      if (updateRestProfileController
                                              .isLoaderVisible ==
                                          true) {
                                        var result = true;
                                        print('Result => $result');
                                        if (result) {
                                          setState(() {
                                            updateRestProfileController
                                                .isLoaderVisible = false;
                                            Navigator.of(context).pop();
                                          });
                                        }
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
                                        "Submit",
                                        Color(WHITE),
                                        14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        availablefoodType.forEach((item) =>
                                            item["isChecked"] = false);
                                        vendorProfileGetController
                                            .categoryModel.data
                                            ?.forEach((item) =>
                                                item.setRootChecked = false);
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
                                        14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          ),
                  ],
                ));
        })));
  }
}
