import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListTile extends StatefulWidget {
  final String? text;
  final String? trailingText;

  const ContactListTile({Key? key, this.text, this.trailingText})
      : super(key: key);

  @override
  State<ContactListTile> createState() => _ContactListTileState();
}

class _ContactListTileState extends State<ContactListTile> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LocaleText(
            text: widget.trailingText == null ? "" : widget.trailingText,
            style: AppTextStyles.subTitleStyle,
          ),
          SizedBox(width: context.dynamicWidht(0.06)),
          SvgPicture.asset(
            ImageConstant.COMMONS_FORWARD_ICON,
          ),
        ],
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: widget.text,
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {
        customLaunch('tel:+90 850 123 123 23 23');
      },
    );
  }
}
