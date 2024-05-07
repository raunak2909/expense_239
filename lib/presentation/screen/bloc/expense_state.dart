part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitialState extends ExpenseState {}
final class ExpenseLoadingState extends ExpenseState {}
final class ExpenseLoadedState extends ExpenseState {
  List<ExpenseModel> allExpenses;
  ExpenseLoadedState({required this.allExpenses});
}
final class ExpenseErrorState extends ExpenseState {
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}
