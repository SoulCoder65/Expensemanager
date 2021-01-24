
//Template for Creating Expense
import 'package:flutter/cupertino.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Expense({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}