import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/rest_menu_view_controller.dart';

class OtherAddOnScreen extends StatefulWidget {
  bool isEditable;

  OtherAddOnScreen({required this.isEditable,});

  @override
  _OtherAddonsState createState() => _OtherAddonsState();
}

class _OtherAddonsState extends State<OtherAddOnScreen> {
  bool isEditable = false;
  final RestMenuViewController restMenuViewController = Get.put(
      RestMenuViewController());
  List<Map<String, dynamic>> mainList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isEditable = widget.isEditable;
    print('isEditable: $isEditable');
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
    calculateData();
  }

  calculateData() {
    for (int i = 0; i <
        (restMenuViewController.restMenuViewModel.data?.otherAddons?.length ??
            0); i++) {
      List<Map<String, dynamic>> subList = [];
      Map<String, dynamic> apiObject = <String, dynamic>{};
      apiObject["title"] =
          restMenuViewController.restMenuViewModel.data?.otherAddons?[i].title
              .toString() ?? "";
      for (int j = 0; j <
          (restMenuViewController.restMenuViewModel.data?.otherAddons?[i]
              .options.length ?? 0); j++) {
        Map<String, dynamic> optionsObject = <String, dynamic>{};
        optionsObject['option'] =
            restMenuViewController.restMenuViewModel.data?.otherAddons?[i]
                .options[j].option.toString() ?? "";
        subList.add(optionsObject);
        // print('subList: ${subList}');
        apiObject['options'] = subList;
      }
      mainList.add(apiObject);
      print('mainList: ${mainList}');
    }

    if ((restMenuViewController.restMenuViewModel.data?.otherAddons?.length ??
        0) == 0) {
      addEmptyList();
    }
  }

  void addEmptyList() {
    Map<String, dynamic> objEmpty = <String, dynamic>{};
    Map<String, dynamic> subObjEmpty = <String, dynamic>{};
    List<Map<String, dynamic>> optionsEmpty = [];

    subObjEmpty["option"] = "";
    objEmpty["title"] = "";
    setState(() {
      optionsEmpty.add(subObjEmpty);
      objEmpty["options"] = optionsEmpty;
      mainList.add(objEmpty);
    });
  }

  Widget getTextFormField(int index, String title, bool isReadOnly) {
    String textData = "";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            initialValue: title,
            readOnly: isReadOnly,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title'),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                textData = val;
                print('add data Index $index');
                mainList[index]['title'] = textData;
                print('mainList index after : ${ mainList[index]['title']}');
              });
              print('textData: $textData');
            },
          )),
          SizedBox(width: 10,),
          isEditable ?
          _addButton(index) : Container(),
          SizedBox(width: 5,),
          isEditable ?
          _removeButton(index) : Container(),
        ],
      ),
    );
  }

  Widget getSubTextFormField(int index, String option, int mainIndex,
      bool isReadOnly) {
    String subTextData = "";
    List<Map<String, dynamic>> optionsData = [];
    Map<String, dynamic> optionsObject = <String, dynamic>{};
    optionsObject['option'] = mainList[mainIndex]['options'];
    optionsData.add(optionsObject);

    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 40),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            initialValue: option,
            readOnly: isReadOnly,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option'),
            onChanged: (val) {
              setState(() {
                subTextData = val;
                print('textData: $subTextData');
                mainList[mainIndex]['options'][index]['option'] = subTextData;
                print(
                    'mainList index after : ${ mainList[mainIndex]['options']}');
              });
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Option is required';
              }
              return null;
            },
          ),),
          SizedBox(width: 10,),
          isEditable ?
          _addSubButton(mainIndex, index) : Container(),
          SizedBox(width: 5,),
          isEditable ?
          _removeSubButton(index, mainIndex) : Container(),
        ],
      ),
    );
  }

  Widget _addButton(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          addEmptyList();
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _removeButton(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (index > 0) {
            mainList.removeAt(index);
            print('remove');
          }
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.remove, color: Colors.white,),
      ),
    );
  }

  Widget _addSubButton(int index, int subIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          print('Index$index');
          Map<String, dynamic> subObjEmpty = <String, dynamic>{};
          List<Map<String, dynamic>> optionsEmpty = [];

          subObjEmpty["option"] = "";
          setState(() {
            optionsEmpty.addAll(mainList[index]['options']);
            optionsEmpty.add(subObjEmpty);
            mainList[index]['options'] = optionsEmpty;
          });
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _removeSubButton(int index, int mainIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          print('remove Index $mainIndex');
          print('mainList index: ${ mainList[mainIndex]['options']}');
          List<Map<String,
              dynamic>> optionsEmpty = mainList[mainIndex]['options'];
          // List<String> optionsEmpty = mainList[mainIndex]['options'];
          // optionsEmpty.removeAt(mainIndex);
          optionsEmpty.removeAt(index);
          mainList[mainIndex]['options'] = optionsEmpty;
          print('mainList index after : ${ mainList[mainIndex]['options']}');
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.remove, color: Colors.white,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: Obx(() {
        isEditable = restMenuViewController.isEditable.value;

        return Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    itemBuilder: (BuildContext context, int mainIndex) {
                      int optionLen = (mainList[mainIndex]['options']?.length ??
                          0);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTextFormField(
                            mainIndex, mainList[mainIndex]['title'] ?? "",
                            isEditable ? false : true,),

                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: optionLen,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context,
                                  int subIndex) {
                                return getSubTextFormField(subIndex,
                                  mainList[mainIndex]['options'][subIndex]['option'] ??
                                      "", mainIndex,
                                  isEditable ? false : true,);
                              })
                        ],
                      );
                    },
                  ),
                ),
                isEditable
                    ? Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      restMenuViewController.isMenuUpdated == false
                          ? InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            if (restMenuViewController
                                .restMenuViewModel
                                .data
                                ?.menuId != null) {
                              final params = jsonEncode({
                                HttpConstants
                                    .PARAMS_MENUID: restMenuViewController
                                    .restMenuViewModel
                                    .data
                                    ?.menuId,
                                HttpConstants
                                    .PARAMS_REST_OTHER_ADDONS: mainList,
                              });
                              print('mainparams: $params');
                              await restMenuViewController
                                  .updateMenuApi(params, isAdd: false);

                              if (restMenuViewController.isMenuUpdated ==
                                  true) {
                                var result = true;
                                print('Result => $result');
                                if (result) {
                                  setState(() {
                                    restMenuViewController
                                        .isMenuUpdated = false;
                                    // selectedEditMenuIndex = 1;
                                    Get.back();
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
                      ) : Center(
                        child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () {
                          setState(() {
                            mainList.clear();
                            Future.delayed(
                                const Duration(milliseconds: 100), () {
                              addEmptyList();
                            });
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
                          child: WidgetText
                              .widgetPoppinsMediumText(
                            "Reset",
                            Color(ORANGE),
                            14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : Container()
              ],
            ),
          ),
        );
      }),
    );
  }
}
