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
      'ex1': [10, 7, 5],
      'ex2': [24, 18, 12]
    },
    {
      'day': 3,
      'ex1_name': '풀업',
      'ex2_name': '푸쉬업',
      'ex1': [11, 8, 7],
      'ex2': [24, 15, 10]
    },
  ];
}
