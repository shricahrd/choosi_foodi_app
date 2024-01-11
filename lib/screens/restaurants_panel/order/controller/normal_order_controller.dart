import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../routes/general_path.dart';
import '../../slots/model/meta_model.dart.dart';
import '../model/normal_rest_order_model.dart';

class NormalRestOrderController extends GetxController {
  NormalRestOrderModel normalRestOrderModel = NormalRestOrderModel();
  List<NormalRestDataList> getFilterOrderModel = [];
  int orderStatus = 0;
  bool isLoaderVisible = true;
  bool isOrderChanged = false;
  MetaModel metaModel = MetaModel();
  bool isDelivered = false;
  List statusList = [];
  int orderStatusFilter = 1;
  Set<String> uniqueNames = Set<String>();

  Future<void> createExcel(String fileDynamicName) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet1 = workbook.worksheets[0];

    sheet1.getRangeByIndex(1, 1).columnWidth = 10;
    sheet1.getRangeByIndex(1, 2).columnWidth = 10;
    sheet1.getRangeByIndex(1, 3).columnWidth = 26;
    sheet1.getRangeByIndex(1, 4).columnWidth = 12;
    sheet1.getRangeByIndex(1, 5).columnWidth = 28;
    sheet1.getRangeByIndex(1, 6).columnWidth = 28;
    sheet1.getRangeByIndex(1, 7).columnWidth = 12;
    sheet1.getRangeByIndex(1, 8).columnWidth = 16;
    sheet1.getRangeByIndex(1, 9).columnWidth = 22;
    sheet1.getRangeByIndex(1, 10).columnWidth = 12;
    sheet1.getRangeByIndex(1, 11).columnWidth = 12;

    sheet1.getRangeByName('A1:L1').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A1:L1').cellStyle.hAlign = HAlignType.center;
    sheet1.getRangeByName('A1:L1').cellStyle.vAlign = VAlignType.center;
    sheet1.getRangeByName('A1:L1').cellStyle.bold = true;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.lineStyle =
        LineStyle.thin;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.color = '#BFBFBF';


    sheet1.getRangeByIndex(1, 1).text = 'First Name';
    sheet1.getRangeByIndex(1, 2).text = 'Last Name';
    sheet1.getRangeByIndex(1, 3).text = 'Order ID';
    sheet1.getRangeByIndex(1, 4).text = 'Total(in \$)';
    sheet1.getRangeByIndex(1, 5).text = 'Order Placed';
    sheet1.getRangeByIndex(1, 6).text = 'Expected Completion';
    sheet1.getRangeByIndex(1, 7).text = 'Status';
    sheet1.getRangeByIndex(1, 8).text = 'Payment Mode';
    sheet1.getRangeByIndex(1, 9).text = 'User Mobile number';
    sheet1.getRangeByIndex(1, 10).text = 'Device Type';
    sheet1.getRangeByIndex(1, 11).text = 'Order Type';

    for (int i = 0; i < (normalRestOrderModel.data?.length ?? 0); i++) {
      sheet1.getRangeByIndex(i + 2, 1).text = normalRestOrderModel.data?[i].userData.firstName;
      sheet1.getRangeByIndex(i + 2, 2).text = normalRestOrderModel.data?[i].userData.lastName;
      sheet1.getRangeByIndex(i + 2, 3).text = normalRestOrderModel.data?[i].menuOrderID.toString();
      sheet1.getRangeByIndex(i + 2, 4).text = normalRestOrderModel.data?[i].total.toString();
      sheet1.getRangeByIndex(i + 2, 5).text = normalRestOrderModel.data?[i].parseCreatedDate.toString();
      sheet1.getRangeByIndex(i + 2, 6).text = "${normalRestOrderModel.data?[i].parseDeliveryDate.toString()} - ${normalRestOrderModel.data?[i].timeSlot.toString()}";
      sheet1.getRangeByIndex(i + 2, 7).text = normalRestOrderModel.data?[i].userData.status;
      sheet1.getRangeByIndex(i + 2, 8).text = normalRestOrderModel.data?[i].paymentMethod;
      sheet1.getRangeByIndex(i + 2, 9).text = normalRestOrderModel.data?[i].mobile.toString();
      sheet1.getRangeByIndex(i + 2, 10).text =
          normalRestOrderModel.data?[i].deviceType;
      sheet1.getRangeByIndex(i + 2, 11).text =
          normalRestOrderModel.data?[i].orderType;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/$fileDynamicName.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    debugPrint('FileName: $fileName');
    await OpenFilex.open(fileName);
  }

