// ignore_for_file: avoid_build_context_in_providers
import 'dart:convert';
import 'package:admin/constance.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:admin/models/email_settings_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'email_settings_provider.g.dart';

@riverpod
class EmailSettingsNotifier extends _$EmailSettingsNotifier {
  @override
  EmailSettingsModel build() {
    // Initialize the state and set up listeners
    _initializeListeners();
    return EmailSettingsModel();
  }

  void _initializeListeners() {
    var logger = Logger();
    logger.d('email settings is being initialized');
    FirebaseFirestore.instance
        .collection('Email System')
        .doc('Email System')
        .snapshots()
        .listen((value) {
      state = state.copyWith(selectedPlatform: value['selectedPlatform']);
    });

    FirebaseFirestore.instance
        .collection('Email Status')
        .doc('Email Status')
        .snapshots()
        .listen((value) {
      state = state.copyWith(disableEmail: value['disable email']);
    });

    FirebaseFirestore.instance
        .collection('Email System Details')
        .doc('Mailgun')
        .snapshots()
        .listen((value) {
      state = state.copyWith(
        mailGunApi: value['apiKey'],
        mailGunDomain: value['domain'],
      );
    });

    FirebaseFirestore.instance
        .collection('Email System Details')
        .doc('Sendgrid')
        .snapshots()
        .listen((value) {
      state = state.copyWith(
        // nexmoApiKey: value['api key'],
        // nexmoNumber: value['nexmo number'],
        sendGridApi: value['apiKey'],
      );
    });
  }

  void updateSelectedPlatform(String selectedPlatform) {
    FirebaseFirestore.instance
        .collection('Email System')
        .doc('Email System')
        .set({'selectedPlatform': selectedPlatform});
  }

  void enableEmail(bool sms) {
    FirebaseFirestore.instance
        .collection('Email Status')
        .doc('Email Status')
        .set({'disable email': sms});
  }

  void addMailGunDetails(
    String mailGunApi,
    String mailGunDomain,
  ) {
    FirebaseFirestore.instance
        .collection('Email System Details')
        .doc('Mailgun')
        .set({
      'apiKey': mailGunApi.isEmpty ? state.mailGunApi : mailGunApi,
      'domain': mailGunDomain.isEmpty ? state.mailGunDomain : mailGunDomain,
      // 'account sid': accountSID.isEmpty ? state.accountSID : accountSID
    });
  }

  void addSendGridDetails(String sendgridApiKey) {
    FirebaseFirestore.instance
        .collection('Email System Details')
        .doc('Sendgrid')
        .set({
      'apiKey': sendgridApiKey.isEmpty ? state.sendGridApi : sendgridApiKey,
    });
  }

  Future<void> sendBulkEmailWithSendGridEmail(
      String compayEmail,
      String apiKey,
      List<String> toEmails, // List of recipients
      String subject,
      String content,
      BuildContext context) async {
    var logger = Logger();
    final url = Uri.parse('$hostURL/sendgrid-bulk-email');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'apiKey': apiKey,
      'to': toEmails,
      'subject': subject,
      'text': content,
      'html': '<p>$content</p>',
      'from': compayEmail
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Email sent successfully');
        FirebaseFirestore.instance.collection('Bulk Email').add({
          'title': subject,
          'message': content,
          'emailType': 'Bulk Email',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Email sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send email');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Failed to send email",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
      if (context.mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }

  Future<void> sendBulkEmailWithMailGunEmail(
      String compayEmail,
      String apiKey,
      String domain,
      List<String> toEmails, // List of recipients
      String subject,
      String content,
      BuildContext context) async {
    var logger = Logger();
    final response = await http.post(
      Uri.parse('$hostURL/mailgun-bulk-email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'to': toEmails,
        'subject': subject,
        'text': content,
        'from': compayEmail,
        'domain': domain,
        'apiKey': apiKey,
        'html': '<p>$content</p>'
      }),
    );

    if (response.statusCode == 200) {
      logger.d('Email sent successfully!');
      FirebaseFirestore.instance.collection('Bulk Email').add({
        'title': subject,
        'message': content,
        'emailType': 'Bulk Email',
        'timeCreated':
            DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      }).then((value) {
        if (context.mounted) {
          context.pop();
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: "Email sent successfully",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
      });
    } else {
      logger.d('Failed to send email: ${response.body}');
      if (context.mounted) {
        if (context.mounted) {
          if (context.mounted) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: "Notification",
              message: response.body,
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        }
        // });
      }
    }
  }
}

@riverpod
Future<List<String>> fetchEmailsFromFirestore(
    Ref ref, String userCollection) async {
  List<String> emailList = [];
  var logger = Logger();
  try {
    // Reference to the "users" collection
    final QuerySnapshot snapshot = userCollection == 'Users'
        ? await FirebaseFirestore.instance.collection('users').get()
        : userCollection == 'Vendors'
            ? await FirebaseFirestore.instance.collection('vendors').get()
            : await FirebaseFirestore.instance.collection('riders').get();

    // Extract email field from each document
    for (var doc in snapshot.docs) {
      String? email = doc.get('email'); // Fetching email field
      if (email != null) {
        emailList.add(email);
      }
    }
  } catch (e) {
    logger.d('Error fetching emails from Firestore: $e');
  }

  return emailList;
}
