import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:what_to_cook_demo_flutter_1/extensions/image_extensions.dart';
import 'package:what_to_cook_demo_flutter_1/providers/sign_up_provider.dart';
import 'package:what_to_cook_demo_flutter_1/services/user_entry_service.dart';

final hasErrorProvider = StateProvider<bool>((ref) => false);

class ConfirmationScreen extends ConsumerStatefulWidget {
  ConfirmationScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConfirmationScreenState createState() => ConfirmationScreenState();
}

class ConfirmationScreenState extends ConsumerState<ConfirmationScreen> {
  final formKey = GlobalKey<FormState>();
  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>.broadcast();
  bool hasError = false;
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // snackBar Widget
    snackBar(String? message) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    final String email = widget.email;
    final bool hasErrorState = ref.watch(hasErrorProvider);
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.transparent),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset('200w'.toGif),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Email Verification',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: "Enter the code sent to ",
                          children: [
                            TextSpan(
                                text: email,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        controller: codeController,
                        errorAnimationController: errorController,
                        autoFocus: true,
                        pinTheme: PinTheme(
                          inactiveFillColor:
                              Theme.of(context).colorScheme.primary,
                          activeFillColor: Colors.transparent,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          selectedFillColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shape: PinCodeFieldShape.circle,
                        ),
                        pastedTextStyle: const TextStyle(
                          color: Colors.transparent,
                          fontWeight: FontWeight.bold,
                        ),
                        boxShadows: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            color: Theme.of(context).errorColor,
                            blurRadius: 10,
                          )
                        ],
                        enableActiveFill: true,
                        appContext: context,
                        blinkWhenObscuring: true,
                        keyboardType: TextInputType.number,
                        length: 6,
                        obscuringWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(23),
                          child: Image.asset('fandid'.toJPG),
                        ),
                        onChanged: (String value) {},
                        beforeTextPaste: (code) {
                          return true;
                        },
                        onCompleted: (v) {
                          //TODO: On complete click button
                          debugPrint("Completed");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasErrorState
                          ? "*Please fill up all the cells properly"
                          : "",
                      style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        onPressed: () async {
                          var sentEmail =
                              await UserEntryService().verifyEmail(email);
                          if (sentEmail != '') {
                            if (mounted) {}
                            buildShowDialog(context, 'OPPS!', sentEmail);
                          } else {
                            snackBar("Another mail has been sent");
                          }
                        },
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: const Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: const Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (codeController.text.length != 6) {
                              //TODO: Get the code from server
                              errorController.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              ref
                                  .read(hasErrorProvider.notifier)
                                  .update((state) => true);
                            } else {
                              ref
                                  .read(hasErrorProvider.notifier)
                                  .update((state) => false);
                              var username = ref.watch(usernameProvider);
                              var password = ref.watch(passwordProvider);

                              var verify = await UserEntryService().emailSignUp(
                                  email,
                                  username,
                                  password,
                                  codeController.text);
                              if (verify != "Welcome to the paradise!") {
                                buildShowDialog(context, "oppps", verify);
                              } else {
                                /*   Navigator.of(context).pushAndRemoveUntil(
                                  CustomPageRoute(child: MainScreen()),
                                      (route) => false);*/
                              }
                            }

                            //TODO: verify it with respect to sent code and sent to home page!

                            /*  Navigator.pushNamedAndRemoveUntil(
                              context,
                              MainScreen.route,
                                  (route) => false, // to delete the stack
                            );*/
                          }
                        },
                        child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(
      BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        title: Text(
          //TODO: write something more professional
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
