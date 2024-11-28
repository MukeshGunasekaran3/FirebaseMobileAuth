import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  postapi({required body}) async {
    try {
      print(body);
      var res = await http.post(
          Uri.parse("https://api-generator.retool.com/fFVqsX/address"),
          body: body);
      if (res.statusCode != 201) {
        throw "conncetion Error";
      }
    } catch (e) {
      print("error");
      throw e.toString();
    }
  }

  getApi() async {
    try {
      var res = await http
          .get(Uri.parse("https://api-generator.retool.com/fFVqsX/address"));
      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);
        return json;
      } else {
        throw "status code error";
      }
    } catch (e) {
      throw "Something went wrong please try again late";
    }
  }

  deleteapi({required int index}) async {
    try {
      var res = await http.delete(
        Uri.parse("https://api-generator.retool.com/fFVqsX/address/$index"),
      );
      print("https://api-generator.retool.com/fFVqsX/address/$index");
      print("hello World");
      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);
        return json;
      } else {
        throw "no data";
      }
    } catch (e) {
      print("error");
      throw "Something went wrong please try again later";
    }
  }

  editapi({required int index, required body}) async {
    try {
      var res = await http.put(
          Uri.parse("https://api-generator.retool.com/fFVqsX/address/$index"),
          body: body);
      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);
        return json;
      } else {
        throw "no data";
      }
    } catch (e) {
      print("error");
      throw "Something went wrong please try again later";
    }
  }
}
