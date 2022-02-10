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
  String email = "dongu@support.com";
  void customLaunch() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      print('Could not launch');
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
          Text(
            widget.trailingText == null ? "" : widget.trailingText!,
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
        customLaunch();
      },
    );
  }
}
