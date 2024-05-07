import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ui/data/model/date_wise_expense_model.dart';
import 'package:ui/data/repository/local/local_database.dart';
import 'package:ui/domain/app_constant.dart';
import 'package:ui/presentation/screen/bloc/expense_bloc.dart';

import '../../../data/model/expense-model.dart';

class ExpensePage1 extends StatefulWidget {
  @override
  State<ExpensePage1> createState() => _ExpensePage1State();
}

class _ExpensePage1State extends State<ExpensePage1> {
  List<ExpenseModel> listExpenses = [];
  List<DateWiseExpenseModel> listDateWiseExpModel = [];

  var dateFormat = DateFormat.yMMMMd();

  @override
  void initState() {
    super.initState();

    context.read<ExpenseBloc>().add(FetchInitialExpenses());
    //getExpenses();
  }

/*  void getExpenses() async {
    var db = MyDataHelper.db;
    listExpenses = await db.fecExpense();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/image/pp.png'),
            Text(
              'Monety',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 9, right: 9, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.asset('assets/image/pr.jpeg'),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          ' Morning',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade500),
                        ),
                        Text(
                          ' Jack',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5)),
                  height: 35,
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This Month',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.arrow_drop_down_outlined)
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 9, bottom: 9),
                  height: 220,
                  width: 450,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  Expense Total',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Text(
                          '  \$4,528',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 9, bottom: 9),
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text('+\$234',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                            ),
                            Text('  than last month',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  child: Image.asset(
                    'assets/image/h3.png',
                  ),
                )
              ],
            ),
            Text(
              'Expense List',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (_, state) {
                if (state is ExpenseLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ExpenseErrorState) {
                  return Center(
                    child: Text('Error: ${state.errorMsg}'),
                  );
                }

                if (state is ExpenseLoadedState) {
                  filterExpenseDateWise(allExpenses: state.allExpenses);

                  return ListView.builder(
                    itemCount: listDateWiseExpModel.length,
                      itemBuilder: (_, parentIndex){
                    return Container(
                      margin: EdgeInsets.only(top: 9,bottom: 9),
                      width: 450,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${listDateWiseExpModel[parentIndex].date}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              Text('-\$${listDateWiseExpModel[parentIndex].totalAmt}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                            ],),
                          Padding(
                            padding: const EdgeInsets.only(top:5,bottom: 5),
                            child: Container(
                              color: Colors.grey,
                              width: 450,
                              height: 3,
                            ),
                          ),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: listDateWiseExpModel[parentIndex].eachDateAllExpenses.length,
                            itemBuilder: (_, index) {
                              var filteredList = AppConstants.mCategories
                                  .where((element) =>
                              element.catId == listDateWiseExpModel[parentIndex].eachDateAllExpenses[index].catId)
                                  .toList();
                              String imgPath = filteredList[0].catImgPath;

                              return ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(imgPath),
                                  ),
                                ),
                                title: Text(
                                  listDateWiseExpModel[parentIndex].eachDateAllExpenses[index].title,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  listDateWiseExpModel[parentIndex].eachDateAllExpenses[index].desc,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                trailing: Text(
                                  '  -\u{20B9}${listDateWiseExpModel[parentIndex].eachDateAllExpenses[index].amount}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.pinkAccent),
                                ),
                              );
                            })

                        ],
                        ),
                      ),
                    );
                  });
                }

                return Container();
              },
            ))

            /*Container(
          margin: EdgeInsets.only(top: 9,bottom: 9),
          height: 230,
          width: 450,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Monday, 14',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                Text('-\$1947',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
              ],),
              Padding(
                padding: const EdgeInsets.only(top:5,bottom: 5),
                child: Container(
                  color: Colors.grey,
                  width: 450,
                  height: 3,
                ),
              ),
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.shopping_bag_outlined),
                ),
                title: Text('Shop',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                subtitle: Text('Buy new clothes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                trailing: Text('  -\$939',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.pinkAccent),),
              ),
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.mobile_friendly),
                ),
                title: Text('Electronics',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                subtitle: Text('Buy new ipone',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                trailing: Text('  -\$1004',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.pinkAccent),),
              ),


            ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 9,bottom: 9),
          height: 170,
          width: 450,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Friday, 3',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,),),
                  Text('-\$674',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,),),
                ],),
              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: Container(
                  color: Colors.grey,
                  width: 450,
                  height: 3,
                ),
              ),
              ListTile(
               leading: Container(
                 width: 60,
                 height: 60,
                 decoration: BoxDecoration(
                   color: Colors.red.shade300,
                   borderRadius: BorderRadius.circular(5),
                 ),
                 child: Icon(Icons.card_membership),
               ),
                title: Text('Transportation',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                subtitle: Text('Trip to Dubai',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                trailing: Text('  -\$674',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.pinkAccent),),
              )
            ],
            ),
          ),
        ),*/
          ],
        ),
      ),
    );
  }

  void filterExpenseDateWise({required List<ExpenseModel> allExpenses}) {
    listDateWiseExpModel.clear();
    /// find the unique dates
    List<String> uniqueDates = [];

    for (int i = 0; i<allExpenses.length; i++) {
      var createdAt = allExpenses[i].time;
      var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseDate = dateFormat.format(mDateTime);

      print(eachExpenseDate);
      //var eachExpenseDate = "${mDateTime.day}-${mDateTime.month}-${mDateTime.year}";

      if (!uniqueDates.contains(eachExpenseDate)) {
        uniqueDates.add(eachExpenseDate);
      }
      print(uniqueDates);
    }

    for (String eachDate in uniqueDates) {
      num totalExpAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];

      for (ExpenseModel eachExpense in allExpenses) {
        var createdAt = eachExpense.time;
        var mDateTime =
            DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
        var eachExpenseDate = dateFormat.format(mDateTime);

        if (eachExpenseDate == eachDate) {
          eachDateExpenses.add(eachExpense);

          if (eachExpense.type == "Debit") {
            totalExpAmt -= int.parse(eachExpense.amount);
          } else {
            totalExpAmt += int.parse(eachExpense.amount);
          }
        }
      }

      listDateWiseExpModel.add(DateWiseExpenseModel(
          date: eachDate,
          totalAmt: totalExpAmt.toString(),
          eachDateAllExpenses: eachDateExpenses));
    }

    print(listDateWiseExpModel.length);
  }
}




