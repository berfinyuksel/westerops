import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/image_constant.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';

class RestaurantInfoTile extends StatelessWidget {
  final SearchStore? restaurant;
  const RestaurantInfoTile({
    Key? key,
    this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            restaurantLogoContainer(context),
            restaurantTitleAndAddressColumn(),
          ],
        ),
      ),
    );
  }

  Container restaurantLogoContainer(BuildContext context) {
    return Container(
        width: context.dynamicWidht(0.22),
        height: context.dynamicHeight(0.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(
            width: 2.0.w,
            color: AppColors.borderAndDividerColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.dynamicHeight(0.0053),
            horizontal: context.dynamicHeight(0.0056),
          ),
          child: Image.network(restaurant!.photo!),
        ));
  }

  Widget restaurantTitleAndAddressColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.topRight, child: restaurantStarIconRating()),
          Text(
            restaurant!.name!,
            style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.w),
          AutoSizeText(
            restaurant!.address!,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Row restaurantStarIconRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(ImageConstant.RESTAURANT_STAR_ICON),
        SizedBox(width: 10.w),
        Text(
          restaurant!.avgReview!.toStringAsFixed(1),
          style: AppTextStyles.bodyTextStyle,
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
