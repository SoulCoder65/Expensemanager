import 'package:flutter/material.dart';
import 'Expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatefulWidget {
  final List<Expense> expenses;
  final Function deleteExpense;
  ExpenseList(this.expenses,this.deleteExpense);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {

  Widget cardTemplate(String title,double amount,DateTime dt,String id)
 {
   return Card(

     child: ListTile(
       leading: Container(
         width: 70,
         height: 60,
         decoration: BoxDecoration(
           border: Border.all(width: 2),
           shape: BoxShape.circle,
           // You can use like this way or like the below line
           //borderRadius: new BorderRadius.circular(30.0),
           color: Colors.green,
         ),
         child:Column(

           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text('₹${amount.toString()}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),

           ],
         ),
       ),
       title: Text(title),
       subtitle: Text((DateFormat.yMMMd().format(dt)).toString()),
       trailing: IconButton(onPressed:() => widget.deleteExpense(id),icon: Icon(Icons.delete_forever),color: Theme.of(context).errorColor,),
     ),
     elevation: 10,
   );
 }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: SizedBox(
        height: 600,
        child: widget.expenses.isEmpty?Column(
          children: [
            Text("No Expenses To Show..",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20)),
            Image.asset('assets/images/norecord.png')

          ],
        ):ListView.builder(
              itemBuilder:(context, index) {
                return cardTemplate(widget.expenses[index].title, widget.expenses[index].amount,widget.expenses[index].date,widget.expenses[index].id);
              },itemCount: ((widget.expenses.length!=0)?widget.expenses.length:0), )


      ),
    );

  }
}
