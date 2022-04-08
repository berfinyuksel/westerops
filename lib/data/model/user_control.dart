// To parse this JSON data, do
//
//     final userControl = userControlFromJson(jsonString);

import 'dart:convert';

UserControl userControlFromJson(String str) => UserControl.fromJson(json.decode(str));

String userControlToJson(UserControl data) => json.encode(data.toJson());

class UserControl {
    UserControl({

        this.facebookEmail,
        this.googleEmail,
        this.appleEmail,

    });

    dynamic facebookEmail;
    dynamic googleEmail;
    dynamic appleEmail;
   

    factory UserControl.fromJson(Map<String, dynamic> json) => UserControl(
 
        facebookEmail: json["facebook_email"],
        googleEmail: json["google_email"],
        appleEmail: json["apple_email"],
    );

    Map<String, dynamic> toJson() => {

        "facebook_email": facebookEmail,
        "google_email": googleEmail,
        "apple_email": appleEmail,

    };
}



