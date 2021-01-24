
import 'package:flutter/material.dart';
import 'BarTemplate.dart';//for bar template
import 'package:intl/intl.dart';//Managing date
import 'Expense.dart'; //get expense class

class Chart extends StatelessWidget {
  final List<Expense> expenses;
  Chart(this.expenses);
  //Checking recent expenses;
  List<Map<String,Object>> get groupExpenses{
    return List.generate(7,(index)
        {
          final weekday=DateTime.now().subtract(Duration(days: index));
          double totalSum=0;
          for(var i=0;i<expenses.length;i++)
            {
              if(expenses[i].date.day==weekday.day &&
                expenses[i].date.month==weekday.month &&
                expenses[i].date.year==weekday.year)
                {
                  totalSum+=expenses[i].amount;
                }
            }
          
          return {'day':DateFormat.E().format(weekday),'amount':totalSum};
        }).reversed.toList();
  }
  //GEt total expense fold==reduce
  double get totalExpense{
    return groupExpenses.fold(0.0, (sum, element) {
      return sum+ element['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupExpenses.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            //Sending data to create charts
            child: BarTemplate(
              data['day'],
              data['amount'],
              totalExpense==0.0?0.0:(data['amount'] as double)/totalExpense,
            ),
          );
        }).toList()
      ),
    );
  }
}
