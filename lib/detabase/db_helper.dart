import 'package:e_learning_app/model/category.dart';
import 'package:e_learning_app/model/question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DB_NAME = 'question.db';
  static const DB_VERSION = 1;
  static const TBL_QUE = 'questions';
  static const TBL_CATEGORY = 'Category';

  static const COL_CID = "cid";
  static const CATEGORYTYPE = "CategoryName";

  static const COL_QID = 'qid';
  static const COL_QUE = 'que';
  static const COL_OP1 = 'op1';
  static const COL_OP2 = 'op2';
  static const COL_OP3 = 'op3';
  static const COL_OP4 = 'op4';
  static const COL_CATEGORY_ID = "cids";
  static const COL_ANS = 'answer';
  static const COL_CREATED_AT = 'createdAt';

  DbHelper._internal();

  static DbHelper _instance = DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  static Database? _database;

  Future<Database?> getDatabase() async {
    _database ??= await createDatabase();
    return _database;
  }

  Future<Database?> createDatabase() async {
    var dbPath = await getDatabasesPath();
    var dbName = "question.db";

    print('database path : ${dbPath}');
    print('database name : ${dbName}');

    var path = join(dbPath, dbName);
    print('actual path : ${path}');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $TBL_CATEGORY('
            '$COL_CID INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$CATEGORYTYPE TEXT)');

        await db.execute('CREATE TABLE $TBL_QUE('
            '$COL_QID INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$COL_QUE TEXT NOT NULL,'
            '$COL_OP1 TEXT NOT NULL,'
            '$COL_OP2 TEXT NOT NULL,'
            '$COL_OP3 TEXT NOT NULL,'
            '$COL_OP4 TEXT NOT NULL,'
            '$COL_ANS INTEGER,'
            '$COL_CATEGORY_ID INTEGER,'
            '$COL_CREATED_AT INTEGER,'
            'FOREIGN KEY ($COL_CATEGORY_ID) REFERENCES $TBL_CATEGORY($COL_CID)ON DELETE CASCADE)');
      },
    );
  }

  Future<int> insert_category(Category category) async {
    final db = await getDatabase();
    print("InsertData");
    if (db != null) {
      return await db.insert(TBL_CATEGORY, category.toMap());
    }
    return -1;
  }

  Future<List<Category>> read_category() async {
    var categoryList = <Category>[];
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps =
        await db!.rawQuery('SELECT * FROM $TBL_CATEGORY');
    print(maps);

    if (maps.isNotEmpty) {
      categoryList = maps.map((map) => Category.fromJson(map)).toList();
    }

    return categoryList;
  }

  Future<int> deleteCategory(int? id) async {
    final db = await getDatabase();

    // First, delete all questions associated with the category id
    await db!.delete(TBL_QUE, where: '$COL_CATEGORY_ID = ?', whereArgs: [id]);

    // Then, delete the category itself
    return await db
        .delete(TBL_CATEGORY, where: '$COL_CID = ?', whereArgs: [id]);
  }

  Future<int> updateCategory(Category cates) async {
    final db = await getDatabase();
    return await db!.update(TBL_CATEGORY, cates.toMap(),
        where: '${COL_CID} = ?', whereArgs: [cates.id]);
  }

  Future<int> insertQuestion(Question question) async {
    Database? db = await getDatabase();
    if (db != null) {
      return db.insert(TBL_QUE, question.toMap());
    }
    return -1;
  }

  Future<List<Question>> getAllQuestion() async {
    Database? db = await getDatabase();

    List<Map<String, dynamic>> mapList =
        await db!.rawQuery('SELECT * FROM $TBL_QUE');
    return List.generate(
            mapList.length, (index) => Question.fromMap(mapList[index]))
        .toList(); // converting map object into dart object
  }

  Future<List<Question>> getCategoryQuestion(int? id) async {
    Database? db = await getDatabase();

    List<Map<String, dynamic>> mapList = await db!
        .query(TBL_QUE, where: '$COL_CATEGORY_ID = ?', whereArgs: [id]);

    return List.generate(
        mapList.length, (index) => Question.fromMap(mapList[index])).toList();
  }

  Future<int> deleteQuestion(int? id) async {
    final db = await getDatabase();
    return await db!.delete(TBL_QUE, where: '${COL_QID} =?', whereArgs: [id]);
  }
}
