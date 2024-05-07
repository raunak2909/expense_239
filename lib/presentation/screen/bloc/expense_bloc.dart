import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui/data/model/expense-model.dart';

import '../../../data/repository/local/local_database.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  MyDataHelper db;
  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {

    on<FetchInitialExpenses>((event, emit) async{
      emit(ExpenseLoadingState());

      var mData = await db.fecExpense();
      emit(ExpenseLoadedState(allExpenses: mData));

    });

    on<AddExpense>((event, emit) async{

      emit(ExpenseLoadingState());

      var check = await db.addExpense(expenseModel: event.newExpense);

      if(check){
        var mData = await db.fecExpense();
        emit(ExpenseLoadedState(allExpenses: mData));
      } else {
        emit(ExpenseErrorState(errorMsg: "Expense not added!"));
      }


    });
  }
}
