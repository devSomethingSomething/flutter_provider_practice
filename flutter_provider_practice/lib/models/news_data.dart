import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier {
  Map<String, dynamic> _map = {};

  bool _error = false;

  String _errorMessage = '';

  Future<void> get fetchData async {
    final response = await get(
      Uri.parse(
        'https://dl.dropbox.com/s/tifvv3vx91wfnmg/stories.json?dl=0',
      ),
    );

    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);

        _error = false;
      } catch (e) {
        _error = true;

        _errorMessage = e.toString();

        _map = {};
      }
    } else {
      _error = true;

      _errorMessage = 'Error: Connection could be bad?';

      _map = {};
    }

    notifyListeners();
  }
}
