import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogCard extends StatelessWidget {
  const AlertDialogCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            alertDialogCard(context);
          },
          child: Text("data")),
    );
  }

  alertDialogCard(BuildContext context) {
    var alertDialog = CupertinoAlertDialog(
      title: Text(LocaleKeys.location_card_text1.locale),
      content: Text(LocaleKeys.location_card_text2.locale),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(LocaleKeys.location_card_button1.locale),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {},
          child: Text(LocaleKeys.location_card_button2.locale),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
