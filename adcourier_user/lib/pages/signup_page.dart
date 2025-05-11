import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/signup_form_widget.dart';
import '../constant.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1100
          ? null
          : AppBar(actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.white
                            : Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign in',
                            style: TextStyle(
                              color: appColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/login');
                              })
                      ]),
                ),
              ),
            ]),
      body: MediaQuery.of(context).size.width >= 1100
          ? Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              'https://img.freepik.com/premium-photo/young-courier-delivery-man-uniform-moped-isolated-yellow-background-created-with-generative-ai-technology_132358-13456.jpg?w=1060',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              scale: 1,
                            )),
                      ),
                      const Expanded(
                          flex: 7, child: SizedBox(child: SignupFormWidget()))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      context.go('/parcel-delivery');
                    },
                    child: Image.asset(
                      logo,
                      scale: 17,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                            color: AdaptiveTheme.of(context).mode.isDark == true
                                ? Colors.white
                                : Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: TextStyle(
                                  color: appColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/login');
                                  })
                          ]),
                    ),
                  ),
                )
              ],
            )
          : const SignupFormWidget(),
    );
  }
}
