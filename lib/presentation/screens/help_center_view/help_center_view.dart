import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/custom_expansion_tile.dart' as custom;

class HelpCenterView extends StatefulWidget {
  @override
  _HelpCenterViewState createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.help_center_title,
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        HelpCenterBodyTitle(
          text: LocaleKeys.help_center_body_title_1,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_1,
            LocaleKeys.help_center_list_tile_subtitle_1),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_2,
            LocaleKeys.help_center_list_tile_subtitle_2),
        // buildExpansionTile(
        //     context, LocaleKeys.help_center_list_tile_title_3, ""),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        HelpCenterBodyTitle(
          text: LocaleKeys.help_center_body_title_2,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_4,
            LocaleKeys.help_center_list_tile_subtitle_4),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_5,
            LocaleKeys.help_center_list_tile_subtitle_5),
        // buildExpansionTile(
        //     context, LocaleKeys.help_center_list_tile_title_6, ""),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_7,
            LocaleKeys.help_center_list_tile_subtitle_7),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_8,
            LocaleKeys.help_center_list_tile_subtitle_8),
        buildExpansionTile(context, LocaleKeys.help_center_list_tile_title_9,
            LocaleKeys.help_center_list_tile_subtitle_9),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_10,
          LocaleKeys.help_center_list_tile_subtitle_10,
        ),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_12,
          LocaleKeys.help_center_list_tile_subtitle_12,
        ),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_13,
          LocaleKeys.help_center_list_tile_subtitle_13,
        ),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_14,
          LocaleKeys.help_center_list_tile_subtitle_14,
        ),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_15,
          LocaleKeys.help_center_list_tile_subtitle_15,
        ),
        buildExpansionTile(
          context,
          LocaleKeys.help_center_list_tile_title_16,
          LocaleKeys.help_center_list_tile_subtitle_16,
        ),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildContactListTile(context),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
      ],
    );
  }

  ListTile buildContactListTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Text(
        "+90 850 123 123 23 23",
        style: AppTextStyles.subTitleStyle,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: LocaleKeys.help_center_list_tile_title_11,
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {
        customLaunch("tel: +90 850 123 123 23 23");
      },
    );
  }

  Theme buildExpansionTile(
      BuildContext context, String title, String expandedText) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: custom.ExpansionTile(
        tilePadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: LocaleText(
            text: title, style: AppTextStyles.myInformationBodyTextStyle),
        childrenPadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        children: [
          LocaleText(
            text: expandedText,
            style: AppTextStyles.subTitleStyle,
          ),
          Divider(
            color: AppColors.borderAndDividerColor,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}

class HelpCenterBodyTitle extends StatelessWidget {
  final String? text;
  const HelpCenterBodyTitle({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: text!,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }
}
