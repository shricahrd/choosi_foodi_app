import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_check_box.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../model/custom_state_model.dart';
import '../controller/address_controller.dart';

class NewAddressScreen extends StatefulWidget {
  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final AddressController addressController = Get.put(AddressController());
  int _dietaryValue = 0;
  String addressType = "Home";
  // String cityId = "";
  String stateId = "";
  String countryId = "";
  String lat = "", long = "";
  String _landmark = "";
  TextEditingController _fullNameController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _zipCodeController = new TextEditingController();
  String _selectCountryName = "Select";
  String _selectStateName = "Select";
  String _selectCityName = "Select";
  dynamic _selectCityId = 0;
  late List stateList;
  bool isDefault = true;
  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void initState() {
    addressController.getCustomStateList.clear();
    addressController.getCustomCountryList.clear();
    addressController.getCustomCityList.clear();
    addressController.getCustomCountryList
        .add(GetCustomCountryModel(countryId: 0, countryName: "Select"));
    addressController.getCustomStateList
        .add(GetCustomStateModel(stateId: 0, stateName: "Select"));
    addressController.getCustomCityList
        .add(GetCustomCityModel(cityId: 0, cityName: "Select"));
    print('Statename: ${addressController.getCustomStateList[0].stateName}');
    addressController.isCountryVisible = false;
    getData();
    getSharedPrefsData();
    super.initState();
  }

  getData() async {
    debugPrint(
        'countryName: ${addressController.getCustomCountryList[0].countryName}');
    await addressController.callCountryListAPI();
    addressController.isAddressPosted = false;
  }

