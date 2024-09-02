import 'package:flutter/material.dart';
import 'package:lit_express/common/style/spacing_style.dart';
import 'package:lit_express/features/authentication/screens/login/widgets/login_form.dart';
import 'package:lit_express/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// App Logo , Title & Sub-Title
              TLoginHeader(),

              /// Form
              TLoginForm(),

            ],
          ),
        ),
      ),
    );
  }
}



