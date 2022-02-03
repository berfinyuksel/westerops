import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class ClarificationScrollBarListView extends StatelessWidget {
  const ClarificationScrollBarListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      height: context.dynamicHeight(0.7),
      child: RawScrollbar(
        thumbColor: AppColors.greenColor,
        thickness: 10,
        radius: Radius.circular(10.0),
        isAlwaysShown: true,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.22),
              ),
              child: Text(
                "A. Veri Sorumlusu ve Temsilcisi",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                // alignment: TextAlign.center,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "6698 sayılı Kişisel Verilerin Korunması Kanunu (“Kanun”) uyarınca, kişisel verileriniz; veri sorumlusu olarak Westerops Bilişim Ve Yazilim Hizmetleri Limited Şirketi (“Şirket”) tarafından aşağıda açıklanan kapsamda işlenebilecektir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.13),
              ),
              child: Text(
                "B. Hangi Kişisel Verilerin İşleneceği",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                // alignment: TextAlign.center,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "Aksi açıkça belirtilmedikçe, işbu Aydınlatma Metni kapsamında arz edilen hüküm ve koşullar kapsamında “Kişisel Veri” ifadesi aşağıda yer alan bilgileri tanımlamaktadır. Kanun’un 3 ve 7. maddesi uyarınca, geri döndürülemeyecek şekilde anonim hale getirilen veriler, Kanun hükümleri uyarınca kişisel veri olarak kabul edilmeyecek ve bu verilere ilişkin işleme faaliyetleri işbu Aydınlatma Metni hükümleri ile bağlı olmaksızın gerçekleştirecektir. Tarafımızca işletilmekte olan Döngü uygulaması kapsamında (“Uygulama”), Uygulama kullanıcısı (“Kullanıcı”) tarafından üyelik girişi ve Uygulama’nın kullanımı esnasında elektronik ortamda sağlanan kimlik bilgisi (isim, soyisim, doğrum tarihi, siparişe göre TC kimlik numarası / vergi numarası) iletişim bilgisi (telefon, adres, email), kullanıcı bilgisi, kullanıcı işlem bilgisi, görsel/işitsel veri, işlem bilgisi, işlem güvenliği bilgisi, risk yönetimi bilgisi, lokasyon/konum bilgisi, pazarlama bilgisi, IP adresi, sipariş içeriği ve talep/şikâyet yönetimi bilgisine ilişkin veriler işlenmektedir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Text(
              "C. Kişisel Verilerin Hangi Amaçla İşleneceği",
              style: AppTextStyles.bodyBoldTextStyle
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              // alignment: TextAlign.center,
              // maxLines: 1,
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "Toplanan kişisel verileriniz;\n• Kullanıcı’nın Uygulama’dan faydalanabilmesi,\n• Şirket tarafından sunulan ürün ve hizmetlerden ilgili kişileri faydalandırmak için gerekli çalışmaların iş birimleri tarafından yapılması,\n• İş ortakları ve/veya tedarikçilerin bilgiye erişim yetkilerinin planlanması ve iş ortakları ve/veya tedarikçilerle ilişkilerin yönetimi,\n•	Uygulama’ya konu hizmetlerin sağlanması ve iyileştirilmesi için gerekli olan faaliyetlerin doğasından kaynaklanan işlemlerin yerine getirilmesi,\n•	Şirket’in ticari ve iş stratejilerinin belirlenmesi ve uygulanması, raporlama ve iş geliştirme faaliyetlerinin yürütülmesi,\n• Kullanıcılar’ın kişisel tercih ve beğenileri dikkate alınarak Kullanıcı’ya tercihleri doğrultusunda önerilerin sunulması ve buna ilişkin faaliyetlerin yürütülmesi,\n• Kullanıcı’nın talebine istinaden Uygulama üzerinden sunulan özelleştirmelerin aktifleştirilmesi ve bu kapsamda kişiye özel hizmetlerin sunulması,\n• Şirket’in sunduğu ürün ve/veya hizmetlere bağlılık oluşturulması ve/veya arttırılması süreçlerinin planlanması ve/veya icrası kapsamında Şirket’in sunduğu hizmetlerin iyileştirilmesi, yeni hizmetlerin tanıtılması ve bu doğrultuda Kullanıcı’ya gerekli bilgilendirmelerin yapılması,\n• Kullanıcı deneyiminin iyileştirilmesi için gerekli faaliyetlerin icrası (iletişim yönetimi süreçlerinin geliştirilmesi, memnuniyet anketlerinin yürütülmesi) ve Kullanıcı’nın talep ve/veya şikayetlerinin takibi,\n•Şirket’in sunduğu ürün ve hizmetlerin satış ve pazarlaması için pazar araştırması faaliyetlerinin planlanması ve icrası,\n• Şirket tarafından yürütülen faaliyetlerin gerçekleştirilmesi için ilgili iş birimlerimiz tarafından gerekli çalışmaların yapılması ve buna bağlı iş süreçlerinin yürütülmesi,\n• Şirket tarafından sunulan hizmetlerin ilgili kişilere sunulması, önerilmesi ve tanıtılması için gerekli olan aktivitelerin planlanması ve icrası,\n• Uygulama tarafından kullanılan yapay zekanın geliştirilmesi faaliyetlerinin yönetilmesi ve icrası amaçlarıyla (“Amaçlar”) Kanun’un 5. ve 6. maddelerinde belirtilen kişisel veri işleme şartları dahilinde işlenebilecektir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.15),
              ),
              child: Text(
                "D. İşlenen Kişisel Verilerin Kimlere ve Hangi Amaçla Aktarılabileceği",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                // alignment: TextAlign.center,
                // maxLines: 1,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "Toplanan Kişisel Verileriniz; Şirket tarafından Amaçlar’ın gerçekleştirilmesi kapsamında, yurt içinde veya yurt dışındaki grup şirketlerimize, iş ortaklarımıza ve tedarikçilerimize Kanun’un 8. ve 9. maddelerinde belirtilen kişisel veri işleme şartları ve amaçları çerçevesinde aktarılabilecektir. Şirket, yukarıda anılan Amaçlar’ın yerine getirilmesi ile sınırlı olarak, barındırma hizmeti almak için kişisel verileri Kullanıcı’nın ikamet ettiği ülke dışında dünyanın herhangi bir yerinde bulunan sunucularına (sunucular kendisine, bağlı şirketlerine, alt yüklenicilerine veya dış kaynak hizmet sağlayıcılara ait olabilir) aktarma hakkına sahiptir. Kişisel verilerinizin siparişiniz ile ilgili kısmı, siparişin size ulaşmasını sağlamak üzere izniniz ve siparişin size sağlıklı ulaşabilmesi çerçevesinde kuryeye aktarılabilecektir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.13),
              ),
              child: Text(
                "E. Kişisel Veri Toplamanın Yöntemi ve Hukuki Sebebi",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                // alignment: TextAlign.center,
                // maxLines: 1,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "Kişisel verileriniz, yukarıda belirtilen Amaçlar doğrultusunda elektronik ortamda Kanun’un 5. ve 6. maddelerinde belirtilen kişisel veri işleme şartlarına dayalı olarak Uygulama üzerinden veya üçüncü tarafların aracılığıyla toplanmaktadır.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.10),
              ),
              child: Text(
                "F. Kişisel Veri Sahibinin Kanun’un 11. Maddesinde Sayılan Hakları",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                // alignment: TextAlign.center,
                // maxLines: 1,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: Text(
                "Kişisel veri sahibi olarak Kanun’un 11. maddesi uyarınca aşağıdaki haklara sahip olduğunuzu bildiririz:\n•	Kişisel verilerinizin işlenip işlenmediğini öğrenme,\n•	Kişisel verileriniz işlenmişse buna ilişkin bilgi talep etme,\n•	Kişisel verilerinizin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme,\n•	Yurt içinde veya yurt dışında kişisel verilerinizin aktarıldığı üçüncü kişileri bilme,\n•	Kişisel verilerinizin eksik veya yanlış işlenmiş olması hâlinde bunların düzeltilmesini isteme ve bu kapsamda yapılan işlemin kişisel verilerinizin aktarıldığı üçüncü kişilere bildirilmesini isteme,\n•	Kanun’a ve ilgili diğer kanun hükümlerine uygun olarak işlenmiş olmasına rağmen, işlenmesini gerektiren sebeplerin ortadan kalkması hâlinde kişisel verilerin silinmesini veya yok edilmesini isteme ve bu kapsamda yapılan işlemin kişisel verilerinizin aktarıldığı üçüncü kişilere bildirilmesini isteme,\n•	İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle aleyhinize bir sonucun ortaya çıkması durumunda buna itiraz etme,\n•	Kişisel verilerinizin kanuna aykırı olarak işlenmesi sebebiyle zarara uğramanız hâlinde zararın giderilmesini talep etme.\nYukarıda sıralanan haklarınıza yönelik başvurularınızı “destek@dongu.com” adresine yazılı olarak veya mevzuat/ Kişisel Verileri Koruma Kurulu tarafından öngörülen diğer yöntemler ile iletebilirsiniz.  Talebinizin niteliğine göre en kısa sürede ve en geç otuz gün içinde başvurularınız ücretsiz olarak sonuçlandırılacaktır; ancak işlemin ayrıca bir maliyet gerektirmesi halinde Kişisel Verileri Koruma Kurulu tarafından belirlenecek tarifeye göre tarafınızdan ücret talep edilebilecektir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
          ],
        ),
      ),
    );
  }
}
