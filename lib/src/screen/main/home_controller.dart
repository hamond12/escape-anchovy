import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  final List<Map<String, dynamic>> dataList = [
    {
      'day': 1,
      'ex1_name': '풀업',
      'ex2_name': '푸쉬업',
      'ex1': [10, 8, 6],
      'ex2': [20, 15, 10]
    },
    {
      'day': 2,
      'ex1_name': '풀업',
      'ex2_name': '푸쉬업',
      'ex1': [10, 8, 6],
      'ex2': [20, 15, 10]
    },
    {
      'day': 3,
      'ex1_name': '풀업',
      'ex2_name': '푸쉬업',
      'ex1': [10, 8, 6],
      'ex2': [20, 15, 10]
    },
  ];
}