  String parseTimeStampReport(dynamic created) {
    var date = DateTime.fromMicrosecondsSinceEpoch(created * 1000);
    // var d12 = formatterDateTime.format(date);
    var d12 = formatterMonthWithTime.format(date);
    return d12;
  }

  String parseDeliveryTime(dynamic val) {
    var date = DateTime.fromMicrosecondsSinceEpoch(val * 1000);
    // var d12 = formatterDateTime.format(date);
    var d12 = formatterMonth.format(date);
    return d12;
  }

  Future<void> callRestGetOrderAPI(
      {required List filterType,
      required String searchString,
       dynamic startDateSearch,
       dynamic endDateSearch,
       dynamic orderType}) async{

    if(startDateSearch == null || startDateSearch == "null"){
      startDateSearch = '';
      endDateSearch = '';
    }else {
        debugPrint('startDateinMiliSec: $startDateSearch');
        debugPrint('endDateinMiliSec $endDateSearch');
    }

    debugPrint('filterType: $filterType');

      if(filterType.contains(1)){
        orderStatusFilter = 1;
      }else if(filterType.contains(6)){
        orderStatusFilter = 6;
      }else{
        orderStatusFilter = 7;
      }
      debugPrint('orderStatusFilter: $orderStatusFilter');
      // update();

    if(orderType == selOrderType){
      orderType = "";
    }else{
      debugPrint('orderType: $orderType');
    }


    // orderStatus1 = orderStatus1.toUpperCase();
    String url = GeneralPath.API_GET_ORDER +
        "?orderStatus=$orderStatusFilter&searchKey=$searchString&startDate=$startDateSearch&endDate=$endDateSearch&orderType=$orderType";
    getFilterOrderModel.clear();
    uniqueNames.clear();
    debugPrint('Url: $url');
    await getRequest(url).then((response) {
      if (response.statusCode == 200) {
        normalRestOrderModel =
            NormalRestOrderModel.fromJson(json.decode(response.body));
        if (normalRestOrderModel.meta?.status == true) {
          debugPrint('status true: ${normalRestOrderModel.meta?.status}');
          debugPrint('Response Data: ${normalRestOrderModel.data}');

          int len = 0;
          for (int i = 0; i < (normalRestOrderModel.data?.length ?? 0); i++) {
            String currentName = normalRestOrderModel.data?[i].menuOrderID ?? "";
            for (int j = 0; j < filterType.length; j++) {
              // Check if the name is not in the Set (not a duplicate)
              if (!uniqueNames.contains(currentName)) {
                normalRestOrderModel.data?[i].setCreatedDate = parseTimeStampReport(normalRestOrderModel.data?[i].createdAt);
                normalRestOrderModel.data?[i].setDeliveryDate = parseDeliveryTime(normalRestOrderModel.data?[i].deliveryDate);
                if (normalRestOrderModel.data?[i].orderStatus == filterType[j]) {
                  len++;
                  getFilterOrderModel.add(normalRestOrderModel.data![i]);
                }
                uniqueNames.add(currentName);
              }

            }
          }

          orderStatus = len;
          update();
          debugPrint('OrderStatus Len: $orderStatus');
          isLoaderVisible = false;
          update();
        } else {
          // showToastMessage(normalRestOrderModel.meta!.msg.toString());
          debugPrint(normalRestOrderModel.meta?.msg.toString());
          orderStatus = 0;
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(normalRestOrderModel.meta?.msg.toString() ?? "");
        debugPrint('Token Issue');
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getFilterOrderModel;
    });
  }


  // API_REST_ORDER_STATUS

  Future<void> changeOrderStatusAPI({
    required String menuId,
    required int status,
  }) async {
    isOrderChanged = !isOrderChanged;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_MENUORDERID: menuId,
      HttpConstants.PARAMS_STATUS: status,
    });

    await putRequest(GeneralPath.API_REST_ORDER_STATUS, params)
        .then((response) {
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          debugPrint('status : ${metaModel.meta?.status}');
          showToastMessage(metaModel.meta?.msg.toString() ?? "");
        } else {
          showToastMessage(metaModel.meta?.msg.toString() ?? "");
        }
        isOrderChanged = !isOrderChanged;
        update();
      } else {
        showToastMessage(metaModel.meta?.msg.toString() ?? "");
        isOrderChanged = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return metaModel;
    });
  }
}
