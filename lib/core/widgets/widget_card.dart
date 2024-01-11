import 'package:cached_network_image/cached_network_image.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings_constants.dart';

class WidgetCard {
  static Widget rectCard(String name1, String name2, String image) {
    return Stack(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          child: Image.asset(
            ic_rect_card,
            height: 170,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 30,
          top: 30,
          child: Container(
            // height: 22,
            alignment: Alignment.center,
            child: WidgetText.widgetPoppinsMediumText(name1, Color(WHITE), 18),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 30,
          child: Container(
            // height: 22,
            alignment: Alignment.center,
            child: WidgetText.widgetPoppinsMediumText(name2, Color(WHITE), 40),
          ),
        ),
        Positioned(
          right: 30,
          bottom: 15,
          top: 15,
          child: Container(
            height: 120,
            width: 120,
            child: Image.asset(
              image,
              // height: 50,
              // width: 15,
            ),
          ),
        ),
      ],
    );
  }

  static Widget rectCard2(String name1, String name2, String image) {
    return Stack(
      children: [
        Image.asset(
          ic_rect_org_card,
          height: 170,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 30,
          top: 40,
          child: Container(
            // height: 22,
            alignment: Alignment.center,
            child: WidgetText.widgetPoppinsMediumText(name1, Color(WHITE), 18),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 40,
          child: Container(
            // height: 22,
            alignment: Alignment.center,
            child: WidgetText.widgetPoppinsMediumText(name2, Color(WHITE), 40),
          ),
        ),
        Positioned(
          right: 30,
          bottom: 15,
          top: 15,
          child: Container(
            height: 86,
            width: 86,
            child: Image.asset(
              image,
            ),
          ),
        ),
      ],
    );
  }

  static Widget customTextInputField(
    String detail1,
    String detail2,
  ) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 2, 15, 10),
        decoration: BoxDecoration(
          color: Color(WHITE),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color(ORANGE), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetText.widgetPoppinsMediumText(
              detail1,
              Color(LABLECOLOR2),
              16,
              align: TextAlign.start,
            ),
            WidgetText.widgetPoppinsMediumText(
              detail2.toString(),
              Color(BLACK),
              25,
              align: TextAlign.end,
            ),
          ],
        ));
  }

}



Future pickImageFromDevice({required BuildContext context, required VoidCallback openGallery,  required VoidCallback openCamera, }){
  return  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(WHITE),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: openGallery,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 20, color: Color(ORANGE),),
                      SizedBox(
                        width: 10,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                          chooseGallary, Color(BLACK3), 14,
                          align: TextAlign.center),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color:Color(DIVIDERCOLOR),
              ),
              SizedBox(
                height: 2,
              ),
              InkWell(
                onTap: openCamera,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt, size: 20, color: Color(ORANGE),),
                      SizedBox(
                        width: 10,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                          takePhoto, Color(BLACK3), 14,
                          align: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border:
                      Border.all(width: 1, color: Color(GREY)),
                    ),
                    child: WidgetText.widgetPoppinsRegularText(
                        cancel, Color(BLACK3), 14,
                        align: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


class WidgetAppbar{
    static simpleAppBar(
     BuildContext context,
        String text,
        bool? showShadow,
  ) {
      return AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        elevation: showShadow == true ? 4: 0,
        shadowColor: showShadow == true ? Color(HINTCOLOR) : Color(WHITE),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          color: Color(WHITE),
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ic_right_side_arrow,
                width: 25,
                color: Color(ORANGE),
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: WidgetText.widgetPoppinsMaxLineOverflowText(
                  text,
                  Color(BLACK),
                  16,
                ),
              )
            ],
          ),
        ),
      );
    }
}

Widget imageFromNetworkCache(String? imageUrl, {String? staticImage, double? height}) {
  if (imageUrl != null && imageUrl != "") {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      cacheKey: imageUrl,
      height:  height ?? 100,
      fadeInCurve: Curves.easeIn,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) => Center(
        child:
        CircularProgressIndicator(
          color:
          Color(ORANGE),
        ),
      ),
      errorWidget: (context, url, error) =>
          Image.asset(ic_no_image,
            height: height ?? 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,),
    );
    // return Image.network(imageUrl, fit: BoxFit.fill,);
  } else {
    return Image.asset(ic_no_image,
      height: height ?? 100,
      width: double.infinity,
      fit: BoxFit.fill,);
  }
}