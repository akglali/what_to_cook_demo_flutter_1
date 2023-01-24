import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:what_to_cook_demo_flutter_1/screens/sign_up_screen_email.dart';
import 'package:what_to_cook_demo_flutter_1/services/user_entry_service.dart';
import 'dart:io' show Platform;
import 'package:what_to_cook_demo_flutter_1/utils/google_sign_in_api.dart';
import 'package:what_to_cook_demo_flutter_1/widgets/custom_page_route.dart';
import 'package:what_to_cook_demo_flutter_1/widgets/logo_widget.dart';
import '../widgets/elevated_button_widget.dart';

class SignUpOption extends ConsumerStatefulWidget {
  const SignUpOption({
    super.key,
  });

  @override
  SignUpOptionState createState() => SignUpOptionState();
}

class SignUpOptionState extends ConsumerState<SignUpOption> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final double tapPadding =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

  //for apple signIn
  late ValueSetter<AuthorizationCredentialAppleID> onSignInApple;

  //for google signIn
  late ValueSetter<String> onSignInGoogle;

  @override
  Widget build(BuildContext context) {
    //get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    //get the screen height
    final screenHeight = MediaQuery.of(context).size.height;
    //check the platform
    final bool isPlatformIos = Platform.isIOS;
    //to set the theme of the widgets.
    final theme = Theme.of(context);

    //Check The theme mode to change the logo
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var imagePath = "assets/images/sign_up_logo_dark.png";
    if (!isDarkMode) {
      imagePath = "assets/images/sign_up_logo_light.jpeg";
    }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.03),
                          child: LogoWidget(
                            height: screenHeight * 0.19,
                            width: screenWidth * 0.20,
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.03, right: screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's make delicious",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          "Foods!",
                          style: theme.textTheme.titleLarge,
                        ),
                        ElevatedButtonWidget(
                          onPressed: () async {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                  child: SignUpScreenEmail(),
                                  direction: AxisDirection.left),
                            );
                          },
                          screenWidth: screenWidth,
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent.shade100),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          icon: const Icon(Icons.mail),
                          text: ' Sign up with Email',
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.02, bottom: 20),
                          child: Row(children: const <Widget>[
                            Expanded(
                              child: Divider(
                                thickness: 1.7,
                              ),
                            ),
                            Text(" OR "),
                            Expanded(
                              child: Divider(
                                thickness: 1.7,
                              ),
                            ),
                          ]),
                        ),
                        //sign up with Apple
                        ElevatedButtonWidget(
                          screenWidth: screenWidth,
                          onPressed: () async {
                            final credential =
                                await SignInWithApple.getAppleIDCredential(
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                              webAuthenticationOptions:
                                  WebAuthenticationOptions(
                                redirectUri: Uri.parse(
                                    'https://api.dreamwod.app/auth/callbacks/apple-sign-in'),
                                clientId: 'com.dreamwod.app.login',
                              ),
                            );
                            //Todo: Will write function to communicate with back-end
                            onSignInApple(credential);
                            print(credential);
                          },
                          text: ' Sign up with Apple',
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          icon: const Icon(Icons.apple),
                        ),
                        //Sign up Google
                        ElevatedButtonWidget(
                          screenWidth: screenWidth,
                          onPressed: () async {
                            try {
                              final account = await GoogleSignInApi.login();
                              if (account != null) {
                                final GoogleSignInAuthentication auth =
                                    await account.authentication;
                                /*print(account.displayName);
                                  print(account.email);
                                  print(account.photoUrl);
                                  print(auth.accessToken);
                                  print(account.id);

                                  print("idToken ${auth.idToken}");
                                  print(account.id);*/
                                if (auth.idToken != null) {
                                  /*   final GoogleAuthProvider provider = GoogleAuthProvider();
                final AuthCredential credential = provider(idToken: idToken, accessToken: accessToken);*/
                                  await UserEntryService().googleSignIn(auth.idToken);
                                }
                              }
                            } catch (error) {
                              print(error);
                            }
                          },
                          text: ' Sign up with Google',
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                          icon: const Icon(
                            MaterialCommunityIcons.google,
                          ),
                        ),

                      ],
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
