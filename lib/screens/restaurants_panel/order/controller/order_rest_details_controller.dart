import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/restaurants_panel/order/model/order_restaurant_details_model.dart.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_get_util.dart';

class OrderRestDetailsController extends GetxController {
  bool isViewOrderVisible = true;
  OrderRestDetailsModel viewDetailsModel = OrderRestDetailsModel();
  String orderPlacedDate = "", deliveryDate = "", deliveryAddress = "", pincode = "";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String parseTimeOrderPlaced(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    orderPlacedDate = d12;
    print('orderPlacedDate: $orderPlacedDate');
    return d12;
  }

  String parseTimeStampDeliveryDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    deliveryDate = d12;
    print('deliveryDate: $deliveryDate');
    return d12;
  }

/*  String parseTimeStampCreatedDateDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }*/

  callViewOrderDetailsAPI(String orderId) {
    getRequest(GeneralPath.API_VIEW_ORDER + orderId).then((response) {

      if (response.statusCode == 200) {
        viewDetailsModel = OrderRestDetailsModel.fromJson(json.decode(response.body));
        if (viewDetailsModel.meta?.status == true) {
          print('status true: ${viewDetailsModel.meta?.status}');
          print('Response Data: ${viewDetailsModel.data}');

          if(viewDetailsModel.data?.userData.createdAt == 0){
            orderPlacedDate = "";
          }else {
            parseTimeOrderPlaced(int.parse(viewDetailsModel.data?.createdAt.toString() ?? ""));
          }

          if(viewDetailsModel.data?.deliveryDate == 0){
            deliveryDate = "";
          }else {
            parseTimeStampDeliveryDate(
                int.parse(viewDetailsModel.data?.deliveryDate.toString() ?? ""));
          }

          /*if(viewDetailsModel.data?.createdAt == 0){
            createdDate = "";
          }else {
            parseTimeStampCreatedDateDate(
                int.parse(viewDetailsModel.data!.createdAt.toString()));
          }*/

          for(int i = 0; i< viewDetailsModel.data!.productDetails.length; i++) {
            int selectedPrice =
                int.parse(viewDetailsModel.data!.productDetails[i].selectQuantity.toString()) *
                int.parse(viewDetailsModel.data!.productDetails[i].price.toString());

            viewDetailsModel.data!.productDetails[i].setPrice = selectedPrice;
            print('Total Price : ${viewDetailsModel.data!.productDetails[i].price}');
          }

          String addressLine1 = "", addressLine2 = "", city = "", state = "", country = "";
          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.line1.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.line1 != null) {
              addressLine1 =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .line1.toString() + " ";
              print('addressLine1: $addressLine1');
            }
          }
          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.line2.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.line2 != null) {
              addressLine2 =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .line2.toString() + ", ";
            }
          }
          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.city.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.city != null) {
              city =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .city.toString() + ", ";
            }
          }
          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.state.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.state != null) {
              state =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .state.toString() + ", ";
            }
          }

          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.country.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.country != null) {
              country =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .country.toString();
            }
          }

          if(viewDetailsModel.data!.paymentDetails.billingDetails.address.postalCode.isNotEmpty){
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.postalCode != null) {
              pincode =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address
                      .postalCode.toString();
            }
          }

          deliveryAddress = addressLine1 + addressLine2 + city + state + country;
          print('deliveryAddress: $deliveryAddress');
          update();

          isViewOrderVisible = false;
          update();
        }else{
          showToastMessage(viewDetailsModel.meta!.msg.toString());
          isViewOrderVisible = false;
          update();
        }
      } else {
        showToastMessage(viewDetailsModel.meta!.msg.toString());
        isViewOrderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}
