part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

class FetchInitialExpenses extends ExpenseEvent{}
class AddExpense extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpense({required this.newExpense});
}

/// other event classes
