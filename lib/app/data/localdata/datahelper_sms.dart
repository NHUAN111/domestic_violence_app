import 'package:project_domestic_violence/app/models/sms.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperSMS {
  static final DatabaseHelperSMS _instance = DatabaseHelperSMS._internal();

  factory DatabaseHelperSMS() => _instance;

  DatabaseHelperSMS._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'sms_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sms (
        smsId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT NOT NULL,
        desc TEXT NOT NULL
      )
    ''');
  }

  // Thêm SMS vào cơ sở dữ liệu
  Future<void> insertSMS(SMSModel sms) async {
    final db = await database;

    try {
      await db.insert('sms', sms.toJson());
      print('Insert successful: ${sms.smsId}, ${sms.userId}, ${sms.desc}');
    } catch (e) {
      print('Error inserting SMS: $e');
    }
  }

  // Lấy tất cả SMS theo userId
  Future<List<SMSModel>> getAllSMS(String userId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'sms',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return List.generate(result.length, (i) {
        return SMSModel.fromJson(result[i]);
      });
    } else {
      return [];
    }
  }

  // Xóa SMS theo smsId
  Future<void> deleteSMS(int smsId) async {
    final db = await database;

    try {
      await db.delete(
        'sms',
        where: 'smsId = ?',
        whereArgs: [smsId],
      );
      print('Delete successful: $smsId');
    } catch (e) {
      print('Error deleting SMS: $e');
    }
  }

  // Cập nhật thông tin SMS
  Future<void> updateSMS(SMSModel sms) async {
    final db = await database;

    try {
      await db.update(
        'sms',
        sms.toJson(),
        where: 'smsId = ?',
        whereArgs: [sms.smsId],
      );
      print('Update successful: ${sms.smsId}');
    } catch (e) {
      print('Error updating SMS: $e');
    }
  }
}
