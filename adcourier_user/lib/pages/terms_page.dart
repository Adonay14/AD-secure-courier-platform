import 'dart:convert';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:user_web/widgets/footer_widget.dart';
import 'package:user_web/providers/legal_page_provider.dart';

class TermsPage extends ConsumerStatefulWidget {
  const TermsPage({super.key});

  @override
  ConsumerState<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends ConsumerState<TermsPage> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final about = ref.watch(getTermsAndConditionsDetailsProvider).value;
    if (about != null) {
      _controller.document = Document.fromJson(jsonDecode(about));
      _controller.readOnly = true;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark == true
                      ? Colors.black
                      : const Color.fromARGB(255, 230, 224, 237),
                  image: const DecorationImage(
                      opacity: 0.3,
                      image:
                          AssetImage('assets/image/terms-and-conditions.png'))),
              child: Center(
                child: const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ).tr(),
              ),
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 100, right: 100)
                  : const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Terms & Conditons',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor.basic(
                      controller: _controller,
                      configurations: const QuillEditorConfigurations(),
                    ),
                  ),
                  const Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Use Of The Site',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Registration',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Password & Security',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Calculation Of Discount',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Limitation Of Liability',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  // Gap(10),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Rate & Review',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  // ),
                  const Gap(20),
                ],
              ),
            ),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}
