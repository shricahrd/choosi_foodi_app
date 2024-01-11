import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/notification_controller.dart';
import 'notification_details.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final NotificationController _notificationController =
      Get.put(NotificationController());
  var dateTime, apiDate;
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      _notificationController.callNotificationAPI(true);
    }
    super.initState();
  }

  String timeAgo(int? time) {
    if (time != null) {
      var date = DateTime.fromMicrosecondsSinceEpoch(time * 1000);
      print('Date: $date');
      DateTime d = DateTime.parse(date.toIso8601String().toString());
      Duration diff = DateTime.now().difference(d);
      if (diff.inDays > 365)
        return dateTime =
            "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      if (diff.inDays > 30)
        return dateTime =
            "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      if (diff.inDays > 7)
        return dateTime =
            "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      if (diff.inDays > 0)
        return dateTime =
            "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
      if (diff.inHours > 0)
        return dateTime =
            "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
      if (diff.inMinutes > 0)
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      return dateTime = "just now";
    } else {
      return dateTime = "just now";
    }
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
                onTap: () {
                  Get.back(result: true);
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
                "Notifications",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<NotificationController>(builder: (logic) {
                return logic.notificationLoader
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.notificationModel.meta?.status == false
                        ? Center(
                            child: Container(
                            child: Text('Notifications Not Found'),
                          ))
                        : Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: logic.notificationModel.data?.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      // Get.to(()=> NotificationDetailsScreen(logic.notificationModel.data?[index].body));

                                      if (logic.notificationModel.data?[index]
                                              .notificationId !=
                                          null) {
                                        await logic.callNotificationDetailsAPI(logic
                                            .notificationModel.data?[index].notificationId.toString() ?? "");
                                        if(exp.hasMatch(logic.notificationDetailsModel.data?.body?? "")) {
                                          Get.to(() =>
                                          NotificationDetailsScreen(title: logic.notificationDetailsModel.data?.title,
                                            body: logic.notificationDetailsModel.data?.description,));
                                        }
                                      }
                                    },
                                    child: Card(
                                      margin:
                                          EdgeInsets.fromLTRB(15, 15, 7.5, 15),
                                      color: Color(WHITE),
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      shadowColor: Color(BLACK),
                                      child: Container(
                                        height: 80,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(ORANGE),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 10, 5, 0),
                                                child: WidgetText
                                                    .widgetPoppinsMaxLineOverflowText(
                                                        logic.notificationModel.data?[index].title.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')?? "",
                                                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                                        Color(SUBTEXT),
                                                        14, maxline: 2),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                logic
                                                    .notificationModel
                                                    .data?[index]
                                                    .status ==
                                                    'UNREAD'? DotsIndicator(
                                                  dotsCount: 1,
                                                  axis: Axis.vertical,
                                                  decorator: DotsDecorator(
                                                    activeColor: Colors.green,
                                                    activeSize: Size.square(10.0),
                                                    activeShape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25.0),
                                                    ),
                                                  ),
                                                ) : Container(),
                                                logic
                                                    .notificationModel
                                                    .data?[index]
                                                    .createdAt != null ?
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 10, 10, 0),
                                                  child: WidgetText
                                                      .widgetPoppinsRegularText(
                                                      timeAgo(logic.notificationModel
                                                          .data?[index].createdAt),
                                                      // "2 Hours ago",
                                                      Color(LIGHTGREYCOLORICON),
                                                      12),
                                                ) : Container(child: WidgetText
                                                    .widgetPoppinsRegularText(
                                                    "Just now",
                                                    Color(LIGHTGREYCOLORICON),
                                                    12),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
              });
      })),
    );
  }
}
