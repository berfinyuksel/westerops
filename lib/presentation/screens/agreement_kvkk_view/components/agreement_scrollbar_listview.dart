import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class AgreementScrollBarListView extends StatelessWidget {
  const AgreementScrollBarListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "1. Taraflar",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "1.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Döngü, www.dongu.com ve mobil uygulama aracılığıyla (“Uygulama”), “Westerops Bilişim Ve Yazilim Hizmetleri Limited Şirketi” (“Şirket”) tarafından sunulmaktadır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "1.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "İşbu Kullanıcı Sözleşmesi (“Sözleşme”) kapsamında Uygulama’dan faydalanacak olan kullanıcı (“Kullanıcı”), işbu Sözleşme’nin kendisi tarafından onaylanması ile birlikte yürürlüğe gireceğini ve bu Sözleşme’de yer alan düzenlemelere uygun davranmakla yükümlü olduğunu bilmektedir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "1.3 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Sözleşme kapsamında Şirket ve Kullanıcı ayrı ayrı “Taraf” birlikte ise “Taraflar” olarak anılacaklardır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "2. Sözleşme’nin Konusu",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text:
                    "Döngü, Şirket tarafından yönetilen ve Şirket ile Üye İşyeri Sözleşmesi’ni akdetmiş olan üye işyerlerine (“Üye İşyeri”) gün içerisinde arz fazlalığından dolayı satamadıkları yiyecekleri, Kullanıcılar’a gıda kodeksine tam olarak uygun olarak tazeliklerini ve lezzetlerini kaybetmelerine müsade etmeden sunduğu, kullanıcıların da sevdikleri bu yiyeceklere indirimli fiyatlarla ulaşabileceği satışa konu yiyecek ve içecekleri (“Ürünler”) sunma imkanı veren bir satış platformudur. İşbu Sözleşme’nin konusu; Kullanıcılar’ın Uygulama’dan ve Uygulama üzerinden verilen hizmetlerden faydalanmasına ilişkin hüküm ve koşulların belirlenmesi ve bu doğrultuda Taraflar’ın hak ve yükümlülüklerinin düzenlenmesidir.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "3. Tarafların Hak ve Yükümlülükleri",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Platform’dan faydalanmak için Şirket tarafından talep edilen bilgileri tam, doğru ve güncel bir şekilde sağlayarak işbu Sözleşme’yi onaylaması gerektiğini bildiğini beyan eder. Kullanıcı statüsünün tesisi sırasında sağlanan bilgilerde herhangi bir değişiklik olması halinde, söz konusu bilgiler derhal güncellenecektir. Bu bilgilerin eksik veya gerçeğe aykırı olarak verilmesi ya da güncel olmaması nedeniyle Platform’a erişim sağlanamamasından ve bunlardan faydalanılamamasından Şirket sorumlu değildir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı tarafından Site’ye erişim, cep telefon numarası, e-posta adresi ve şifresi kullanılarak gerçekleştirilecektir. Bu şifrenin gizliliğinin ve güvenliğinin korunmasından Kullanıcı sorumlu olacak olup, Site üzerinden söz konusu bilgilerin kullanımı ile gerçekleştirilen her türlü faaliyetin Kullanıcı tarafından gerçekleştirildiği kabul edilecek, bu faaliyetlerden doğan her türlü yasal\nve cezai sorumluluk Kullanıcı’ya ait olacaktır. Kullanıcı, şifresinin yetkisiz kullanımı veya güvenliğin başka şekilde ihlalinden haberdar olduğunda bu durumu derhal Şirket’e bildirecektir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.3 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, işbu Sözleşme’yi akdetmek için gereken yasal ehliyete sahip bulunduğunu beyan eder. Kullanıcı, oluşturulmuş hesaplarını, kullanıcı adı ve şifresi ile üyelik profillerini hiçbir şart ve koşulda başka bir kullanıcıya devredemez veya üçüncü kişilerce kullanımına izin veremez.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.4 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı Uygulama’da gerçekleştireceği tüm işlemlerde işbu Sözleşme ile Uygulama’da zaman zaman yayınlanabilecek koşullar ile kanuna, ahlaka ve adaba, dürüstlük ilkelerine uyacak, herhangi bir yöntem ile Uygulama’nın işleyişini engelleyebilecek davranışlarda, üçüncü kişilerin haklarına tecavüz eden veya etme tehlikesi bulunan fiillerde bulunmayacaktır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.5 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Uygulama’da bulunan yazılım, görsel ve tasarımların, yazıların, logoların, grafiklerin her türlü hakkı Şirket’e aittir. Uygulama’nın tasarımında, içeriğinde ve veritabanı oluşturulmasında kullanılan bilgi ve/veya yazılımın kopyalanması ve/veya Uygulama’dan faydalanmanın ötesinde kullanılması, Uygulama dahilinde bulunan her türlü resim, metin, imge, dosya vb. veriler ile içeriklerin kopyalanması, dağıtılması, işlenmesi ve sair şekillerde kullanılması kesinlikle yasaktır. Ayrıca Kullanıcılar’ın (i) Uygulama’nın güvenliğini tehdit edebilecek, Uygulama’ya ait yazılımların çalışmasını veya diğer Kullanıcılar’ın Uygulama’dan faydalanmasını engelleyebilecek herhangi bir girişimde bulunması, (ii) Uygulama’ya bu sonuçları verecek şekilde orantısız yük bindirmesi, Uygulama’da yayımlanmış ve/veya başkaları tarafından girilmiş bilgilere ve İçerikler’e yetkisiz bir şekilde erişmesi, bu bilgi ve içerikleri kopyalaması, silmesi, değiştirmesi ya da bu yönde denemeler yapması; (iii) Uygulama’nın genel güvenliğini tehdit edecek ve/veya Uygulama, Şirket ve diğer Kullanıcılar’a zarar verebilecek eylemlerde bulunması; (iv) Uygulama’nın ve kullanılan yazılımların çalışmasını engelleyecek yazılımları kullanması, kullanmaya çalışması veya her türlü yazılım, donanım ve sunucuların çalışmasını aksatması, bozulmasına yol açması, tersine mühendislik yapması, saldırılar düzenlemesi, meşgul etmesi veya sair surette müdahale etmesi, Şirket sunucularına erişim sağlamaya çalışması kesinlikle yasaktır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.6 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Uygulama’da yapılacak iyileştirme ve diğer değişikliklerin uygulanması için Uygulama’ya erişimin geçici olarak engellenebileceğini kabul eder. ",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.7 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Şirket’in herhangi bir sebep göstermeksizin ve herhangi bir ihbarda bulunmaksızın işbu Sözleşme ve eki niteliğindeki koşulları dilediği zamanda tek taraflı olarak değiştirme, bunlara ilavede bulunma veya yenileme ve Uygulama’yı yeniden organize etme, konu, kapsam ve içeriğini değiştirme, yayını durdurma hakkı saklıdır. Şirket tarafından yapılan değişiklikler Uygulama’da yayınlandığı tarihte yürürlüğe girecek olup, Uygulama’nın kullanılması ile Kullanıcı güncel koşulları kabul etmiş addedilir. Söz konusu dokümanların düzenli bir şekilde takip edilmesinden Kullanıcı bizzat sorumlu olacaktır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.8 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Uygulama’nın kullanımından ve Uygulama üzerinden ilgili işlemlerin gerçekleştirilmesinden kaynaklanan her türlü yasal, idari ve cezai sorumluluk Kullanıcı’ya aittir. Şirket, Kullanıcı’nın Uygulama üzerinde ve/veya işlemler sırasında gerçekleştirdiği faaliyetler ve/veya işbu Sözleşme ve yasaya aykırı eylemleri neticesinde üçüncü kişilerin uğradıkları veya uğrayabilecekleri zararlardan doğrudan ve/veya dolaylı olarak hiçbir şekilde sorumlu tutulamaz. Üçüncü kişilerden bu kapsamda gelecek her türlü talep ile Kullanıcı’nın Sözleşme’de veya ilgili mevzuatta belirtilen yükümlülüklerini yerine getirmemesi nedeniyle Şirket’in uğrayacağı zararlar ilk talepte ferileri ile birlikte ödenmek üzere Kullanıcı’ya rücu edilecektir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "3.9 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Tütün Mamulleri ve Alkollü İçkilerin Satışına ve Sunumuna İlişkin Usul ve Esaslar Hakkında Yönetmelik ve ilgili mevzuat uyarınca Uygulama üzerinden kesinlikle tütün mamulleri ve alkollü içecek satışı yapılmadığını, tütün mamulleri ve alkollü içecek temin etmemeyi ve Üye İşyeri’ne bu konuda talepte bulunmamayı, aksi takdirde üyeliğinin iptali ve Koşulların feshi ile sonuçlanabileceğini kabul, beyan ve taahhüt eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "4. Hizmetlere İlişkin Koşullar",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Uygulama üzerinden sunulan hizmetlerin tarafı münhasıran Kullanıcı ve Üye İşyeri olup Şirket, yalnızca söz konusu hizmetlerin sunulabilmesi için bir platform sunmaktadır. Kullanıcılar, Uygulama’da Üye İşyeri tarafından siparişe konu edilen Ürünler’in ayıplı olup olmaması, içeriği, teslim alınma zamanları, listelenmesi yahut satışa arzı yasaklı ürünlerden olup olmaması, niteliği, Üye İşyeri’nin Ürünler’e ilişkin yaptığı yazılı ve/veya görüntülü açıklamaların doğruluğu ve tamlığı da dahil olmak üzere Ürünler ile ilgili hiçbir konu hakkında Şirket’in bilgi sahibi olmadığı ve olması gerekmediğini ve bunları taahhüt ve garanti etmek yükümlülüğü bulunmadığını, Şirket’in herhangi bir şekilde Sözleşme kapsamında sunulan hizmetlerin tarafı olmadığını kabul eder. Kullanıcı, Uygulama üzerinden sunulan hizmetlerin tarafı olarak gerçekleştirdiği her türlü iş ve işlemin sorumluluğunun kendisine ait olduğunu kabul, beyan ve taahhüt eder. Şirket, Kullanıcı talep ve sorunlarının iletilmesi için Uygulama üzerinden gerekli gördüğü kanalları sağlayacak olup şirket tarafından sunulan bilgilendirme ve iletişim kaynak ve kanalları sorunların çözümüne yönelik bir taahhüt olarak yorumlanamayacaktır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Üye İşyeri tarafından Uygulama üzerinden satışa sunulan Ürünler’in Üye İşyeri’nin gündelik iş akışına göre belirlendiğini ve Kullanıcı’nın Uygulama’yı kullanımı boyunca düzenli Ürün temininin garanti edilmediğini kabul ve beyan eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.3 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, sipariş verdiği Ürünler’i Üye İşyeri tarafından belirtilen zaman aralığında ilgili Üye İşyeri tesisinden teslim almakla ve Ürün’ün teslimi esnasında sipariş numarasını Üye İşyeri’ne ibraz etmekle yükümlüdür. Kullanıcı, sipariş numarasını ibraz etmekten imtina etmesi veya siparişi zamanında teslim almaması halinde Üye İşyeri’nin sipariş konusu Ürün üzerinde dilediği gibi tasarrufta bulunabileceğini ve buna ilişkin olarak ücret iadesi de dahil olmak üzere Üye İşyeri’ne karşı herhangi bir talep ve iddiada bulunamayacağını kabul ve taahhüt eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.4 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, sipariş konusu Ürün bedelini Uygulama üzerinden ödeyecektir. Şirket, ödeme hizmetinin verilmesi için üçüncü kişi ödeme hizmeti sağlayıcıları ile çalışacak ve Ürün bedelini, Kullanıcı’dan Uygulama üzerinden verdiği sipariş esnasında otomatik olarak tahsil edecektir. Kullanıcı, Ürün bedelini Uygulama üzerinden ödememesi halinde, siparişin tamamlanmamış olarak kabul edileceğini ve sipariş konusu Ürün’ün farklı bir Kullanıcı’ya satılabileceğini kabul ve beyan eder. Tamamlanan bir sipariş, değiştirilemez veya iptali talep edilemez.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.5 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Ürün bedelinin ödenmesi kapsamında Kullanıcılar tarafından sağlanan banka kartı ve/veya kredi kartı bilgileri kesinlikle Şirket nezdinde saklanmamaktadır. Kullanıcılar’ın Uygulama üzerinden gerçekleştirdiği ödeme işlemlerinde kullandığı banka kartı ve/veya kredi kartı ve ödeme bilgileri, bu yönde onay vermeleri halinde, Şirket’in bu hususta hizmet aldığı üçüncü kişi firmalarca saklanacaktır. Bu kapsamda Kullanıcı, banka kartı ve/veya kredi kartı ve ödeme bilgilerinin saklanması, kullanılması ve yetkisiz kullanımı da dahil her türlü talep ve şikayetlerini doğrudan ilgili üçüncü kişi kuruluşa bildirmekle yükümlüdür. Kullanıcı, bahsi geçen talep ve şikayetlere ilişkin olarak Şirket’in herhangi bir sorumluluğu bulunmadığını kabul ve beyan eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.6 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcılar’a Uygulama üzerinden Üye İşyerleri’ni ve sunulan hizmetleri puanlama imkanı tanınabilecektir. Kullanıcu bu yönde kendisine bilgilendirme yapılmasını ve kendisi ile iletişim kurulmasını kabul eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.7 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Şirket’in tamamen kendi takdirinde olmak üzere, Kullanıcı’dan Ürün siparişi başına Ürün bedeli ile birlikte ek ücret talep etme hakkı saklıdır.  ",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.8 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Sözleşme konusu hizmetin tarafları münhasıran Kullanıcı ve Üye İşyeri olduğundan, Kullanıcılar Üye İşyeri’ne ilişkin tüm taleplerini ve ilgili mevzuattan doğan haklarını doğrudan sunulan hizmetin karşı tarafı olan Üye İşyeri’ne iletecektir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "4.9 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Üye İşyerleri ile Uygulama dışındaki bir kanaldan, Şirket’i aradan çıkararak Sözleşme konusu hizmetlerin sağlanmasına ilişkin herhangi bir anlaşma yapmayacağını, ödeme işlemini Şirket’i aradan çıkararak Uygulama dışında tamamlamayacağını ya da Üye İşyerleri’ni bu yönde teşvik edici hareketlerde bulunmayacağını kabul, beyan ve taahhüt eder. Şirket’in belirli bir Kullanıcı için birden fazla kez tekrarlanan işlem iptalleri veya sair nedenlerle Şirket’i aradan çıkararak işlem gerçekleştirdiğine ilişkin şüphesi oluşması ya da herhangi bir şekilde bu durumun tespit edilmesi halinde, Şirket kendi takdirine bağlı olarak ilgili Kullanıcı’nın üyeliğini askıya alabilecek ya da sonlandırabilecektir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "5. Sorumluluğun Kısıtlandırılması",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "5.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Platform kapsamındaki Uygulama, yazılım ve sair içerikler “OLDUĞU GİBİ” sunulmakta olup, bu kapsamda Şirket’in Uygulama, yazılım ve içeriğin doğruluğu, tamlığı ve güvenilirliği ile ilgili herhangi bir sorumluluk ya da taahhüdü bulunmamaktadır. Kullanıcı, Şirket’in ayrıca İçerik ve diğer Kullanıcı verilerinin birbiriyle ilişkisine dair taahhütte bulunmadığını anlar ve kabul eder. Şirket, Platform’un kullanımının kesintisiz ve hatasız olduğunu taahhüt etmemektedir. Şirket, Platform’un 7/24 erişilebilir ve kullanılabilir olmasını hedeflemekle birlikte Platform’a erişimi sağlayan sistemlerin işlerliği ve erişilebilirliğine ilişkin bir garanti vermemektedir. Kullanıcı, Platform’a erişimin muhtelif zamanlarda engellenebileceğini ya da erişimin kesilebileceği kabul eder. Şirket, söz konusu engelleme veya kesintilerden hiçbir şekilde sorumlu değildir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "5.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Platform üzerinden Şirket’in kontrolünde olmayan başka internet sitelerine ve/veya portallara, dosyalara veya içeriklere link verilebileceğini ve bu tür linklerin yöneldiği internet sitesini veya işleten kişisini desteklemek amacıyla veya internet sitesi veya içerdiği bilgilere yönelik herhangi bir türde bir beyan veya garanti niteliği taşımadığını, söz konusu linkler vasıtasıyla erişilen portallar, internet siteleri, dosyalar ve içerikler, hizmetler veya ürünler veya bunların içeriği hakkında Şirket’in herhangi bir sorumluluğu olmadığını kabul ve beyan eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "5.3 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, Platform üzerinden sunulan Uygulama ve Uygulama’lara erişim ve bunların kalitesinin büyük ölçüde ilgili İnternet Servis Sağlayıcısı’ndan temin edilen hizmetin kalitesine dayandığını ve söz konusu hizmet kalitesinden kaynaklı sorunlarda Şirket’in herhangi bir sorumluluğunun bulunmadığını kabul eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "5.4 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı, yüklediği içerikler ile Platform’un kullanımından münhasıran sorumludur. Kullanıcı, fikri mülkiyet ihlalleri, İçerik, Platform’un kullanımına ilişkin olarak üçüncü kişiler tarafından iletilebilecek her türlü iddia ve talepten (yargılama masrafları ve avukatlık ücretleri de dahil olmak üzere) Şirket’i beri kıldığını kabul eder.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "6. Mücbir Sebepler",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "6.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Mücbir sebep terimi, doğal afet, isyan, savaş, grev, Döngü’nün gerekli bilgi güvenliği önlemleri almasına karşın Uygulama, Portal ve sisteme yapılan saldırılar da dahil ve fakat bunlarla sınırlı olmamak kaydıyla Döngü’nün makul kontrolü haricinde gelişen ve Döngü’nün gerekli özeni göstermesine rağmen önleyemediği kaçınılamayacak olaylar olarak yorumlanacaktır.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "6.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Mücbir sebep sayılan tüm durumlarda, Taraflar işbu Sözleşme ile belirlenen edinimlerinden herhangi birini geç veya eksik ifa etme veya ifa etmeme nedeniyle yükümlü değildir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "7. Sözleşme’nin Askıya Alınması ve Feshi",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "7.1 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Kullanıcı’nın işbu Sözleşme’de yer alan hükümlere ve Site’de beyan edilen kural ve şartlara uymaması, Kullanıcı’nın Site’deki yahut Hizmetler’in verilmesi sırasındaki faaliyetlerinin hukuki, teknik veya bilgi güvenliği anlamında risk oluşturması ya da üçüncü kişilerin şahsi ve ticari haklarına halel getirici mahiyette olması halinde Şirket, Kullanıcı’nın Site’yi kullanımını geçici veya sürekli olarak durdurabilir yahut Sözleşme’yi feshedebilir. Kullanıcı’nın bu nedenle Şirket’ten herhangi bir talebi söz konusu olamaz. ",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            AutoSizeText.rich(
              TextSpan(
                style: AppTextStyles.bodyTextStyle,
                children: [
                  TextSpan(
                    text: "7.2 ",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "Şirket dilediği zamanda Site’yi ve/veya işbu Sözleşme’yi süreli veya süresiz olarak askıya alabilecek, sona erdirebilecektir.",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text: "8. Uyuşmazlıkların Çözümü",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text:
                    "Uyuşmazlıkların Çözümü Bu Sözleşme ile ilgili olarak çıkabilecek bütün uyuşmazlıklarda öncelikle işbu metinde yer alan hükümler, hüküm bulunmayan konularda ise Türkiye Cumhuriyeti Kanunları uygulanacaktır. Sözleşme’nin uygulanmasından kaynaklanan ihtilafların çözümünde İstanbul Merkez (Çağlayan) Mahkemeleri ve İcra Daireleri yetkili olacaktır.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),

            /* SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            LocaleText(
              text: "Kişisel Verileri Koruma Kanunu",
              style: AppTextStyles.headlineStyle.copyWith(fontSize: 20),
              alignment: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: context.dynamicWidht(0.05),
              ),
              child: LocaleText(
                text:
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                style: AppTextStyles.bodyTextStyle,
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
