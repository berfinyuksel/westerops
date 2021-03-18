import 'package:dongu_mobile/presentation/screens/register_view/components/password_rules.dart';
import 'package:dongu_mobile/utils/clippers/password_rules_clipper.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class ClippedPasswordRules extends StatelessWidget {
  const ClippedPasswordRules({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2E4EE).withOpacity(0.75),
            offset: Offset(0, 3.0),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: ClipPath(
        clipper: PasswordRulesClipper(),
        child: Container(
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.03),
            bottom: context.dynamicWidht(0.03),
          ),
          height: context.dynamicHeight(0.1),
          width: context.dynamicWidht(0.27),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE2E4EE).withOpacity(0.75),
                offset: Offset(0, 3.0),
                blurRadius: 12.0,
              ),
            ],
          ),
          child: PasswordRules(passwordController: passwordController),
        ),
      ),
    );
  }
}
