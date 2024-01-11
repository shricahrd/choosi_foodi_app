import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../group_order/model/rest_group_order_model.dart';

class GOSalesHistoryController extends GetxController{
  int fileID = 1;

  RestGroupOrderModel saleHistoryModel = RestGroupOrderModel();

  bool isLoaderVisible = false;

  callGetSalesHistoryAPI(final uri) {
    isLoaderVisible = !isLoaderVisible;
    update();

    debugPrint('Uri: $uri');

    getRequest(uri).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        saleHistoryModel = RestGroupOrderModel.fromJson(mResponse);
        if (saleHistoryModel.meta?.status == true) {
          debugPrint('status true: ${saleHistoryModel.meta?.status}');
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(saleHistoryModel.meta?.msg?? "");
        isLoaderVisible = false;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  Future<void> createExcel({required RestGroupOrderModel normalRestOrderModel, dynamic commission}) async{
    fileID++;
    update();
    print('fileID: $fileID');
    final Workbook workbook = Workbook();
    final Worksheet sheet1 = workbook.worksheets[0];
    String deliveryDate = "";

    String parseTimeCreated(int value) {
      var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
      var d12 = formatterMonthWithTime.format(date);
      deliveryDate = d12;
      // print('Completion: $deliveryDate');
      return d12;
    }

    for(int i=1; i<= 5; i++){
      sheet1.getRangeByIndex(1, i).columnWidth = 19.86;
    }
    sheet1.getRangeByIndex(1, 6).columnWidth = 23;
    sheet1.getRangeByIndex(1, 7).columnWidth = 28;

    sheet1.getRangeByName('A1:L1').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A1:L1').cellStyle.hAlign = HAlignType.left;
    sheet1.getRangeByName('A1:L1').cellStyle.vAlign = VAlignType.center;
    sheet1.getRangeByName('A1:L1').cellStyle.bold = true;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.color = '#BFBFBF';

    sheet1.getRangeByIndex(1, 1).text = 'Order ID';
    sheet1.getRangeByIndex(1, 2).text = 'Order Type';
    sheet1.getRangeByIndex(1, 3).text = 'Customer name';
    sheet1.getRangeByIndex(1, 4).text = 'Sale Amount(in \$)';
    sheet1.getRangeByIndex(1, 5).text = 'You Earned(in \$)';
    sheet1.getRangeByIndex(1, 6).text = 'Commission Amount(in \$)';
    sheet1.getRangeByIndex(1, 7).text = 'Delivered On Date';

    if(normalRestOrderModel.data?.isNotEmpty == true) {
      for (int i = 0; i < (normalRestOrderModel.data?.length ?? 0); i++) {
        dynamic total, youEarned, commissionAmt;
        if(normalRestOrderModel.data?[i].createdAt == 0){
          deliveryDate = "";
        }else {
          parseTimeCreated(int.parse(normalRestOrderModel.data?[i].deliveryDate.toString() ?? ""));
        }

        if( normalRestOrderModel.data?[i].total != null) {
          total = normalRestOrderModel.data?[i].total.toString();
          // print('total: $total');
          commissionAmt = (double.parse(total) * commission / 100);
          youEarned = (double.parse(total) - commissionAmt);
        }else{
          youEarned = 0;
        }

        sheet1.getRangeByIndex(i+2, 1).text = normalRestOrderModel.data?[i].groupOrderID;
        sheet1.getRangeByIndex(i+2, 2).text = normalRestOrderModel.data?[i].orderType;
        sheet1.getRangeByIndex(i+2, 3).text = normalRestOrderModel.data?[i].userData.firstName;
        sheet1.getRangeByIndex(i+2, 4).text = normalRestOrderModel.data?[i].total.toStringAsFixed(2);
        sheet1.getRangeByIndex(i+2, 5).text = youEarned.toStringAsFixed(2);
        sheet1.getRangeByIndex(i+2, 6).text = commissionAmt.toStringAsFixed(2);
        sheet1.getRangeByIndex(i+2, 7).text = deliveryDate;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/GroupOrderSalesHistory$fileID.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    print('FileName: $fileName');
    await OpenFilex.open(fileName);
  }
}
