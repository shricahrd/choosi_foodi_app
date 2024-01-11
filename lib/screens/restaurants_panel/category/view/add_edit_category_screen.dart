import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../controller/add_edit_category_controller.dart';

class AddEditCategoryScreen extends StatefulWidget {
  String categoryId = "";
  bool isEdit = false;
  AddEditCategoryScreen({Key? key,required this.categoryId,required this.isEdit}) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final AddEditCategoryController _addEditCategoryController = Get.put(AddEditCategoryController());
  bool isEditable = false;

  @override
  void initState() {
    isEditable = widget.isEdit;
    print('isEditable: $isEditable');
    if(isEditable == true){
      callEditApi();
    }
    super.initState();
  }

  callEditApi(){
    _addEditCategoryController.callGetCategoryDetailsAPI(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context,isEditable == true ? "Update Details" : "Add Details", true),
        body: SafeArea(
        child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet)):
                    GetBuilder<AddEditCategoryController>(builder: (logic) {
                      return Container(
                        padding: EdgeInsets.all(25),
                        child: ListView(
                          children: [
                            customTextInputField(
                              logic.categoryNameController,
                              "Enter Category Name",
                              "Category Name",
                              TextInputType.text,
                              TextInputAction.done,
                              false,
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 5,
                            ),
                            WidgetText
                                .widgetPoppinsRegularText(
                                "Category Image",
                                Color(
                                    SUBTEXT),
                                16),
                            SizedBox(
                              height: 20,
                            ),
                            logic.loadImage == true ?
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  logic.imagefile,
                                  height:
                                  MediaQuery.of(context).size.height /
                                      2.3,
                                  width: MediaQuery.of(context).size.width,
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
                            ):
                            logic.apiImage == "" ?
                            customUpload('Drag and Drop Your File(s) Here To Upload Or Click Here'):
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  logic.apiImage.toString(),
                                  height: MediaQuery.of(context).size.height / 2.3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Color(ORANGE),
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return customUpload('Click Here To Upload');
                                  },
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
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                logic.isCategoryLoader == false?
                                InkWell(
                                  onTap: ()  async {
                                    debugPrint('Response categoryNameController: ${logic.categoryNameController.text}');
                                    debugPrint('Response logic.loadImage: ${logic.loadImage}, logic.apiImage: ${logic.apiImage}');
                                    if( logic.categoryNameController.text.isNotEmpty) {
                                      if(logic.loadImage == true || logic.apiImage.toString().isNotEmpty) {
                                        if(isEditable == false) {
                                          await logic.addCategoryApi(
                                              logic.categoryNameController
                                                  .text);
                                          if(logic.metaModel.meta?.status == true){
                                            setState(() {
                                              Get.back(result: true);
                                            });
                                          } else {
                                            showToastMessage("${logic.metaModel.meta?.msg}");
                                          }
                                        }else{
                                          if(logic.loadImage == true) {
                                            await logic.updateCategoryApi(widget.categoryId, true);
                                          }else{
                                            await logic.updateCategoryApi(widget.categoryId, false);
                                          }
                                          if(logic.categoryDetailsModel.meta?.status == true) {
                                            setState(() {
                                              Get.back(result: true);
                                            });
                                          } else {
                                            showToastMessage("${logic.metaModel.meta?.msg}");
                                          }
                                        }
                                      }else{
                                        showToastMessage('Please Upload Photo');
                                      }
                                    }else{
                                      showToastMessage('Add Category Name first');
                                    }
                                    // logic.addCouponApi(logic.params);
                                  },
                                  child: Container(
                                    width: 120,
                                    padding:
                                    EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    decoration: BoxDecoration(
                                      color: Color(ORANGE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                    alignment: Alignment.center,
                                    child: WidgetText.widgetPoppinsMediumText(
                                      "Save",
                                      Color(WHITE),
                                      12,
                                    ),
                                  ),
                                )
                                    :  Center(
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
                                      logic.categoryNameController.clear();
                                      logic.loadImage = false;
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
                      );
                    });
                  })
        ));
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false,]) {
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
            inputFormatters: name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z 0-9 ]")), ] : [],
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

  Widget customUpload(
      String lableText,
      ) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: InkWell(
        onTap: (){
          _addEditCategoryController.onAttachFilePicker();
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
