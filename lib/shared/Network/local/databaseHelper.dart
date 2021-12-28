import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  var uid = CacheHelper.getData(key: 'uId');
  Future<Database> createDatabase() async {
    return openDatabase('cart.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $uid (id TEXT PRIMARY KEY , itemCount INTEGER, totalPrice INTEGER)');
    }, onOpen: (Database db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $uid (id TEXT PRIMARY KEY , itemCount INTEGER, totalPrice INTEGER)');
    });
  }

  void insertToDatabase({
    required String id,
    required int itemCount,
    required int totalPrice,
  }) async {
    final Database db = await createDatabase();
    db.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT OR REPLACE INTO $uid(id, itemCount, totalPrice) VALUES("$id", $itemCount, $totalPrice)',
      )
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  updateDate(
      {required int itemCount,
      required int totalPrice,
      required String id}) async {
    final Database db = await createDatabase();

    db.rawUpdate('UPDATE $uid SET itemCount = ? ,totalPrice = ?  WHERE id = ?',
        [itemCount, totalPrice, id]).then((value) {
      print('$value Update successfully');
    }).catchError((error) {
      print('Error When Update  Record ${error.toString()}');
    });
  }

  delteData({required String id}) async {
    final Database db = await createDatabase();

    db.rawUpdate('DELETE FROM $uid WHERE id = ?', [id]).then((value) {});
  }

  List<Map> cart = [];
  Future<List<Map>> getdata() async {
    final Database db = await createDatabase();

    return db.rawQuery('SELECT * FROM $uid');
  }

  void delete() async {
    final Database db = await createDatabase();
    cart = [];
    db.delete('$uid');
  }
}
