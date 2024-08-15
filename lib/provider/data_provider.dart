import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_test/model/data_model.dart';

class DataProvider extends ChangeNotifier {
  final Map<String, List<DataModel>> _cachedData = {};

  Future<void> fetchData(String tabKey) async {
    if (!_cachedData.containsKey(tabKey)) {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _cachedData[tabKey] =
            jsonData.map((item) => DataModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  List<DataModel>? getData(String tabKey) => _cachedData[tabKey];
}
