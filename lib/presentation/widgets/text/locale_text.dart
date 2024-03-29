import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/string_extension.dart';

class LocaleText extends StatelessWidget {
  final String? text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? alignment;
  final TextOverflow? textOverFlow;
  const LocaleText(
      {Key? key,
      this.text,
      this.style,
      this.maxLines,
      this.alignment,
      this.textOverFlow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text!.locale,
      style: style,
      maxLines: maxLines,
      textAlign: alignment,
      minFontSize: 10,
      overflow: textOverFlow,
      maxFontSize: 40,
      textScaleFactor: MediaQuery.textScaleFactorOf(context),
    );
  }
}
