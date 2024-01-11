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
import '../model/get_address_model.dart';
import '../controller/address_controller.dart';

class EditAddressScreen extends StatefulWidget {
  GetAddressModel getAddressModel;
  int index;

  EditAddressScreen({
    required this.getAddressModel,
    required this.index,
  });

  @override
  _EditAddressScreenState createState() =>
      _EditAddressScreenState(getAddressModel, index);
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  GetAddressModel getAddressModel = GetAddressModel();
  late int index;

  _EditAddressScreenState(GetAddressModel getAddressModel, int index) {
    this.getAddressModel = getAddressModel;
    this.index = index;
  }

  final AddressController addressController = Get.put(AddressController());
  int _dietaryValue = 0;
  String _addressType = "Home";
  // dynamic _cityId = "";
  String _addressId = "";
  dynamic _stateId = "";
  String _countryId = "";
  String _landmark = "";
  String _lat = "", _long = "";
  TextEditingController _fullNameController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _zipCodeController = new TextEditingController();
  String _selectStateName = "Select";
  String _selectCityName = "Select";
  String _selectCountryName = "Select";
  // String countryId = "";
  dynamic _selectCityId = 0;
  late List stateList;
  bool _isDefault = true;
  final _networkController = Get.find<GetXNetworkManager>();
  // bool isCityMatch = false;
  // late List statesList;

  @override
  void initState() {
    addressController.getCustomCountryList.clear();
    addressController.getCustomStateList.clear();
    addressController.getCustomCityList.clear();
    addressController.getCustomCountryList.add(GetCustomCountryModel(countryId: 0, countryName: "Select"));
    addressController.getCustomStateList.add(GetCustomStateModel(stateId: 0, stateName: "Select"));
    addressController.getCustomCityList.add(GetCustomCityModel(cityId: 0, cityName: "Select"));
    // print('Statename: ${addressController.getCustomStateList[0].stateName}');
    // print('cityName: ${addressController.getCustomCityList[0].cityName}');
    getSharedPrefsData();
    super.initState();
  }

  getSharedPrefsData() async {
    debugPrint(
        'countryName: ${addressController.getCustomCountryList[0].countryName}');
    await addressController.callCountryListAPI();
    if(addressController.getStateModel.meta?.status == true){
      print('Updated State');
    }
    _lat = (await AppPreferences.getLat())!;
    _long = (await AppPreferences.getLong())!;
    print('Lat: $_lat');
    print('Long: $_long');
    getEditData();
  }

  getEditData() async {
    print('State Edit => :${getAddressModel.data![index].stateName}');
    if(addressController.isCountryVisible == true) {
      for (int i = 0; i < (addressController.getCustomCountryList.length); i++) {
        print('state Len: ${addressController.getCustomCountryList.length}');
        if (getAddressModel.data![index].countryName == addressController.getCustomCountryList[i].countryName) {
          print('State match');
          setState(() {
            _selectCountryName = getAddressModel.data![index].countryName.toString();
            _countryId = getAddressModel.data![index].countryId.toString();
            print('_countryId: $_countryId');
            callStateApi(_countryId);
          });
        }
      }

    }

    if(addressController.isStateVisible == true) {
      for (int i = 0; i < (addressController.getCustomStateList.length); i++) {
        print('state Len: ${addressController.getCustomStateList.length}');
        if (getAddressModel.data![index].stateName == addressController.getCustomStateList[i].stateName) {
          print('State match');
          setState(() {
            _selectStateName = getAddressModel.data![index].stateName.toString();
            _stateId = getAddressModel.data![index].stateId.toString();
            print('_stateId: $_stateId');
            callCityApi(_stateId);
          });
        }
      }

    }
    setState(() {
      if(getAddressModel.data?[index].name == null){
        _fullNameController.text = "";
      }else {
        _fullNameController.text =
            getAddressModel.data?[index].name.toString() ?? "";
      }

      _mobileController.text = getAddressModel.data![index].mobile.toString();
      print('mobile: ${_mobileController.text}');
      _landmark = getAddressModel.data![index].landmark.toString();
      _addressController.text =
          getAddressModel.data![index].addressLine1.toString() + _landmark;
      _zipCodeController.text = getAddressModel.data![index].pincode.toString();
      _addressId = getAddressModel.data![index].addressId.toString();

      if (getAddressModel.data![index].addressType == 'HOME') {
        _dietaryValue = 0;
        _addressType = 'Home';
      } else if (getAddressModel.data![index].addressType == 'OFFICE') {
        _dietaryValue = 1;
        _addressType = 'Office';
      } else {
        _dietaryValue = 2;
        _addressType = 'Other';
      }
      if (getAddressModel.data![index].isDefault == true) {
        _isDefault = true;
      } else {
        _isDefault = false;
      }
    });
  }

