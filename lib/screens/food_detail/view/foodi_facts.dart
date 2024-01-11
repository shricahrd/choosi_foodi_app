import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../controller/foodi_facts_controller.dart';

class FoodiFactsScreen extends StatefulWidget {
  @override
  _FoodiFactsScreenState createState() => _FoodiFactsScreenState();
}

class _FoodiFactsScreenState extends State<FoodiFactsScreen> {

  // foodiFactController
  final FoodiFactController foodiFactController = Get.put(FoodiFactController());
  // create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      foodiFactController.callGetFoodFactListAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(context,"Foodi Facts",false ),
        body: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<FoodiFactController>(builder: (logic) {
                  return logic.isLoaderVisible
                      ? Center(
                      child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                      : logic.foodiFactModel.meta?.status == false
                      ? Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text('Foodi Facts List Not Available'),
                      ))
                      : Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: logic.foodiFactModel.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: Color(ORANGE), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: InkWell(
                              onTap: (){
                                // Get.to(()=> FoodDetailScreen());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 110,
                                            height: 190,
                                          child: logic.foodiFactModel.data?[index].foodiFactImg == null
                                              ? Image.asset(
                                            ic_no_image,
                                            fit: BoxFit.fill,
                                          )
                                              : ClipRRect(borderRadius:
                                          BorderRadius.circular(10.0),
                                            child: Image.network(
                                              logic.foodiFactModel.data![index].foodiFactImg.toString(),
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
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
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  ic_no_image,
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                            ),
                                          ),
                                          ),

                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  logic.foodiFactModel.data?[index].title == null ?Container():
                                  WidgetText.widgetPoppinsMediumText(
                                    logic.foodiFactModel.data![index].title.toString(),
                                    Color(BLACK),
                                    16,
                                  ),

                                  logic.foodiFactModel.data?[index].content == null ? Container():
                                  WidgetText.widgetPoppinsMaxLineOverflowText(
                                    logic.foodiFactModel.data![index].content.toString().replaceAll(
                                        RegExp(
                                            r'<[^>]*>|&[^;]+;'),
                                        ' '),
                                    Color(SUBTEXT),
                                    14,maxline: 3
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 15),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              WidgetText.widgetPoppinsRegularText(
                                                "Calories",
                                                Color(BLACK),
                                                13,
                                              ),
                                              logic.foodiFactModel.data?[index].calories == null ? Container():
                                              WidgetText.widgetPoppinsMediumText(
                                                logic.foodiFactModel.data![index].calories.toString(),
                                                Color(SUBTEXT),
                                                14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 15),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              WidgetText.widgetPoppinsRegularText(
                                                "Fat",
                                                Color(BLACK),
                                                13,
                                              ),
                                              logic.foodiFactModel.data?[index].fat == null ? Container():
                                              WidgetText.widgetPoppinsMediumText(
                                                logic.foodiFactModel.data![index].fat.toString() + "g",
                                                Color(SUBTEXT),
                                                14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 15),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              WidgetText.widgetPoppinsRegularText(
                                                "Carbs",
                                                Color(BLACK),
                                                13,
                                              ),
                                              logic.foodiFactModel.data?[index].carbs == null ? Container():
                                              WidgetText.widgetPoppinsMediumText(
                                                logic.foodiFactModel.data![index].carbs.toString() + "g",
                                                Color(SUBTEXT),
                                                14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 15),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              WidgetText.widgetPoppinsRegularText(
                                                "Protein",
                                                Color(BLACK),
                                                13,
                                              ),
                                              logic.foodiFactModel.data?[index].protein == null ? Container():
                                              WidgetText.widgetPoppinsMediumText(
                                                logic.foodiFactModel.data![index].protein.toString() + "g",
                                                Color(SUBTEXT),
                                                14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                });
        }));
  }
}
