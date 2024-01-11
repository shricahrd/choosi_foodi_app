import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/foodi_goal_view_controller.dart';
import 'foodi_goal_add_edit.dart';

class FoodiGoalResultScreen extends StatefulWidget {
  final bool isFromHome;
  final bool isEdit;


  const FoodiGoalResultScreen(
      {Key? key,
        required this.isFromHome, required this.isEdit, })
      : super(key: key);

  @override
  _FoodiGoalResultScreenState createState() => _FoodiGoalResultScreenState(isFromHome, isEdit);
}

class _FoodiGoalResultScreenState extends State<FoodiGoalResultScreen> {
  final FoodieViewController foodieViewController = Get.put(FoodieViewController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  bool isFromHome = false;
  bool isEdit = false;

  _FoodiGoalResultScreenState(
      bool isFromHome, bool isEdit) {
    this.isFromHome = isFromHome;
    this.isEdit = isEdit;
  }

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
        debugPrint('Connection Type: ${_networkManager.connectionType}');
        debugPrint('isEdit: $isEdit');
      if(isEdit == true) {
        callApi();
      }else{
        foodieViewController.isLoaderVisible = false;
      }
    }
    super.initState();
  }

  callApi(){
    setState(() {
      foodieViewController.isLoaderVisible = true;
    });
    foodieViewController.callGetFoodGoalAPI();
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
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isFromHome
                      ? Container(
                    height: 20,
                  )
                      : InkWell(
                    onTap: () {
                      Get.back();
                        debugPrint('Back');
                    },
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
                  WidgetText.widgetPoppinsRegularText(
                    foodiGoalTitle,
                    Color(BLACK),
                    18,
                  ),
                ],
              ),
              isEdit == false
                  ? Container(
                height: 20,
              )
                  : InkWell(
                onTap: () async {
                  var getResultData;
                  getResultData = await Get.to(() => FoodiGoalAddEditScreen(isEditFoodiGoal: false, isFromHome: false,)
                  );
                    debugPrint('Back to result: $getResultData');
                    if(getResultData == true){
                      debugPrint('callapi');
                      callApi();
                    }
                },
                child: Image.asset(
                  ic_edit_2,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<FoodieViewController>(builder: (logic) {
                return logic.isLoaderVisible == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.foodiGoalModel.meta?.status == false
                        ? Center(
                            child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Foodi Goal Not Available'),
                          ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisExtent: 255,
                                            mainAxisSpacing: 10),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color(ORANGE),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image.asset(
                                              app_icon,
                                              height: 60,
                                              width: 57,
                                              color: Color(WHITE),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            WidgetText.widgetPoppinsMediumText(
                                                index == 0
                                                    ? "Calories"
                                                    : index == 1
                                                        ? "Fat"
                                                        : index == 2
                                                            ? "Carbs"
                                                            : "Protein",
                                                Color(WHITE),
                                                16),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            WidgetText.widgetPoppinsRegularText(
                                                index == 0
                                                    ? ""
                                                    : index == 1
                                                        ? "Includes Saturated Fat"
                                                        : index == 2
                                                            ? "Includes Sugar"
                                                            : "",
                                                Color(WHITE),
                                                12),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 8),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color(WHITE),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: WidgetText.widgetPoppinsRegularText(
                                                  index == 0
                                                      // ? "${logic.foodiGoalModel.data?.caloriesPerDay.toStringAsFixed(2) ?? "/day"}"
                                                      ? "${logic.foodiGoalModel.data?.caloriesPerDay.toStringAsFixed(2) ?? ""} ${"/day"}"
                                                      // ?  "1083/day"
                                                      : index == 1
                                                          ? "${logic.foodiGoalModel.data?.fat.toStringAsFixed(2) ?? ""} ${"g/day"}"
                                                          // ? "68 g/day"
                                                          : index == 2
                                                              ? "${logic.foodiGoalModel.data?.carbohydrates.toStringAsFixed(2) ?? ""} ${"g/day"}"
                                                              // ? "310 g/day"
                                                              : "${logic.foodiGoalModel.data?.protein.toStringAsFixed(2) ?? ""} ${"g/day"}",
                                                  // : "146 g/day",
                                                  // "1083/day",
                                                  Color(ORANGE),
                                                  16),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 8),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color(WHITE),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                      index == 0
                                                          ? "${logic.caloriesMeal.toStringAsFixed(2)} ${"/meal"}"
                                                          // ? "100/meal"
                                                          : index == 1
                                                          ? "${logic.fatMeal.toStringAsFixed(2)} ${"g/meal"}"
                                                              // ? "54-95 g/meal"
                                                              : index == 2
                                                          ? "${logic.carbsMeal.toStringAsFixed(2)} ${"g/meal"}"
                                                                  // ? "60 g/meal"
                                                                  : "${logic.proteinMeal.toStringAsFixed(2)} ${"g/meal"}",
                                                                  // : "75- 205 g/meal",
                                                      // "100/meal",
                                                      Color(ORANGE),
                                                      16),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
              });
      })),
    );
  }

}
