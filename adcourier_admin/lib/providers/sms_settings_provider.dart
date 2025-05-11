import 'dart:convert';
import 'package:admin/constance.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:admin/models/sms_settings_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sms_settings_provider.g.dart';

@riverpod
class SmsSettingsNotifier extends _$SmsSettingsNotifier {
  @override
  SmsSettingsState build() {
    // Initialize the state and set up listeners
    _initializeListeners();
    return SmsSettingsState();
  }

  void _initializeListeners() {
    var logger = Logger();
    logger.d('sms settings is being initialized');
    FirebaseFirestore.instance
        .collection('Sms System')
        .doc('Sms System')
        .snapshots()
        .listen((value) {
      state = state.copyWith(selectedPlatform: value['selectedPlatform']);
    });

    FirebaseFirestore.instance
        .collection('Whatsapp System')
        .doc('Whatsapp System')
        .snapshots()
        .listen((value) {
      state = state.copyWith(enableWhatsapp: value['enable whatsapp']);
    });

    FirebaseFirestore.instance
        .collection('Sms Status')
        .doc('Sms Status')
        .snapshots()
        .listen((value) {
      state = state.copyWith(enableSms: value['enable sms']);
    });

    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Twilio')
        .snapshots()
        .listen((value) {
      state = state.copyWith(
        twilioNumber: value['twilio number'],
        authToken: value['auth token'],
        accountSID: value['account sid'],
      );
    });

    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Nexmo')
        .snapshots()
        .listen((value) {
      state = state.copyWith(
        nexmoApiKey: value['api key'],
        nexmoNumber: value['nexmo number'],
        nexmoSecretKey: value['nexmo secretKey'],
      );
    });

    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Telesign')
        .snapshots()
        .listen((value) {
      state = state.copyWith(
        telesignApiKey: value['api key'],
        telesignCustomerID: value['customer id'],
      );
    });
  }

  void updateSelectedPlatform(String selectedPlatform) {
    FirebaseFirestore.instance
        .collection('Sms System')
        .doc('Sms System')
        .set({'selectedPlatform': selectedPlatform});
  }

  void enableWhatsapp(bool whatsapp) {
    FirebaseFirestore.instance
        .collection('Whatsapp System')
        .doc('Whatsapp System')
        .set({'enable whatsapp': whatsapp});
  }

  void enableSms(bool sms) {
    FirebaseFirestore.instance
        .collection('Sms Status')
        .doc('Sms Status')
        .set({'enable sms': sms});
  }

  void addTwilioDetails(
      String twilioNumber, String authToken, String accountSID) {
    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Twilio')
        .set({
      'twilio number': twilioNumber.isEmpty ? state.twilioNumber : twilioNumber,
      'auth token': authToken.isEmpty ? state.authToken : authToken,
      'account sid': accountSID.isEmpty ? state.accountSID : accountSID
    });
  }

  void addNexmoApiKeyDetails(
      String nexmoApiKey, String nexmoNumber, String nexmoSecretKey) {
    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Nexmo')
        .set({
      'api key': nexmoApiKey.isEmpty ? state.nexmoApiKey : nexmoApiKey,
      'nexmo number': nexmoNumber.isEmpty ? state.nexmoNumber : nexmoNumber,
      'nexmo secretKey':
          nexmoSecretKey.isEmpty ? state.nexmoSecretKey : nexmoSecretKey
    });
  }

  void addTelesignDetails(String telesignApiKey, String telesignCustomerID) {
    FirebaseFirestore.instance
        .collection('Sms System Details')
        .doc('Telesign')
        .set({
      'api key': telesignApiKey.isEmpty ? state.telesignApiKey : telesignApiKey,
      'customer id': telesignCustomerID.isEmpty
          ? state.telesignCustomerID
          : telesignCustomerID
    });
  }


}
  Future<void> sendBulkTwilioWhatsApp(
      String message,
      List<String> recipients,
      String from,
      String title,
      String accountSID,
      String authToken,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-twilio-whatsapp');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'recipients': recipients,
      "accountSid": accountSID,
      'authToken': authToken,
      'from': 'whatsapp:$from'
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('WHATSAPP').add({
          'title': title,
          'message': message,
          'emailType': 'Whatsapp',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }

  Future<void> sendBulkTwilioSMS(
      String message,
      List<String> recipients,
      String from,
      String title,
      String accountSID,
      String authToken,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-twilio-sms');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'recipients': recipients,
      "accountSid": accountSID,
      'authToken': authToken,
      'twilio': from
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('SMS').add({
          'title': title,
          'message': message,
          'emailType': 'SMS',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }

  Future<void> sendBulkNexmoWhatsApp(
      String message,
      List<String> recipients,
      String from,
      String title,
      String apiSecret,
      String apiKey,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-nexmo-whatsapp');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'recipients': recipients,
      "apiSecret": apiSecret,
      'apiKey': apiKey,
      'vonageNumber': from
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('WHATSAPP').add({
          'title': title,
          'message': message,
          'emailType': 'Whatsapp',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }

  Future<void> sendBulkNexmoSms(
      String message,
      List<String> recipients,
      String from,
      String title,
      String apiSecret,
      String apiKey,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-nexmo-sms');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'numbers': recipients,
      "apiSecret": apiSecret,
      'apiKey': apiKey,
      'from': from
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('SMS').add({
          'title': title,
          'message': message,
          'emailType': 'Sms',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }

  Future<void> sendBulkTelesignWhatsApp(
      String message,
      List<String> recipients,
      String from,
      String title,
      String custumerId,
      String apiKey,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-telesign-whatsapp');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'recipients': recipients,
      "custumerId": custumerId,
      'apiKey': apiKey,
      'fromNumber': from
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('WHATSAPP').add({
          'title': title,
          'message': message,
          'emailType': 'Whatsapp',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }

  Future<void> sendBulkTelesignSms(
      String message,
      List<String> recipients,
      String from,
      String title,
      String custumerId,
      String apiKey,
      BuildContext context) async {
    final url = Uri.parse('$hostURL/send-bulk-telesign-sms');
    final headers = {"Content-Type": "application/json"};
    var logger = Logger();
    final body = json.encode({
      'message': message,
      'numbers': recipients,
      "custumerId": custumerId,
      'apiKey': apiKey,
      'fromNumber': from
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        logger.d('Messages sent successfully');
        FirebaseFirestore.instance.collection('SMS').add({
          'title': title,
          'message': message,
          'emailType': 'Sms',
          'timeCreated':
              DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        }).then((value) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: "Notification",
                message: "Message sent successfully",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          }
        });
      } else {
        logger.d('Failed to send messages: ${response.body}');
        if (context.mounted) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: response.body,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      }
    } catch (e) {
      logger.d('Error: $e');
    }
  }
@riverpod
Future<List<String>> fetchPhonesFromFirestore(
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
      String? email = doc.get('phone'); // Fetching email field
      if (email != null) {
        emailList.add(email);
      }
    }
  } catch (e) {
    logger.d('Error fetching emails from Firestore: $e');
  }

  return emailList;
}
