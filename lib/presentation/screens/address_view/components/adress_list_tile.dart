import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class AddressListTile extends StatefulWidget {
  final Widget? trailing;
  final Widget? leading;

  final String? title;
  final String? subtitleBold;
  final VoidCallback? onTap;
  final String? address;
  final String? phoneNumber;
  final String? description;

  const AddressListTile({
    Key? key,
    this.title,
    this.leading,
    this.trailing,
    this.subtitleBold,
    this.address,
    this.phoneNumber,
    this.description,
    this.onTap,
  }) : super(key: key);

  @override
  State<AddressListTile> createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      contentPadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
          top: context.dynamicHeight(0.01),
          bottom: context.dynamicHeight(0.01)),
      trailing: widget.trailing,
      tileColor: Colors.white,
      title: Text(
        widget.title!,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: AutoSizeText.rich(
        TextSpan(
          style:
              AppTextStyles.headlineStyle.copyWith(color: AppColors.textColor),
          children: [
            TextSpan(
              text: widget.subtitleBold,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            // TextSpan(text: "       "), bosluk verilecek

            TextSpan(
              text: widget.address,
              style: AppTextStyles.subTitleStyle,
            ),
            TextSpan(
              text: widget.phoneNumber,
              style: AppTextStyles.subTitleStyle,
            ),
            TextSpan(
              text: widget.description,
              style: AppTextStyles.subTitleStyle,
            ),
          ],
        ),
        textAlign: TextAlign.start,
        maxLines: 7,
      ),
      onTap: widget.onTap,
    );
  }
}
