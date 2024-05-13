import 'expense-model.dart';

class MonthWiseExpenseModel{
  String month;
  String totalAmt;
  List<ExpenseModel> eachMonthAllExpenses;

  MonthWiseExpenseModel({required this.month, required this.totalAmt, required this.eachMonthAllExpenses});
}