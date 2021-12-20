import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/constants/constants.dart';
import 'package:test_task/models/auth_request_model.dart';
import 'package:test_task/models/user_model.dart';
import 'package:test_task/screens/scan_screen.dart';

class OtpController extends GetxController {
  final otpMask = MaskTextInputFormatter(
    mask: '######',
    filter: {"#": RegExp(r'[0-9]')},
  ).obs;

  final otpController = TextEditingController().obs;
  final AuthRequestModel auth = Get.find();

  Future<void> onPressed() async {
    String sms = auth.sms.toString();
    if (otpController.value.text != sms) {
      Get.snackbar('Ошибка!', 'Неверный код');
      return;
    }
    String token = auth.token;
    var url = 'https://api.moyki24.com.ua/phone';
    var body = json.encode({
      'code': sms,
      'token': token,
    });
    print('Provided body:\n$body');

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      user = UserModel.fromJson(
        jsonDecode(
          response.body,
        ),
      );
      print('Received response: ${response.body}');
      Get.offAll(() => const ScanScreen());
    }
  }
}
