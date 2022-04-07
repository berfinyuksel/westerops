// To parse this JSON data, do
//
//     final errorMessage = errorMessageFromJson(jsonString);

import 'dart:convert';

ErrorMessage errorMessageFromJson(String str) => ErrorMessage.fromJson(json.decode(str));

String errorMessageToJson(ErrorMessage data) => json.encode(data.toJson());

class ErrorMessage {
    ErrorMessage({
        this.status,
        this.errorCode,
        this.errorMessage,
        this.errorGroup,
        this.locale,
        this.systemTime,
        this.conversationId,
        this.mdStatus,
        this.paymentStatus,
    });

    String? status;
    String? errorCode;
    String? errorMessage;
    String? errorGroup;
    String? locale;
    int? systemTime;
    String? conversationId;
    int? mdStatus;
    String? paymentStatus;

    factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        errorMessage: json["errorMessage"] == null ? null : json["errorMessage"],
        errorGroup: json["errorGroup"] == null ? null : json["errorGroup"],
        locale: json["locale"] == null ? null : json["locale"],
        systemTime: json["systemTime"] == null ? null : json["systemTime"],
        conversationId: json["conversationId"] == null ? null : json["conversationId"],
        mdStatus: json["mdStatus"] == null ? null : json["mdStatus"],
        paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "errorCode": errorCode == null ? null : errorCode,
        "errorMessage": errorMessage == null ? null : errorMessage,
        "errorGroup": errorGroup == null ? null : errorGroup,
        "locale": locale == null ? null : locale,
        "systemTime": systemTime == null ? null : systemTime,
        "conversationId": conversationId == null ? null : conversationId,
        "mdStatus": mdStatus == null ? null : mdStatus,
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
    };
}
