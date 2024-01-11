import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/get_payment_history_model.dart.dart';

class GetPaymentController extends GetxController{
  int fileID = 1;
  GetPaymentHistoryModel getPaymentHistoryModel = GetPaymentHistoryModel();
  bool isLoaderVisible = false;
  String createdDate = "";

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    debugPrint('createdDate: $createdDate');
    return d12;
  }

  Future<void> createExcel({required GetPaymentHistoryModel getPaymentHistoryModel}) async{
    fileID++;
    update();
    final Workbook workbook = Workbook();
    final Worksheet sheet1 = workbook.worksheets[0];
    // final Worksheet sheet1 = workbook.worksheets.addWithName('PaymentHistory');
    // sheet1.showGridlines = false;
    // sheet1.getRangeByName('A1').setText('Hello World!');
    // sheet1.getRangeByIndex(1, 1).columnWidth = 19.86;
    // sheet1.getRangeByIndex(1, 2).columnWidth = 19.86;

    for(int i=1; i<= 7; i++){
      sheet1.getRangeByIndex(1, i).columnWidth = 19.86;
    }

    sheet1.getRangeByIndex(1, 8).columnWidth = 30.86;

    sheet1.getRangeByName('A1:L1').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A1:L1').cellStyle.hAlign = HAlignType.left;
    sheet1.getRangeByName('A1:L1').cellStyle.vAlign = VAlignType.center;
    sheet1.getRangeByName('A1:L1').cellStyle.bold = true;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet1.getRangeByName('A1:L1').cellStyle.borders.all.color = '#BFBFBF';

    sheet1.getRangeByIndex(1, 1).text = 'Transaction Id';
    sheet1.getRangeByIndex(1, 2).text = 'Amount Received';
    sheet1.getRangeByIndex(1, 3).text = 'Bank';
    sheet1.getRangeByIndex(1, 4).text = 'Account Number';
    sheet1.getRangeByIndex(1, 5).text = 'Routing Number';
    sheet1.getRangeByIndex(1, 6).text = 'Payment Date';
    sheet1.getRangeByIndex(1, 7).text = 'Payment Method';
    sheet1.getRangeByIndex(1, 8).text = 'Payment Id';

    if(getPaymentHistoryModel.data?.isNotEmpty == true) {
      for (int i = 0; i < (getPaymentHistoryModel.data?.length ?? 0); i++) {
            if(getPaymentHistoryModel.data?[i].createdAt == 0){
              createdDate = "";
            }else {
              parseTimeCreated(int.parse(getPaymentHistoryModel.data?[i].createdAt.toString() ?? ""));
            }
            sheet1.getRangeByIndex(i+2, 1).text = getPaymentHistoryModel.data?[i].transactionId.toString();
            sheet1.getRangeByIndex(i+2, 2).text = getPaymentHistoryModel.data?[i].paidAmount.toString();
            sheet1.getRangeByIndex(i+2, 3).text = getPaymentHistoryModel.data?[i].restaurantData.bankInformation.bankName.toString();
            sheet1.getRangeByIndex(i+2, 4).text = getPaymentHistoryModel.data?[i].restaurantData.bankInformation.accountNumber.toString();
            sheet1.getRangeByIndex(i+2, 5).text = getPaymentHistoryModel.data?[i].restaurantData.bankInformation.routingNumber.toString();
            sheet1.getRangeByIndex(i+2, 6).text = createdDate;
            sheet1.getRangeByIndex(i+2, 7).text = getPaymentHistoryModel.data?[i].paymentMode.toString();
            sheet1.getRangeByIndex(i+2, 8).text = getPaymentHistoryModel.data?[i].paymentId.toString();
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/PaymentHistory$fileID.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    debugPrint('FileName: $fileName');
    await OpenFilex.open(fileName);
  }


  callGetPaymentHistoryAPI() {
    isLoaderVisible = !isLoaderVisible;
    update();

    getRequest(GeneralPath.API_REST_PAYMENT_LIST).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getPaymentHistoryModel = GetPaymentHistoryModel.fromJson(mResponse);
        if (getPaymentHistoryModel.meta?.status == true) {
          debugPrint('status true: ${getPaymentHistoryModel.meta?.status}');
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(getPaymentHistoryModel.meta?.msg?? "");
        isLoaderVisible = false;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}
