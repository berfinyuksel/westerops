import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
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

  void alertDialogCard(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(LocaleKeys.location_card_text1.locale),
      content: Text(LocaleKeys.location_card_text2.locale),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.location_card_button1.locale,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.location_card_button2.locale,
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
