import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_task/models/auth_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/screens/otp_screen.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final phoneMask = MaskTextInputFormatter(
    mask: '(##) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  ).obs;

  final phoneController = TextEditingController().obs;
  RxBool validate = false.obs;
  late AuthRequestModel auth;

  Future<AuthRequestModel?> fetchAuthRequestModel() async {
    isLoading.value = true;
    try {
      RegExp expression = RegExp("[^0-9]");
      String phoneNumber = phoneController.value.text.replaceAll(
        expression,
        '',
      );
      http.Response response = await http.get(
        Uri.parse(
          'https://api.moyki24.com.ua/sms/request?phone=0$phoneNumber',
        ),
      );
      if (response.statusCode == 200) {
        auth = Get.put(
          AuthRequestModel.fromJson(
            jsonDecode(
              response.body,
            ),
          ),
        );
        return auth;
      }
    } catch (e) {
      print('Exception: $e');
    }
    isLoading.value = false;
  }

  Future<void> onButtonPressed() async {
    if (phoneController.value.text.length < 14) {
      validate.value = true;
      return;
    }
    Get.deleteAll();
    validate.value = false;
    await fetchAuthRequestModel();
    Get.appUpdate();
    Get.to(() => const OtpScreen());
  }
}
