import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';
import '../widgets/text_form_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final double tapPadding =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom == 0;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Container(
        height: MediaQuery.of(context).size.height - tapPadding,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  height: isKeyboardVisible
                      ? MediaQuery.of(context).size.height * 0.30
                      : 0,
                  curve: Curves.linear,
                  child: const LogoWidget(),
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormFieldWidget(
                      usernameController: emailController,
                      label: "Email",
                    ),
                    TextFormFieldWidget(
                      usernameController: usernameController,
                      label: "Username",
                    ),
                    TextFormFieldWidget(
                      usernameController: passwordController,
                      label: "Password",
                    ),
                    TextFormFieldWidget(
                      usernameController: confirmPasswordController,
                      label: "Confirm Password",
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: theme.elevatedButtonTheme.style,
                    child: Text(
                      "Login",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
