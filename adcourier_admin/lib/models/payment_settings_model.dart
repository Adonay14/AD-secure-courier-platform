class PaymentSettingsModel {
  bool enableStripe;
  bool enablePaystack;
  bool enableFlutterwave;
  bool enableRazorpay;
    bool enableYookassa;
  bool enableCashondelivery;
  // String publishableKey;
  // String secretKey;
  // String flutterwavePublicKey;
  // String paystackPublicKey;
  // String backendUrl;
  // String encryptionKey;
  String getPublishableKey;
  String getSecretKey;
  String getFlutterwavePublicKey;
  String getPaystackPublicKey;
  String getBackendUrl;
  String getFlutterwaveSecretKey;
  String getFlutterwaveEncriptedKey;
  String getRazorPayKey;
  // String razorPayKey;

  PaymentSettingsModel({
    this.enableYookassa = false,
    this.enableStripe = false,
    this.enablePaystack = false,
    this.enableFlutterwave = false,
    this.enableRazorpay = false,
    this.enableCashondelivery = false,
    // this.publishableKey = '',
    // this.secretKey = '',
    // this.flutterwavePublicKey = '',
    // this.paystackPublicKey = '',
    // this.backendUrl = '',
    // this.encryptionKey = '',
    this.getPublishableKey = '',
    this.getSecretKey = '',
    this.getFlutterwaveEncriptedKey='',
    this.getFlutterwavePublicKey = '',
    this.getPaystackPublicKey = '',
    this.getBackendUrl = '',
    this.getFlutterwaveSecretKey = '',
    this.getRazorPayKey = '',
    // this.razorPayKey = '',
  });

  // copyWith method
  PaymentSettingsModel copyWith({
    bool? enableYookassa,
    bool? enableStripe,
    bool? enablePaystack,
    bool? enableFlutterwave,
    bool? enableRazorpay,
    bool? enableCashondelivery,
    String? getFlutterwaveEncriptedKey,
    // String? publishableKey,
    // String? secretKey,
    // String? flutterwavePublicKey,
    // String? paystackPublicKey,
    // String? backendUrl,
    // String? encryptionKey,
    String? getPublishableKey,
    String? getSecretKey,
    String? getFlutterwavePublicKey,
    String? getPaystackPublicKey,
    String? getBackendUrl,
    String? getFlutterwaveSecretKey,
    String? getRazorPayKey,
    // String? razorPayKey,
  }) {
    return PaymentSettingsModel(
      getFlutterwaveEncriptedKey:getFlutterwaveEncriptedKey??this.getFlutterwaveEncriptedKey,
      enableStripe: enableStripe ?? this.enableStripe,
      enableYookassa : enableYookassa ?? this.enableYookassa,
      enablePaystack: enablePaystack ?? this.enablePaystack,
      enableFlutterwave: enableFlutterwave ?? this.enableFlutterwave,
      enableRazorpay: enableRazorpay ?? this.enableRazorpay,
      enableCashondelivery: enableCashondelivery ?? this.enableCashondelivery,
      // publishableKey: publishableKey ?? this.publishableKey,
      // secretKey: secretKey ?? this.secretKey,
      // flutterwavePublicKey: flutterwavePublicKey ?? this.flutterwavePublicKey,
      // paystackPublicKey: paystackPublicKey ?? this.paystackPublicKey,
      // backendUrl: backendUrl ?? this.backendUrl,
      // encryptionKey: encryptionKey ?? this.encryptionKey,
      getPublishableKey: getPublishableKey ?? this.getPublishableKey,
      getSecretKey: getSecretKey ?? this.getSecretKey,
      getFlutterwavePublicKey:
          getFlutterwavePublicKey ?? this.getFlutterwavePublicKey,
      getPaystackPublicKey: getPaystackPublicKey ?? this.getPaystackPublicKey,
      getBackendUrl: getBackendUrl ?? this.getBackendUrl,
      getFlutterwaveSecretKey: getFlutterwaveSecretKey ?? this.getFlutterwaveSecretKey,
      getRazorPayKey: getRazorPayKey ?? this.getRazorPayKey,
      // razorPayKey: razorPayKey ?? this.razorPayKey,
    );
  }
}