  callStateApi(String value) async {
    if(addressController.isCountryVisible == true) {
      print('search city: ${getAddressModel.data?[index].stateName}');
      await addressController.callGetStateListAPI(
          countryId: value, );
      if (addressController.isStateVisible == true) {
        print('city status: ${addressController.getCityModel.meta?.status}');
        // if (addressController.getCustomCityList.length >1) {
        if (addressController.isStateAvail == true) {
          print('City Custom Len: ${addressController.getCustomStateList.length}');
          for (int j = 0; j < (addressController.getCustomStateList.length); j++) {
            print('For Loop i: $j');
            print('search edit city: ${getAddressModel.data?[index].stateName}');
            print('api city : ${addressController.getCustomStateList[j].stateName}');
            print('City model len : ${addressController.getCustomStateList
                .length}');

            if (getAddressModel.data?[index].stateName ==
                addressController.getCustomStateList[j].stateName) {
              print('Match city: ${getAddressModel.data?[index].stateName}');
              setState(() {
                  _selectStateName =
                    addressController.getCustomStateList[j].stateName.toString();
                  _stateId = addressController.getCustomStateList[j].stateId.toString();
                print('_selectStateName: $_selectStateName');
                // addressController.isStateVisible = true;
                // isCityMatch = true;
                  callCityApi(_stateId);
              });
            }
          }
        }else{
          _selectStateName =
              addressController.getCustomStateList[0].stateName
                  .toString();
          _stateId = addressController.getCustomStateList[0].stateId
              .toString();
        }
      }
    }
  }

