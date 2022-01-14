import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_order_create_with_3d_cubit/iyzico_order_create_with_3d_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebViewForThreeD extends StatefulWidget {
  const WebViewForThreeD({
    Key? key,
  }) : super(key: key);

  @override
  State<WebViewForThreeD> createState() => _WebViewForThreeDState();
}

class _WebViewForThreeDState extends State<WebViewForThreeD> {
  WebViewController? controller;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<IyzicoOrderCreateWith3DCubit>().state;
      if (state is GenericInitial) {
        log("initial");
        return Container();
      } else if (state is GenericLoading) {
        log("loading");
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        final String statusMessage = state.response.first.status;
        log("completed");
        if (statusMessage != "failure") {
          final String htmlData = utf8
              .decode(base64.decode(state.response.first.threeDsHtmlContent));
          log(htmlData);
          String conversationId = state.response.first.conversationId;
          print("ahmettttt");
          print(conversationId);
          SharedPrefs.setConversationId(conversationId);

          void loadLocalHtml() async {
            final url = Uri.dataFromString(
              htmlData,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString();
            controller!.loadUrl(url);
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                icon: SvgPicture.asset(ImageConstant.BACK_ICON),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: AppColors.appBarColor,
              title: SvgPicture.asset(
                ImageConstant.COMMONS_APP_BAR_LOGO,
              ),
            ),
            body: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                this.controller = controller;
                loadLocalHtml();
              },
              navigationDelegate: (request) {
                if (request.url
                    .contains('${UrlConstant.EN_URL}iyzico/callback')) {
                  Navigator.of(context)
                      .pushNamed(RouteConstant.ORDER_RECEIVING_VIEW_WITH3D);
                  return NavigationDecision.navigate;
                } else {
                  return NavigationDecision.navigate; // Default decision
                }
              },
            ),
          );
        } else {
          return Center(
            child: CustomAlertDialogResetPassword(
              description:
                  "${state.response.first.errorMessage}\n Hata Kodu: ${state.response.first.errorCode}",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
      } else {
        final error = state as GenericError;
        final String errorMessage = error.message;

        print(errorMessage);
        return CustomAlertDialogResetPassword(
          description: buildErrorMessage(errorMessage),
          /* "${errorMessage == emptyBasketMessage ? "Sepetinde ürün bulunmamaktadır" : error.message}\n Hata Kodu: ${error.statusCode}", */
          onPressed: () {
            Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
          },
        );
      }
    });
  }

  buildErrorMessage(String errorMessage) {
    const String emptyBasketMessage = "\"Sepetinde Ã¼rÃ¼n bulunmamaktadÄ±r\"";
    const String soldBasketMessage =
        "\"Sepetindeki bazÄ± Ã¼rÃ¼nler satÄ±ldÄ±, iÅleme devam etmek iÃ§in sepetini boÅaltmalÄ±sÄ±n.Ä°lgili Ã¼rÃ¼nler: Surprise Box\"";
    switch (errorMessage) {
      case emptyBasketMessage:
        return "Sepetinde ürün bulunmamaktadır";
      case soldBasketMessage:
        return "Sepetindeki bazı ürünler satıldı, işleme devam etmek için sepetini boşaltmalısın.";
      default:
        return errorMessage;
    }
  }
}