  getSharedPrefsData() async {
    lat = (await AppPreferences.getLat())!;
    long = (await AppPreferences.getLong())!;
    print('Lat: $lat');
    print('Long: $long');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Add new address",true ),
      body: SafeArea(
        child: GetBuilder<AddressController>(builder: (logic) {
          bool mobileValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,11}$)")
              .hasMatch(_mobileController.text);
          // bool zipValid = RegExp(r'[0-4]').hasMatch(_zipCodeController.text);
          return logic.isCountryVisible == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          customTextInputField(
                              _fullNameController,
                              "",
                              "Full Name",
                              TextInputType.text,
                              TextInputAction.next,
                              true,
                              false),
                          customTextInputField(
                              _mobileController,
                              "",
                              "Mobile No.",
                              TextInputType.phone,
                              TextInputAction.next,
                              false,
                              true),
                          customTextInputField(
                              _addressController,
                              "",
                              "Address",
                              TextInputType.multiline,
                              TextInputAction.next),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 15, 5, 5),
                                      child:
                                          WidgetText.widgetPoppinsRegularText(
                                        "Country",
                                        Color(LIGHTTEXTCOLOR),
                                        14,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 5, 2),
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        border: Border.all(
                                            color: Color(0xffd2d2d2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width/3,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                              // icon: Container(),
                                              icon: Image.asset(
                                                ic_down_arrow,
                                                height: 10,
                                                width: 20,
                                                color: Color(BLACK),
                                              ),
                                              isExpanded: true,
                                              // value: _selectStateName,
                                              value: _selectCountryName ==
                                                      "Select"
                                                  ? logic
                                                      .getCustomCountryList[0]
                                                      .countryName
                                                      .toString()
                                                  : _selectCountryName,
                                              items: logic.getCustomCountryList
                                                  .map((GetCustomCountryModel
                                                      value) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    value.countryName
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Color(BLACK),
                                                      fontSize: 13,
                                                      fontFamily: FontPoppins,
                                                      fontWeight:
                                                          PoppinsRegular,
                                                    ),
                                                  ),
                                                  value: value.countryName
                                                      .toString(),
                                                );
                                              }).toList(),
                                              hint: const Text(
                                                "Country",
                                                style: TextStyle(
                                                  color: Color(HINTCOLOR),
                                                  fontSize: 16,
                                                  fontFamily: FontPoppins,
                                                  fontWeight: PoppinsRegular,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectCountryName =
                                                      value.toString();
                                                  debugPrint(
                                                      'SelectedName: $_selectCountryName');
                                                  final index = logic
                                                      .getCustomCountryList
                                                      .indexWhere((element) =>
                                                          element.countryName ==
                                                          _selectCountryName);

                                                  _selectStateName = "Select";
                                                  _selectCityName = "Select";
                                                  logic.getCustomStateList.clear();
                                                  logic.getCustomCityList.clear();
                                                  if (index >= 0) {
                                                    countryId = logic
                                                        .getCustomCountryList[
                                                            index]
                                                        .countryId
                                                        .toString();
                                                    debugPrint(
                                                        'Using CountryId: $countryId');
                                                    logic.callGetStateListAPI(
                                                      countryId: countryId,
                                                    );
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 15, 5, 5),
                                      child:
                                          WidgetText.widgetPoppinsRegularText(
                                        "State",
                                        Color(LIGHTTEXTCOLOR),
                                        14,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 15, 2),
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        border: Border.all(
                                            color: Color(0xffd2d2d2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width/3,
                                        child: logic.getCustomStateList
                                                    .isEmpty ==
                                                true
                                            ? Container()
                                            : DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                    // icon: Container(),
                                                    icon: Image.asset(
                                                      ic_down_arrow,
                                                      height: 10,
                                                      width: 20,
                                                      color: Color(BLACK),
                                                    ),
                                                    isExpanded: true,
                                                    // value: _selectStateName,
                                                    // value: _selectStateName == "Select" ?  logic.getCustomStateList[0].stateName.toString() : _selectStateName,
                                                    value: logic
                                                            .getCustomStateList
                                                            .isNotEmpty
                                                        ? _selectStateName
                                                        : null,
                                                    items: logic
                                                        .getCustomStateList
                                                        .map(
                                                            (GetCustomStateModel
                                                                value) {
                                                      return DropdownMenuItem(
                                                        child: Text(
                                                          value.stateName
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(BLACK),
                                                            fontSize: 13,
                                                            fontFamily:
                                                                FontPoppins,
                                                            fontWeight:
                                                                PoppinsRegular,
                                                          ),
                                                        ),
                                                        value: value.stateName
                                                            .toString(),
                                                      );
                                                    }).toSet().toList(),
                                                    hint: Text(
                                                      // "State",
                                                      logic.getCustomStateList
                                                              .isNotEmpty
                                                          ? "State"
                                                          : "Select",
                                                      style: TextStyle(
                                                        color: Color(HINTCOLOR),
                                                        fontSize: 16,
                                                        fontFamily: FontPoppins,
                                                        fontWeight:
                                                            PoppinsRegular,
                                                      ),
                                                    ),
                                                    onChanged: logic
                                                            .getCustomStateList
                                                            .isNotEmpty
                                                        ? (value) {
                                                            setState(() {
                                                              _selectStateName =
                                                                  value
                                                                      .toString();
                                                              print(
                                                                  'SelectedName: $_selectStateName');
                                                              final index = logic
                                                                  .getCustomStateList
                                                                  .indexWhere((element) =>
                                                                      element
                                                                          .stateName ==
                                                                      _selectStateName);

                                                              _selectCityName =
                                                                  "Select";
                                                              _selectCityId = 0;
                                                              logic
                                                                  .getCustomCityList
                                                                  .clear();
                                                              if (index >= 0) {
                                                                stateId = logic
                                                                    .getCustomStateList[
                                                                        index]
                                                                    .stateId
                                                                    .toString();
                                                                print(
                                                                    'Using stateID: $stateId');
                                                                logic.callGetCityListAPI(
                                                                    countryId:
                                                                        countryId,
                                                                    stateId: stateId
                                                                        .toString());
                                                              }
                                                            });
                                                          }
                                                        : null),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 15, 5, 5),
                                      child:
                                          WidgetText.widgetPoppinsRegularText(
                                        "City",
                                        Color(LIGHTTEXTCOLOR),
                                        14,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 5, 2),
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                        border: Border.all(
                                            color: Color(0xffd2d2d2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: logic.getCustomCityList.isEmpty ==
                                              true
                                          ? Container()
                                          : DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                icon: Image.asset(
                                                  ic_down_arrow,
                                                  height: 10,
                                                  width: 20,
                                                  color: Color(BLACK),
                                                ),
                                                isExpanded: true,
                                                value: logic.getCustomCityList
                                                        .isEmpty
                                                    ? (logic.getCustomCityList
                                                            .isNotEmpty
                                                        ? logic
                                                            .getCustomCityList[
                                                                0]
                                                            .cityId
                                                            .toString()
                                                        : null)
                                                    : _selectCityId?.toString(),
                                                // Use null-aware operator
                                                items: logic.getCustomCityList
                                                    .map((GetCustomCityModel
                                                        value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.cityId
                                                            .toString(),
                                                        child: Text(
                                                          value.cityName
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(BLACK),
                                                            fontSize: 13,
                                                            fontFamily:
                                                                FontPoppins,
                                                            fontWeight:
                                                                PoppinsRegular,
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                    .toSet()
                                                    .toList(),
                                                hint: Text(
                                                  logic.getCustomCityList
                                                          .isEmpty
                                                      ? "City"
                                                      : "Select",
                                                  style: TextStyle(
                                                    color: logic
                                                            .getCustomCityList
                                                            .isEmpty
                                                        ? Color(HINTCOLOR)
                                                        : Color(BLACK),
                                                    fontSize: 16,
                                                    fontFamily: FontPoppins,
                                                    fontWeight: PoppinsRegular,
                                                  ),
                                                ),
                                                onChanged: logic
                                                        .getCustomCityList
                                                        .isNotEmpty
                                                    ? (value) {
                                                        debugPrint(
                                                            'value: $value');
                                                        setState(() {
                                                          _selectCityId =
                                                              value; // Parse string to int
                                                          print(
                                                              '_selectCityId: $_selectCityId');
                                                          final index = logic
                                                              .getCustomCityList
                                                              .indexWhere((element) =>
                                                                  element
                                                                      .cityId ==
                                                                  _selectCityId
                                                                      ?.toString());
                                                          if (index >= 0) {
                                                            _selectCityName = logic
                                                                .getCustomCityList[
                                                                    index]
                                                                .cityName
                                                                .toString();
                                                            print(
                                                                'Using cityName: $_selectCityName');
                                                          }
                                                        });
                                                      }
                                                    : null,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: customTextInputField(
                                    _zipCodeController,
                                    "",
                                    "Zip code",
                                    TextInputType.phone,
                                    TextInputAction.done,
                                    false,
                                    false,
                                    true),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: WidgetText.widgetPoppinsRegularText(
                              "Select address type",
                              Color(SUBTEXT),
                              14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _dietaryValue = 0;
                                        addressType = "Home";
                                      });
                                    },
                                    child: _dietaryValue == 0
                                        ? WidgetRadioButton.selectedRadioButton(
                                            "Home")
                                        : WidgetRadioButton
                                            .unselectedRadioButton("Home"),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _dietaryValue = 1;
                                        addressType = "Office";
                                      });
                                    },
                                    child: _dietaryValue == 1
                                        ? WidgetRadioButton.selectedRadioButton(
                                            "Office")
                                        : WidgetRadioButton
                                            .unselectedRadioButton("Office"),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _dietaryValue = 2;
                                        addressType = "Other";
                                      });
                                    },
                                    child: _dietaryValue == 2
                                        ? WidgetRadioButton.selectedRadioButton(
                                            "Others")
                                        : WidgetRadioButton
                                            .unselectedRadioButton("Others"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  child:
                                      WidgetCheckBox.widgetCheckBox(isDefault),
                                  onTap: () {
                                    setState(() {
                                      isDefault = !isDefault;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                  "Set default address",
                                  Color(BLACK),
                                  14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          logic.isAddressPosted == false
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                  child: WidgetButton.widgetDefaultButton(
                                      "Save", () {
                                    if (_networkController.connectionType !=
                                        0) {
                                      if (_fullNameController.text.isNotEmpty &&
                                          _addressController.text.isNotEmpty &&
                                          _mobileController.text.isNotEmpty &&
                                          _zipCodeController.text.isNotEmpty &&
                                          stateId != "" &&
                                          _selectCityId != "") {
                                        if (_mobileController.text.length ==
                                            10) {
                                          if (mobileValid == true) {
                                            if (_zipCodeController
                                                    .text.length ==
                                                5) {
                                              // if(zipValid == true) {
                                              String addressLine1 = "";
                                              if (_addressController.text
                                                      .split(',')
                                                      .last !=
                                                  "") {
                                                _landmark =
                                                    _addressController.text;
                                                print(
                                                    '_landmark condition: $_landmark');
                                                addressLine1 = " ";
                                                print(
                                                    'addressLine1 condition: $addressLine1');
                                              } else {
                                                _landmark = _addressController
                                                    .text
                                                    .split(',')
                                                    .last;
                                                print('Landmark: $_landmark');
                                                addressLine1 =
                                                    _addressController.text
                                                        .replaceFirstMapped(
                                                            _landmark,
                                                            (match) => "");
                                                debugPrint(
                                                    'addressline1: $addressLine1');
                                              }

                                              logic.postAddressApi(
                                                addressLine: addressLine1,
                                                mobile:
                                                    "${_mobileController.text}",
                                                addressType: addressType,
                                                cityId: _selectCityId.toString(),
                                                countryId: countryId,
                                                stateID: stateId,
                                                landmark: _landmark,
                                                name: _fullNameController.text,
                                                pincode:
                                                    _zipCodeController.text,
                                                lat: lat,
                                                long: long,
                                                isDefault: isDefault,
                                              );
                                              /*}else {
                                        showToastMessage("Please enter Zip code in digits");
                                      }*/
                                            } else {
                                              showToastMessage(
                                                  "Please Enter 5 digit Zipcode");
                                            }
                                          } else {
                                            showToastMessage(
                                                "Please enter proper mobile number");
                                          }
                                        } else {
                                          showToastMessage(
                                              "Entered mobile number must be 10 digit");
                                        }
                                      } else {
                                        showToastMessage(
                                            "Please enter all required fields");
                                      }
                                    } else {
                                      showToastMessage(check_internet);
                                    }
                                  }),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: Color(ORANGE),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      flex: 3,
                      fit: FlexFit.tight,
                    ),
                  ],
                )
              : logic.getStateModel.meta?.status == false
                  ? Container()
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ),
                    );
        }),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false,
      bool isMobile = false,
      bool isZipCode = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: WidgetText.widgetPoppinsRegularText(
            lableText,
            Color(LIGHTTEXTCOLOR),
            14,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 2),
          decoration: BoxDecoration(
            color: Color(WHITE),
            border: Border.all(color: Color(0xffd2d2d2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            inputFormatters: name
                ? [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ]
                : isMobile || isZipCode
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ]
                    : [],
            textInputAction: textInputAction,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon: isMobile
                  ? Text("+1 ",
                      style: TextStyle(
                        color: Color(BLACK),
                        fontSize: 14,
                        fontFamily: FontPoppins,
                        fontWeight: PoppinsRegular,
                      ))
                  : Text(''),
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 14,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val) {
              setState(() {});
            },
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 14,
              fontFamily: FontPoppins,
              fontWeight: PoppinsRegular,
            ),
          ),
        )
      ],
    );
  }
}
