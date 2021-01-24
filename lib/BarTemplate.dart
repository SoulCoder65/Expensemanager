import 'package:flutter/material.dart';

class BarTemplate extends StatelessWidget {
  //declaring charts variables
  final String label;
  final double spendMoney;
  final double spendMoneyPercent;
  BarTemplate(this.label,this.spendMoney,this.spendMoneyPercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(child: Text('₹${spendMoney.toStringAsFixed(0)}')),
        ),
        SizedBox(height: 5,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey,width: 1.0),
                  color: Color.fromRGBO(220,220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendMoneyPercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
              )
            ],
          ),
        ),
        Text(label),

      ],
    );
  }
}
