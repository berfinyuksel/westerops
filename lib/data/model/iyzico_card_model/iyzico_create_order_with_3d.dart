// To parse this JSON data, do
//
//     final iyzicoOrderCreateWith3D = iyzicoOrderCreateWith3DFromJson(jsonString);

import 'dart:convert';

class IyzicoOrderCreateWith3D {
  IyzicoOrderCreateWith3D({
    this.status,
    this.errorCode,
    this.errorMessage,
    this.locale,
    this.systemTime,
    this.conversationId,
    this.threeDsHtmlContent,
  });

  final String? status;
  final String? errorCode;
  final String? errorMessage;
  final String? locale;
  final int? systemTime;
  final String? conversationId;
  final String? threeDsHtmlContent;

  factory IyzicoOrderCreateWith3D.fromRawJson(String str) =>
      IyzicoOrderCreateWith3D.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IyzicoOrderCreateWith3D.fromJson(Map<String, dynamic> json) =>
      IyzicoOrderCreateWith3D(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        errorMessage:
            json["errorMessage"] == null ? null : json["errorMessage"],
        locale: json["locale"] == null ? null : json["locale"],
        systemTime: json["systemTime"] == null ? null : json["systemTime"],
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        threeDsHtmlContent: json["threeDSHtmlContent"] == null
            ? null
            : json["threeDSHtmlContent"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "errorCode": errorCode == null ? null : errorCode,
        "errorMessage": errorMessage == null ? null : errorMessage,
        "locale": locale == null ? null : locale,
        "systemTime": systemTime == null ? null : systemTime,
        "conversationId": conversationId == null ? null : conversationId,
        "threeDSHtmlContent":
            threeDsHtmlContent == null ? null : threeDsHtmlContent,
      };
}
