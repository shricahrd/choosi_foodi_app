import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/rest_menu_view_controller.dart';

class AddOtherAddOnScreen extends StatefulWidget {

  @override
  _OtherAddonsState createState() => _OtherAddonsState();
}

class _OtherAddonsState extends State<AddOtherAddOnScreen> {
  final RestMenuViewController restMenuViewController = Get.put(RestMenuViewController());
  List<Map<String,dynamic>> mainList = [];
  final _formKey = GlobalKey<FormState>();
  var menuId;

  @override
  void initState() {
    menuId = restMenuViewController.addMenuModel.data?.menuId;
    print('MenuId: $menuId');
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
      addEmptyList();
  }

  void addEmptyList(){
    Map<String,dynamic> objEmpty = <String,dynamic>{};
    Map<String,dynamic> subObjEmpty = <String,dynamic>{};
    List<Map<String,dynamic>> optionsEmpty = [];

    subObjEmpty["option"] = "";
    objEmpty["title"] = "";
    setState(() {
      optionsEmpty.add(subObjEmpty);
      objEmpty["options"] = optionsEmpty;
      mainList.add(objEmpty);
    });
  }

  /* void addSubEmptyList(int index){

    Map<String,dynamic> subObjEmpty = <String,dynamic>{};
    // List<String> optionsEmpty = [""];
    List<Map<String,dynamic>> optionsEmpty = [];

    subObjEmpty["option"] = "";
    setState(() {
      optionsEmpty.addAll(mainList[index]['options']);
      optionsEmpty.add(subObjEmpty);
      optionsEmpty[index]["option"] = optionsEmpty;
      mainList[index]['options'] = optionsEmpty;
    });
  }
*/
  Widget getTextFormField(int index, String title){

    String textData = "";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            initialValue: title,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title'),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
            onChanged: (val){
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
          _addButton(index),
          SizedBox(width: 5,),
          _removeButton(index),
        ],
      ),
    );
  }

  Widget getSubTextFormField(int index,String option, int mainIndex){
    // List<String> optionsData = [];
    // optionsData.addAll(mainList[mainIndex]['options'][index]['option']);
    String subTextData = "";
    List<Map<String,dynamic>> optionsData = [];
    Map<String,dynamic> optionsObject = <String,dynamic>{};
    optionsObject['option'] = mainList[mainIndex]['options'];
    optionsData.add(optionsObject);

    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 40),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            initialValue: option,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option'),
            onChanged: (val){
              setState(() {
                subTextData = val;
                print('textData: $subTextData');
                mainList[mainIndex]['options'][index]['option'] = subTextData;
                print('mainList index after : ${ mainList[mainIndex]['options']}');
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
          _addSubButton(mainIndex, index),
          SizedBox(width: 5,),
          _removeSubButton(index,mainIndex),
        ],
      ),
    );
  }

  Widget _addButton( int index){
    return InkWell(
      onTap: (){
        setState(() {
          addEmptyList();
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color:  Colors.green ,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon( Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _removeButton(int index){
    return InkWell(
      onTap: (){
        setState(() {
          if(index >0) {
            mainList.removeAt(index);
            print('remove');
          }
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color:  Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.remove, color: Colors.white,),
      ),
    );
  }

  Widget _addSubButton(int index, int subIndex){
    return InkWell(
      onTap: (){
        setState(() {
          print('Index$index');
          Map<String,dynamic> subObjEmpty = <String,dynamic>{};
          List<Map<String,dynamic>> optionsEmpty = [];

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
          color:  Colors.green ,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon( Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _removeSubButton(int index, int mainIndex){
    return InkWell(
      onTap: (){
        setState(() {
          print('remove Index $mainIndex');
          print('mainList index: ${ mainList[mainIndex]['options']}');
          List<Map<String,dynamic>> optionsEmpty = mainList[mainIndex]['options'];
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
          color:  Colors.red,
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
      body: Form(
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

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTextFormField(mainIndex, mainList[mainIndex]['title'] ?? "" ),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: mainList[mainIndex]['options'].length ??0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int subIndex) {
                              return getSubTextFormField(subIndex, mainList[mainIndex]['options'][subIndex]['option'] ?? "",mainIndex);
                            }),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    restMenuViewController.isMenuUpdated == false
                        ? InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          if (menuId != null) {
                            final params = jsonEncode({
                              HttpConstants
                                  .PARAMS_MENUID: menuId,
                              HttpConstants.PARAMS_REST_OTHER_ADDONS: mainList,
                            });
                            print('mainparams: $params');
                            await restMenuViewController
                                .updateMenuApi(params, isAdd: false);

                            if (restMenuViewController.isMenuUpdated == true) {
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
                          }else{
                            showToastMessage('Please Add Data in General Info Tab');
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
                          Future.delayed(const Duration(milliseconds: 100), () {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
