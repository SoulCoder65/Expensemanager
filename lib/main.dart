import 'package:expense_tracker/BarTemplate.dart';
import 'package:flutter/material.dart';
import 'Expense.dart'; //Expense Class
import 'expenselist.dart';//Getting list of all transactions
import 'chart.dart';//getting chart data
import 'package:intl/intl.dart'; //Formating Date

void main()=>runApp(MaterialApp(
  title: "Expense Tracker",
  theme: ThemeData(primarySwatch: Colors.green,
  accentColor: Colors.greenAccent,
   ),
  debugShowCheckedModeBanner: false,
  home: MainPage(),
));

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Declare controllers
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  DateTime chooseDate;

  //list of expenses
  List<Expense> expenses=List<Expense>();
  //Select Date Function
  void selectDate()
  {
    showDatePicker(context: context,
        initialDate: DateTime.now() ,
        firstDate: DateTime(2000),
        lastDate: DateTime.now()
    ).then((value) {
      if(value==null)
        {
          return;
        }
      setState(() {
      chooseDate=value;
      });
    });
  }
  //Show Modal
  //Modal
  void _showModel(BuildContext context)
  {
    showModalBottomSheet(context: context,
        builder: (_)
        {
          return GestureDetector(
              onTap: () {

              },
              child: Container(
                  height: 800,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //Title Field
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            hintText: "Enter Title ",
                            labelText: "Title"
                        ),
                        autofocus: true,
                      ),
                      //  Amount Field
                      TextFormField(
                        controller: amountController,
                        decoration: const InputDecoration(
                            labelText: "Amount",
                            hintText: "Enter Amount"
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Text(chooseDate==null?"No Date Choosen Yet":DateFormat.yMMMd().format(chooseDate).toString()),
                          FlatButton(onPressed: () {
                            print("Hello");
                            selectDate();
                          }, child: Text("Choose Date",style: TextStyle(color: Colors.green)),splashColor: Theme.of(context).primaryColor,)
                        ],
                      ),
                      //  Submit Button
                      MaterialButton(onPressed: () {
                        showResult();
                      },child: Text("Add"),color: Colors.orangeAccent,)

                    ],
                  )
              ),

          );
        }
    );
  }
  //show modal end

  //ON submit
  void showResult()
  {
    final newExpense=new Expense(
        title:titleController.text,
        amount:double.parse(amountController.text),
        date: chooseDate,
        id:DateTime.now().toString()

    );
    if(titleController.text.isEmpty || double.parse(amountController.text)<0.0|| chooseDate==null)
      {
        return;
      }
    setState(() {
      expenses.add(newExpense);
      titleController.text=" ";
      amountController.text=" ";
      chooseDate=null;
    });
    Navigator.of(context).pop();
  }
  //On submit end
  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }
  // For deleting expenses
  void deleteExpense(String id)
  {
    setState(() {
      expenses.removeWhere((element) => element.id==id);
    });

  }

  List <Expense> get _recentExpenses{
    return expenses.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        elevation: 3,
        actions: [
          ElevatedButton(onPressed: () {
          _showModel(context);
          }, child: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
      _showModel(context);
      },child: Icon(Icons.add),),
    body: SafeArea(

        child: ListView(
          children: <Widget>[
            Chart(_recentExpenses),
            ExpenseList(expenses,deleteExpense),
          ],
        ),

    ),
    );
  }
}
//main=> holds main page or home screen
// ExpenseList => holds list of all expenses in list format with delete functionality
//Expense => created class for adding new Expenses;
//BarTemplate => Template for creating bars
