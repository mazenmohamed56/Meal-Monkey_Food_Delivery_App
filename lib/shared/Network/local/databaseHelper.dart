import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
/*   var uid = CacheHelper.getData(key: 'uId');
 */
  Future<Database> createDatabase(uid) async {
    return openDatabase('cart.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE A$uid (id TEXT PRIMARY KEY , itemCount INTEGER, totalPrice INTEGER)');
    }, onOpen: (Database db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS A$uid (id TEXT PRIMARY KEY , itemCount INTEGER, totalPrice INTEGER)');
    });
  }

  void insertToDatabase({
    required String uid,
    required String id,
    required int itemCount,
    required int totalPrice,
  }) async {
    final Database db = await createDatabase(uid);
    db.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT OR REPLACE INTO A$uid(id, itemCount, totalPrice) VALUES("$id", $itemCount, $totalPrice)',
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
      required String uid,
      required int totalPrice,
      required String id}) async {
    final Database db = await createDatabase(uid);

    db.rawUpdate('UPDATE A$uid SET itemCount = ? ,totalPrice = ?  WHERE id = ?',
        [itemCount, totalPrice, id]).then((value) {
      print('$value Update successfully');
    }).catchError((error) {
      print('Error When Update  Record ${error.toString()}');
    });
  }

  delteData({required String id, required Stream uid}) async {
    final Database db = await createDatabase(uid);

    db.rawUpdate('DELETE FROM A$uid WHERE id = ?', [id]).then((value) {});
  }

  Future<List<Map>> getdata({required String uid}) async {
    final Database db = await createDatabase(uid);

    return db.rawQuery('SELECT * FROM A$uid');
  }

  void delete({required String uid}) async {
    final Database db = await createDatabase(uid);
    db.delete('A$uid');
  }
}
