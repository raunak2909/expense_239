import 'package:ui/data/repository/local/local_database.dart';

class ExpenseModel {
  int id;
  int uid;
  String title;
  String desc;
  String time;
  String amount;
  String balance;
  String type;
  int catId;

  ExpenseModel(
      {required this.title,
      required this.desc,
      required this.time,
      required this.amount,
      required this.balance,
      required this.type,
      required this.id,
      required this.uid,
      required this.catId});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map[MyDataHelper.TABLE_COLUMN_EXPID],
        uid: map[MyDataHelper.TABLE_COLUMN_UID],
        title: map[MyDataHelper.TABLE_COLUMN_ETITLE],
        desc: map[MyDataHelper.TABLE_COLUMN_EDESC],
        time: map[MyDataHelper.TABLE_COLUMN_ETIME],
        amount: map[MyDataHelper.TABLE_COLUMN_EAMOUNT],
        balance: map[MyDataHelper.TABLE_COLUMN_EBALANCE],
        type: map[MyDataHelper.TABLE_COLUMN_ETYPE],
        catId: map[MyDataHelper.TABLE_COLUMN_CATID]);
  }

  Map<String, dynamic> toMap() {
    return {
      MyDataHelper.TABLE_COLUMN_ETITLE: title,
      MyDataHelper.TABLE_COLUMN_EDESC: desc,
      MyDataHelper.TABLE_COLUMN_ETIME: time,
      MyDataHelper.TABLE_COLUMN_EAMOUNT: amount,
      MyDataHelper.TABLE_COLUMN_EBALANCE: balance,
      MyDataHelper.TABLE_COLUMN_ETYPE: type,
      MyDataHelper.TABLE_COLUMN_CATID: catId,
      MyDataHelper.TABLE_COLUMN_UID: uid,
    };
  }
}
