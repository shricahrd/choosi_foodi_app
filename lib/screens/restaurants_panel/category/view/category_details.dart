import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../controller/category_controller.dart';

class CategoryDetails extends StatefulWidget {
  String categoryId = "";

  CategoryDetails({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final CategoryController _categoryController = Get.put(CategoryController());
  // String createdDate = "";

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi(){
    setState(() {
      _categoryController.isDetailsLoaderVisible = true;
    });
    _categoryController.callGetCategoryDetailsAPI(widget.categoryId);
  }

  /*String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterShortMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context,details, true),
        body: SafeArea(
            child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<CategoryController>(builder: (logic) {

                      return
                        logic.isDetailsLoaderVisible
                            ? Center(
                          child: CircularProgressIndicator(
                            color: Color(ORANGE),
                          ),
                        ) : logic.categoryDetailsModel.meta?.status == false
                            ? Container(
                          child: Text('No Data Found'),
                        ) :
                        Container(
                        // margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        padding: EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Color(ORANGE), width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText
                                      .widgetPoppinsRegularText(
                                      "Category Image",
                                      Color(
                                          SUBTEXT),
                                      14),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ClipRRect(borderRadius:
                                  BorderRadius.circular(10.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/2.1,
                                      height: 100,
                                      child:
                                      imageFromNetworkCache(logic.categoryDetailsModel.data?.categoryImg.toString() ?? "",
                                          height: 100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          "Category Name: ", Color(SUBTEXT), 14),
                                      Flexible(
                                        child: WidgetText.widgetPoppinsMaxLineOverflowText(
                                            logic.categoryDetailsModel.data?.categoryName ?? "",
                                            Color(BLACK), 14, maxline: 2),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          "Status: ", Color(SUBTEXT), 14),
                                      WidgetText.widgetPoppinsRegularText(
                                          logic.categoryDetailsModel.data?.status  == 'DEACTIVE' ? 'INACTIVE' : 'ACTIVE',
                                          logic.categoryDetailsModel.data?.status == 'DEACTIVE'? Color(RED) :
                                          Color(GREEN), 14),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          "Created: ", Color(SUBTEXT), 14),
                                      WidgetText.widgetPoppinsRegularText(
                                          logic.createdDate, Color(BLACK), 14),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
        })));
  }
}
