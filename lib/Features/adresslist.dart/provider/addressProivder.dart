import 'package:batechtask/core/services/api.dart';
import 'package:flutter/material.dart';

class Addressproivder extends ChangeNotifier {
  final ApiService api;
  List addresses = [];
  bool loading = false;

  Addressproivder({required this.api});
  editdata(
      {required int index,
      required String name,
      required String address}) async {
    try {
      startloader();
      await api.editapi(index: index, body: {"name": name, "address": address});
      await getdata();
    } catch (e) {
      throw "Something Went Wrong";
    } finally {
      cutloader();
    }
  }

  deletedata({required int index}) async {
    try {
      startloader();
      await api.deleteapi(index: index);
      await getdata();
    } catch (e) {
      throw "something Went Wrong";
    } finally {
      cutloader();
    }
  }

  adddata({required String name, required String address}) async {
    try {
      startloader();
      await api.postapi(body: {"name": name, "address": address});
      await getdata();
    } catch (e) {
      throw e.toString();
    } finally {
      cutloader();
    }
  }

  getdata() async {
    try {
      startloader();
      var val = await api.getApi();
      addresses = val != Null ? val : [];
      notifyListeners();
    } catch (e) {
      throw "something Went Wrong";
    } finally {
      cutloader();
    }
  }

  startloader() {
    loading = true;
    notifyListeners();
  }

  cutloader() {
    loading = false;
    notifyListeners();
  }
}
