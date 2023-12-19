import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:expenses_app/models/expense.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveExpenseDbModel(ExpenseDbModel newExpenseDbModel) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.expenseDbModels.putSync(newExpenseDbModel));
  }


  Future<List<ExpenseDbModel>> getAllExpenseDbModels() async {
    final isar = await db;
    final allExpenses = await isar.expenseDbModels.where().findAll();
    return allExpenses;
  }

  // Stream<List<ExpenseDbModel>> listenToExpenseDbModels() async* {
  //   final isar = await db;
  //   yield* isar.expenseDbModels.where().watch(initialReturn: true);
  // }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }


  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ExpenseDbModelSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}