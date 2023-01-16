import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_to_cook_demo_flutter_1/providers/sign_up_provider.dart';
import 'package:what_to_cook_demo_flutter_1/widgets/text_form_field_pass_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_form_field_widget.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final double tapPadding =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom == 0;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: screenHeight - tapPadding,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: (screenHeight * 0.04)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(
                    toolbarHeight: screenHeight * 0.08,
                    elevation: 0,
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: theme.iconTheme.color,
                            size: screenHeight * 0.03,
                          ),
                          Text(
                            "Go Back",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    height: isKeyboardVisible ? screenHeight * 0.30 : 0,
                    curve: Curves.linear,
                    child: const LogoWidget(),
                  ),
                  Form(
                      key: _signUpFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormFieldWidget(
                              usernameController: emailController,
                              label: "Email",
                              icon: Icons.email,
                              validator: (email) {
                                if (!EmailValidator.validate(email!)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            TextFormFieldWidget(
                              usernameController: usernameController,
                              label: "Username",
                              icon: Icons.person,
                              validator: (username) {
                                if (username!.isEmpty || username.length < 6) {
                                  return "Username must be more than 6 characters";
                                }
                                return null;
                              },
                            ),
                            TextFormFieldPassWidget(
                              usernameController: passwordController,
                              label: "Password",
                              prefixIcon: Icons.lock,
                              validator: (pass) {
                                ref
                                    .read(passwordProvider.notifier)
                                    .update((state) => pass);
                                if (pass!.isEmpty || pass.length < 6) {
                                  return "Password must be more than 6 characters";
                                }
                                return null;
                              },
                            ),
                            TextFormFieldPassWidget(
                              usernameController: confirmPasswordController,
                              label: "Confirm Password",
                              prefixIcon: Icons.lock,
                              validator: (confirmPass) {
                                if (ref.watch(passwordProvider)! !=
                                    confirmPass) {
                                  return "Passwords must match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          ref
                              .read(emailProvider.notifier)
                              .update((state) => emailController.text);
                          ref
                              .read(usernameProvider.notifier)
                              .update((state) => usernameController.text);

                          print(
                              "${ref.watch(emailProvider)} + ${ref.watch(usernameProvider)}+ ${ref.watch(passwordProvider)}");
                          print("true");
                        } else {
                          print("false");
                        }
                      },
                      style: theme.elevatedButtonTheme.style,
                      child: Text(
                        "Sign Up",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
