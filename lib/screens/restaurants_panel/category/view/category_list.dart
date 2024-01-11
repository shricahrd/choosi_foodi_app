import 'package:choosifoodi/core/utils/app_strings_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../controller/category_controller.dart';
import 'add_edit_category_screen.dart';
import 'category_details.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String createdDate = "";
  final CategoryController _categoryController = Get.put(CategoryController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  TextEditingController searchMenuController = new TextEditingController();
  String? selectStatus = "Choose Status";
  List statusList = [
    'Choose Status',
    'Active',
    'Inactive',
  ];

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      _categoryController.getCategoryListApi(status: "", search: "");
    }
    super.initState();
  }

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,category, true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
            return networkManager.connectionType == 0
                ? Center(child: Text(check_internet))
                : Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: WidgetButton.widgetDefaultButton(
                      addCategory, () async {
                       await  Get.to(()=> AddEditCategoryScreen(categoryId: "",isEdit: false,));
                       _categoryController.getCategoryListApi(status: "", search: "");
                  }),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        // color: Color(WHITE),
                        elevation: 5.0,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        shadowColor: Color(BLACK),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(WHITE),
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(10),
                            icon: Visibility(
                              visible: true,
                              child: Image.asset(
                                ic_down_arrow,
                                height: 10,
                                width: 20,
                                color: Color(DARKGREY),
                              ),
                            ),
                            isExpanded: true,
                            value: selectStatus == "Choose Status"
                                ? statusList[0].toString()
                                : selectStatus,
                            style: TextStyle(
                              color: Color(BLACK),
                              fontSize: 16,
                              fontFamily: FontPoppins,
                              fontWeight: PoppinsRegular,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectStatus = value.toString();
                                // controller.text = value.toString();
                                print('selectStatus : ${selectStatus}');
                                if (selectStatus == "Choose Status") {
                                  _categoryController.getCategoryListApi(
                                      status: "", search: "");
                                } else {
                                  _categoryController.getCategoryListApi(
                                      status: selectStatus.toString(),
                                      search: "");
                                }
                              });
                            },
                            items: statusList.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectStatus == "Choose Status"
                                        ? Color(HINTCOLOR)
                                        : Color(BLACK),
                                    fontSize: 14,
                                    fontFamily: FontRoboto,
                                    fontWeight: RobotoRegular,
                                  ),
                                ),
                                value: value,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          color: Color(WHITE),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          shadowColor: Color(BLACK),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: TextFormField(
                              controller: searchMenuController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: InkWell(
                                  child:
                                  Icon(Icons.search, color: Color(HINTCOLOR)),
                                  onTap: () {
                               /*     _categoryController.getCategoryListApi(
                                        status: selectStatus.toString(),
                                        search: searchMenuController.text);*/
                                  },
                                ),
                                hintStyle: TextStyle(
                                  color: Color(HINTCOLOR),
                                  fontSize: 16,
                                  fontFamily: FontRoboto,
                                  fontWeight: RobotoRegular,
                                ),
                                hintText: "Search",
                              ),
                              onChanged: (val) {
                                print('SearchKey: $val');
                                if (val == "") {
                                  _categoryController.getCategoryListApi(
                                      status: "",
                                      search: searchMenuController.text);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                } else {
                                  print('Search Complete: ${searchMenuController.text}');
                                  _categoryController.getCategoryListApi(
                                      status: "",
                                      search: searchMenuController.text);
                                }
                              },
                              onEditingComplete: () {
                                print(
                                    'Search Complete: ${searchMenuController.text}');
                             /*   restMenuController.getMenuListApi(
                                    status: "",
                                    search: searchMenuController.text);*/
                              },
                              style: TextStyle(
                                color: Color(BLACK),
                                fontSize: 16,
                                fontFamily: FontRoboto,
                                fontWeight: RobotoMedium,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                GetBuilder<CategoryController>(builder: (logic) {
                  return logic.isLoaderVisible
                      ? Center(
                    child: CircularProgressIndicator(
                      color: Color(ORANGE),
                    ),
                  )
                      : logic.categoryListModel.meta?.status == false
                      ? Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text('No Category Found'),
                  )
                      : Expanded(
                    child: Container(
                      height: 210,
                      width: double.infinity,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: logic.categoryListModel.data?.length,
                          itemBuilder: (context, index) {
                            int seriolNo = index + 1;
                            print('Status: ${seriolNo}');

                            if(logic.categoryListModel.data?[index].createdAt == 0){
                              createdDate = "";
                            }else {
                              parseTimeCreated(int.parse(logic.categoryListModel.data![index].createdAt.toString()));
                            }

                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    15, 15, 15, 15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Color(ORANGE),
                                      width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              WidgetText
                                                  .widgetPoppinsRegularText(
                                                  "Category Image",
                                                  Color(
                                                      SUBTEXT),
                                                  14),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ClipRRect(borderRadius:
                                              BorderRadius.circular(10.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width/2.1,
                                                  height: 100,
                                                  child:
                                                  imageFromNetworkCache(logic.categoryListModel.data?[index].categoryImg.toString() ?? "",
                                                      height: 100),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        WidgetText
                                            .widgetPoppinsRegularText(
                                            "S.No.: ",
                                            Color(SUBTEXT),
                                            14),
                                        logic.categoryListModel.data
                                            ?.length ==
                                            0
                                            ? Text('')
                                            : WidgetText
                                            .widgetPoppinsMediumText(
                                            seriolNo
                                                .toString(),
                                            Color(BLACK),
                                            14),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                    "Category Name",
                                                    Color(SUBTEXT),
                                                    14),
                                                Flexible(
                                                  child: WidgetText
                                                      .widgetPoppinsMediumOverflowText(
                                                      logic
                                                          .categoryListModel.data?[index].categoryName.toString() ?? "",
                                                      Color(BLACK),
                                                      14,maxline: 2),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                WidgetText
                                                    .widgetPoppinsRegularText(
                                                    created,
                                                    Color(SUBTEXT),
                                                    14),
                                                Flexible(
                                                  child: WidgetText
                                                      .widgetPoppinsMediumOverflowText(
                                                      createdDate,
                                                      Color(BLACK),
                                                      14, maxline: 2),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              WidgetText
                                                  .widgetPoppinsRegularText(
                                                  "Status ",
                                                  Color(SUBTEXT),
                                                  14),
                                              Flexible(
                                                child: WidgetText
                                                    .widgetPoppinsMediumOverflowText(
                                                    logic.categoryListModel.data?[index].status == 'DEACTIVE' ? 'INACTIVE' : logic
                                                        .categoryListModel.data?[index].status ?? "",
                                                    logic.categoryListModel.data?[index].status == 'DEACTIVE'? Color(RED) :
                                                    Color(GREEN),
                                                    14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  CategoryDetails(
                                                    categoryId: logic
                                                        .categoryListModel.data?[index].categoryId.toString() ?? "",
                                                  ));
                                            },
                                            child: Container(
                                              padding: EdgeInsets
                                                  .fromLTRB(
                                                  0, 10, 0, 10),
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Color(ORANGE),
                                                shape: BoxShape
                                                    .rectangle,
                                                borderRadius:
                                                BorderRadius
                                                    .all(Radius
                                                    .circular(
                                                    7)),
                                              ),
                                              alignment:
                                              Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "View details",
                                                Color(WHITE),
                                                12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              print('MenuId: ${logic.categoryListModel.data?[index].categoryId}');
                                              await  Get.to(()=> AddEditCategoryScreen(categoryId: logic.categoryListModel.data?[index].categoryId.toString() ?? "", isEdit: true,));
                                              _categoryController.getCategoryListApi(status: "", search: "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets
                                                  .fromLTRB(
                                                  0, 10, 0, 10),
                                              decoration:
                                              BoxDecoration(
                                                color: Color(WHITE),
                                                shape: BoxShape
                                                    .rectangle,
                                                border: Border.all(
                                                    color: Color(
                                                        ORANGE),
                                                    width: 1),
                                                borderRadius:
                                                BorderRadius
                                                    .all(Radius
                                                    .circular(
                                                    7)),
                                              ),
                                              alignment:
                                              Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Edit details",
                                                Color(ORANGE),
                                                12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      /*  logic.categoryListModel.data?[index].isStatusUpdated == false ?
                                        InkWell(
                                          onTap: () async {
                                              setState(() {
                                                logic.categoryListModel
                                                    .data?[index]
                                                    .setStatusUpdated = true;
                                              });
                                            if (logic.categoryListModel.data?[index].status == "ACTIVE") {
                                              await logic.updateCategoryApi(
                                                  categoryId: logic.categoryListModel.data?[index].categoryId.toString() ?? "", status: 'DEACTIVE');
                                              if (logic.categoryStatusModel.meta?.status == true) {
                                                logic.getCategoryListApi(status: "", search: "");
                                                setState(() {
                                                  logic.categoryListModel.data?[index].setStatusUpdated = false;
                                                });
                                              }
                                            } else {
                                              await logic.updateCategoryApi(
                                                  categoryId: logic.categoryListModel.data?[index].categoryId.toString() ?? "",
                                                  status: 'ACTIVE');
                                              if (logic.categoryStatusModel.meta?.status == true) {
                                                logic.getCategoryListApi(status: "", search: "");
                                                setState(() {
                                                  logic.categoryListModel.data?[index].setStatusUpdated = false;
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .rectangle,
                                                color:
                                                CupertinoColors
                                                    .white,
                                                border: Border.all(
                                                    color: logic.categoryListModel.data?[index].status ==
                                                        "ACTIVE"
                                                        ? Color(
                                                        GREENCOLORICON)
                                                        : Color(
                                                        LIGHTERGREYCOLORICON),
                                                    style: BorderStyle
                                                        .solid,
                                                    width: 1),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        5))),
                                            child: logic
                                                .categoryListModel
                                                .data?[index].status ==
                                                "ACTIVE"
                                                ? Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Icon(
                                                    CupertinoIcons
                                                        .check_mark,
                                                    color:
                                                    Color(GREENCOLORICON)),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Color(GREENCOLORICON),
                                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  height:
                                                  30,
                                                  width:
                                                  30,
                                                ),
                                              ],
                                            )
                                                : Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(color: Color(LIGHTERGREYCOLORICON), style: BorderStyle.solid, width: 1),
                                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  height:
                                                  30,
                                                  width:
                                                  30,
                                                ),
                                                Icon(
                                                    CupertinoIcons
                                                        .clear,
                                                    color:
                                                    Color(LIGHTERGREYCOLORICON)),
                                              ],
                                            ),
                                          ),
                                        )
                                            : Center(
                                          child:
                                          CircularProgressIndicator(
                                            color:
                                            Color(ORANGE),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
              ],
            );
          })),
    );
  }
}
