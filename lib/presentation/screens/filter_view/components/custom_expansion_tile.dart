import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/presentation/screens/help_center_view/components/custom_expansion_tile.dart'
    as custom;

class CustomExpansionTile extends StatelessWidget {
  final Widget expansionTileBody;
  final String expansionTileTitle;
  const CustomExpansionTile(
      {Key? key,
      required this.expansionTileBody,
      required this.expansionTileTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: custom.ExpansionTile(
        tilePadding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06)),
        backgroundColor: Colors.white,
        title: LocaleText(
          text: expansionTileTitle,
          style: AppTextStyles.bodyTitleStyle,
        ),

        children: [
          expansionTileBody,
        ],
      ),
    );
  }
}