  callCityApi(String stateId) async {
    if(addressController.isStateVisible == true) {
      print('search city: ${getAddressModel.data?[index].cityName}');
      await addressController.callGetCityListAPI(
          countryId: _countryId, stateId: stateId);
      if (addressController.isCityVisible == true) {
        print('city status: ${addressController.getCityModel.meta?.status}');
        // if (addressController.getCustomCityList.length >1) {
        if (addressController.isCityAvail == true) {
          print('City Custom Len: ${addressController.getCustomCityList.length}');
          for (int j = 0; j < (addressController.getCustomCityList.length); j++) {
            print('For Loop i: $j');
            print('search edit city: ${getAddressModel.data?[index].cityName}');
            print('api city : ${addressController.getCustomCityList[j]
                .cityName}');
            print('City model len : ${addressController.getCustomCityList
                .length}');

            if (getAddressModel.data?[index].cityName ==
                addressController.getCustomCityList[j].cityName) {
              print('Match city: ${getAddressModel.data?[index].cityName}');
              setState(() {
                // _selectCityName =
                //     getAddressModel.data![index].cityName.toString();
                // _cityId = getAddressModel.data![index].cityId.toString();
                  _selectCityName =
                    addressController.getCustomCityList[j].cityName
                        .toString();
                  _selectCityId = addressController.getCustomCityList[j].cityId
                    .toString();
                print('_selectCityName: $_selectCityName');
                // addressController.isStateVisible = true;
                // isCityMatch = true;
              });
            }
          }
        }else{
          _selectCityName =
              addressController.getCustomCityList[0].cityName
                  .toString();
          _selectCityId = addressController.getCustomCityList[0].cityId
              .toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Edit delivery address",true ),
      body: SafeArea(
        child: GetBuilder<AddressController>(builder: (logic) {
          bool mobileValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,15}$)")
              .hasMatch(_mobileController.text);
          // bool zipValid = RegExp(r'^[0-4]+').hasMatch(_zipCodeController.text);
          return
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Flexible(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      customTextInputField(_fullNameController, "", "Full Name", TextInputType.text, TextInputAction.next, true, false),
                      customTextInputField(_mobileController, "", "Mobile No.",
                          TextInputType.phone, TextInputAction.next, false, true),
                      customTextInputField(_addressController, "", "Address",
                          TextInputType.multiline, TextInputAction.next),

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
                                                _countryId = logic
                                                    .getCustomCountryList[
                                                index]
                                                    .countryId
                                                    .toString();
                                                debugPrint(
                                                    'Using countryId: $_countryId');
                                                logic.callGetStateListAPI(
                                                  countryId: _countryId,
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
                                                _stateId = logic
                                                    .getCustomStateList[
                                                index]
                                                    .stateId
                                                    .toString();
                                                print(
                                                    'Using stateID: $_stateId');
                                                logic.callGetCityListAPI(
                                                    countryId:
                                                    _countryId,
                                                    stateId: _stateId
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
                                    _addressType = "Home";
                                  });
                                },
                                child: _dietaryValue == 0
                                    ? WidgetRadioButton.selectedRadioButton(
                                    "Home")
                                    : WidgetRadioButton.unselectedRadioButton(
                                    "Home"),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _dietaryValue = 1;
                                    _addressType = "Office";
                                  });
                                },
                                child: _dietaryValue == 1
                                    ? WidgetRadioButton.selectedRadioButton(
                                    "Office")
                                    : WidgetRadioButton.unselectedRadioButton(
                                    "Office"),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _dietaryValue = 2;
                                    _addressType = "Other";
                                  });
                                },
                                child: _dietaryValue == 2
                                    ? WidgetRadioButton.selectedRadioButton(
                                    "Others")
                                    : WidgetRadioButton.unselectedRadioButton(
                                    "Others"),
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
                              child: WidgetCheckBox.widgetCheckBox(_isDefault),
                              onTap: () {
                                setState(() {
                                  _isDefault = !_isDefault;
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
                      logic.isAddressUpdate == false
                          ? Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: WidgetButton.widgetDefaultButton("Save", () {
                          if (_networkController.connectionType != 0) {

                            debugPrint('_countryId: $_countryId, _stateId: $_stateId,_selectCityId :$_selectCityId ');

                            if (_fullNameController.text.isNotEmpty &&
                                _addressController.text.isNotEmpty &&
                                _mobileController.text.isNotEmpty &&
                                _zipCodeController.text.isNotEmpty &&
                                _countryId != "" &&    _stateId != "" &&
                                _selectCityId != "") {
                              if (_mobileController.text.length == 10) {
                                if (mobileValid == true) {
                                  if (_zipCodeController.text.length == 5) {
                                    // if (zipValid == true) {
                                    String addressLine1 = "";

                                    if (_addressController.text
                                        .split(',')
                                        .last !=
                                        "") {
                                      _landmark = _addressController.text;
                                      print(
                                          '_landmark condition: $_landmark');
                                      addressLine1 = " ";
                                      print(
                                          'addressLine1 condition: $addressLine1');
                                    } else {
                                      _landmark = _addressController.text
                                          .split(',')
                                          .last;
                                      print('Landmark: $_landmark');
                                      addressLine1 = _addressController
                                          .text
                                          .replaceFirstMapped(
                                          _landmark, (match) => "");
                                      print(
                                          'addressline1: $addressLine1');
                                    }

                                    logic.updateAddressApi(
                                      addressId: _addressId,
                                      addressLine: addressLine1,
                                      mobile: "${_mobileController.text}",
                                      addressType: _addressType,
                                      cityId: _selectCityId,
                                      countryId: _countryId,
                                      stateID: _stateId,
                                      landmark: _landmark,
                                      name: _fullNameController.text,
                                      pincode: _zipCodeController.text,
                                      lat: _lat,
                                      long: _long,
                                      isDefault: _isDefault,
                                    );
                                    /* } else {
                                          showToastMessage(
                                              "Please enter Zip code in digits");
                                        }*/
                                  } else {
                                    showToastMessage(
                                        "Please Enter 5 digit Zipcode");
                                  }
                                } else {
                                  showToastMessage(
                                      "Please enter Proper Phone Number");
                                }
                              } else {
                                showToastMessage("Entered mobile number must be 10 digit");
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
                  flex: 1,
                  fit: FlexFit.tight,
                ),
              ],
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
      TextInputAction? textInputAction ,
      [bool name = false, bool isMobile = false,  bool isZipCode = false]) {
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
            textInputAction: textInputAction,
            inputFormatters:
            name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] :
            isMobile || isZipCode ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ] : [],
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon:  isMobile ? Text("+1 ", style: TextStyle(
                color: Color(BLACK),
                fontSize: 14,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              )): Text(''),
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 14,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val) {
              setState(() {
                print('Onchanged value: $val');
              });
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
