// To parse this JSON data, do
//
//     final iyzcoRegisteredCard = iyzcoRegisteredCardFromJson(jsonString);

import 'dart:convert';

class IyzcoRegisteredCard {
  IyzcoRegisteredCard({
    this.status,
    this.locale,
    this.systemTime,
    this.conversationId,
    this.cardUserKey,
    this.cardDetails,
  });

  String? status;
  String? locale;
  int? systemTime;
  String? conversationId;
  String? cardUserKey;
  List<CardDetail>? cardDetails;

  factory IyzcoRegisteredCard.fromRawJson(String str) =>
      IyzcoRegisteredCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IyzcoRegisteredCard.fromJson(Map<String, dynamic> json) =>
      IyzcoRegisteredCard(
        status: json["status"] == null ? null : json["status"],
        locale: json["locale"] == null ? null : json["locale"],
        systemTime: json["systemTime"] == null ? null : json["systemTime"],
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        cardUserKey: json["cardUserKey"] == null ? null : json["cardUserKey"],
        cardDetails: json["cardDetails"] == null
            ? null
            : List<CardDetail>.from(
                json["cardDetails"].map((x) => CardDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "locale": locale == null ? null : locale,
        "systemTime": systemTime == null ? null : systemTime,
        "conversationId": conversationId == null ? null : conversationId,
        "cardUserKey": cardUserKey == null ? null : cardUserKey,
        "cardDetails": cardDetails == null
            ? null
            : List<dynamic>.from(cardDetails!.map((x) => x.toJson())),
      };
}

class CardDetail {
  CardDetail({
    this.cardToken,
    this.cardAlias,
    this.binNumber,
    this.lastFourDigits,
    this.cardType,
    this.cardAssociation,
    this.cardFamily,
    this.cardBankCode,
    this.cardBankName,
  });

  String? cardToken;
  String? cardAlias;
  String? binNumber;
  String? lastFourDigits;
  String? cardType;
  String? cardAssociation;
  String? cardFamily;
  int? cardBankCode;
  String? cardBankName;

  factory CardDetail.fromRawJson(String str) =>
      CardDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardDetail.fromJson(Map<String, dynamic> json) => CardDetail(
        cardToken: json["cardToken"] == null ? null : json["cardToken"],
        cardAlias: json["cardAlias"] == null ? null : json["cardAlias"],
        binNumber: json["binNumber"] == null ? null : json["binNumber"],
        lastFourDigits:
            json["lastFourDigits"] == null ? null : json["lastFourDigits"],
        cardType: json["cardType"] == null ? null : json["cardType"],
        cardAssociation:
            json["cardAssociation"] == null ? null : json["cardAssociation"],
        cardFamily: json["cardFamily"] == null ? null : json["cardFamily"],
        cardBankCode:
            json["cardBankCode"] == null ? null : json["cardBankCode"],
        cardBankName:
            json["cardBankName"] == null ? null : json["cardBankName"],
      );

  Map<String, dynamic> toJson() => {
        "cardToken": cardToken == null ? null : cardToken,
        "cardAlias": cardAlias == null ? null : cardAlias,
        "binNumber": binNumber == null ? null : binNumber,
        "lastFourDigits": lastFourDigits == null ? null : lastFourDigits,
        "cardType": cardType == null ? null : cardType,
        "cardAssociation": cardAssociation == null ? null : cardAssociation,
        "cardFamily": cardFamily == null ? null : cardFamily,
        "cardBankCode": cardBankCode == null ? null : cardBankCode,
        "cardBankName": cardBankName == null ? null : cardBankName,
      };
}
