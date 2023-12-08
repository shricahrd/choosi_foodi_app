import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/profile/change_password_screen.dart';
import 'package:choosifoodi/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Image.asset(
                      ic_back,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                    "My Profile",
                    Color(BLACK),
                    16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ic_profile_place_holder,
                    height: 110,
                    width: 110,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: onClickEditProfile,
                    child: Image.asset(
                      ic_edit,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  bottom: 0,
                  right: 15,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Color(LIGHTDIVIDERCOLOR),
              height: 2,
              thickness: 2,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.all(25),
                width: double.infinity,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _profileFieldWidget("Name", "Suman Gosain"),
                    SizedBox(
                      height: 10,
                    ),
                    _profileFieldWidget("Mobile", "+91 9988776655"),
                    SizedBox(
                      height: 10,
                    ),
                    _profileFieldWidget("Email", "sumangosain@gmail.com"),
                    SizedBox(
                      height: 10,
                    ),
                    _profileFieldWidget("Member since", "15-2-22"),
                    SizedBox(
                      height: 10,
                    ),
                    _profileFieldWidget("Total orders placed", "4"),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: onClickChangePassword,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(ORANGE), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: WidgetText.widgetPoppinsRegularText(
                                  "Change password", Color(BLACK), 16),
                            ),
                            Image.asset(
                              ic_left_side_arrow,
                              height: 15,
                              color: Color(BLACK),
                              width: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileFieldWidget(String title, String value) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetText.widgetPoppinsRegularText(
            title,
            Color(0xff848383),
            16,
          ),
          SizedBox(
            height: 5,
          ),
          WidgetText.widgetPoppinsMediumText(
            value,
            Color(0xff3E4958),
            16,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
        ],
      ),
    );
  }

  onClickEditProfile() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => EditProfileScreen()));
  }

  onClickChangePassword() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ChangePasswordScreen()));
  }
}
