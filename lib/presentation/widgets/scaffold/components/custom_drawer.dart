import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/components/drawer_body_title.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/components/drawer_list_tile.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Drawer(
        child: Container(
          color: AppColors.scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.only(bottom: context.dynamicHeight(0.1)),
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Profile',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyTitleStyle,
                    ),
                    Row(
                      children: [
                        Spacer(flex: 1),
                        CustomButton(
                          width: context.dynamicWidht(0.4),
                          title: "Giriş Yap",
                          textColor: AppColors.greenColor,
                          color: Colors.transparent,
                          borderColor: AppColors.greenColor,
                        ),
                        Spacer(flex: 1),
                        CustomButton(
                          width: context.dynamicWidht(0.4),
                          title: "Üye Ol",
                          textColor: Colors.white,
                          color: AppColors.greenColor,
                          borderColor: AppColors.greenColor,
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackgroundColor,
                ),
              ),
              DrawerListTile(
                title: "Bilgilerim",
              ),
              DrawerListTile(
                title: "Geçmiş Siparişlerim",
              ),
              DrawerListTile(
                title: "Adreslerim",
              ),
              DrawerListTile(
                title: "Kayıtlı Kartlarım",
              ),
              DrawerListTile(
                title: "Bana Özel Fırsatlar",
              ),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              DrawerBodyTitle(
                text: "Ayarlar",
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              DrawerListTile(
                title: "Genel Ayarlar",
              ),
              DrawerListTile(
                title: "Dil Ayarları",
              ),
              DrawerListTile(
                title: "Bölge Değiştir",
              ),
              DrawerListTile(
                title: "Uygulamayı Değerlendirin",
              ),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              DrawerBodyTitle(
                text: "Hakkında",
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              DrawerListTile(
                title: "Uygulama Hakkında",
              ),
              DrawerListTile(
                title: "Gıda İsrafı Hakkında",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
