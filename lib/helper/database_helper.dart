import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print("Database already exist at path: ${_database!.path}");
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print("Database successfully created at path: ${db.path}");
        // Create tables here
        db.execute('''
        CREATE TABLE student (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER,
          address TEXT,
          enrollment_date TEXT
        )
        ''');
      },
    );
  }

  Future<void> insertValueIntoStudentTable() async {
    _database ??= await _initDatabase();
    await _database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Student (name, age, address, enrollment_date) VALUES ("Jane Smith", 22, "456 Elm St", "2023-09-15")',
      );
      print("Inserted row id: $id1");
      int id2 = await txn.rawInsert(
        'INSERT INTO Student (name, age, address, enrollment_date) VALUES ("Alice Johnson", 19, "789 Oak St", "2023-08-20")',
      );
      print("Inserted row id: $id2");
    });
  }

  Future<void> getAllStudentRecords() async {
    _database ??= await _initDatabase();
    List<Map<String, dynamic>> records = await _database!.rawQuery(
      'SELECT * FROM Student',
    );
    print("Student Records: $records");
  }

  Future<void> updateStudentRecordById(int id) async {
    _database ??= await _initDatabase();

    int changesCount = await _database!.rawUpdate(
      'UPDATE Student SET name = "Abdullah Khan Kakar", address = "Lahore, PAKISTAN"',
    );
    print("Changes Count: $changesCount");
  }

  Future<void> deleteAllStudentRecords() async {
    _database ??= await _initDatabase();

    int changesCount = await _database!.rawDelete('DELETE FROM Student');
    print("Changes Count: $changesCount");
  }
}
