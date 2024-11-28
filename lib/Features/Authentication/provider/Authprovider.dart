import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_card_info/sim_info.dart';

class AuthProivder extends ChangeNotifier {
  bool otpSent = false;
  bool isLoading = false;
  String verificationId = "";
  List<SimInfo>? simInfo;
  final _simCardInfoPlugin = SimCardInfo();
  bool isSupported = true;
  String fetchednumber = "";

  sendOtp({required String phonenumber}) async {
    isLoading = true;
    notifyListeners();
    final completer = Completer<void>();
    phonenumber = "+91$phonenumber".trim();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e.message ?? "Verification failed");
        },
        codeSent: (String verId, int? resendToken) {
          otpSent = true;
          verificationId = verId;
          notifyListeners();
          completer.complete();
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
          notifyListeners();
        },
      );
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  cutloader() {
    isLoading = false;
    notifyListeners();
  }

  verifyOtp({required String otp}) async {
    isLoading = true;
    notifyListeners();
    final completer = Completer<void>();

    if (verificationId.isEmpty || otp.isEmpty) {
      throw "Please enter the OTP";
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      completer.complete();
    } catch (e) {
      completer.completeError(e);
    }
  }

  initSimInfoState() async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      List<SimInfo> simCardInfo;
      try {
        simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
      } catch (e) {
        simCardInfo = [];
        isSupported = false;
        notifyListeners();
      }
      simInfo = simCardInfo;
      notifyListeners();
    } else {
      throw "Permission Denied to fetch sim data ,Enter manuallly";
    }
  }
}
