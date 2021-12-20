import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AuthRequestModel{
  final int sms;
  final String challenge;
  final String token;

  AuthRequestModel({
    required this.sms,
    required this.challenge,
    required this.token,
  });

  factory AuthRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthRequestModel(
      sms: json['sms'],
      challenge: json['challenge'],
      token: json['token'],
    );
  }
}
