import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project_domestic_violence/app/models/contact.dart';

class DatabaseHelperContact {
  static final DatabaseHelperContact _instance =
      DatabaseHelperContact._internal();

  factory DatabaseHelperContact() => _instance;

  DatabaseHelperContact._internal();

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
    final path = join(databasesPath, 'contact_database_v2.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tạo lại bảng mới nếu cần, nếu bảng đã tồn tại, nó sẽ được xoá trước khi tạo lại
    // await db.execute('DROP TABLE IF EXISTS contacts');
    await db.execute('''
      CREATE TABLE contacts (
        contactId INTEGER PRIMARY KEY AUTOINCREMENT,  
        userId TEXT NOT NULL,  
        name TEXT NOT NULL,    
        phoneNumber TEXT NOT NULL  
      )
    ''');
  }

  // Thêm contact vào cơ sở dữ liệu
  Future<void> insertContact(Contact contact) async {
    final db = await database;

    try {
      await db.insert('contacts', {
        'userId': contact.userId.toString(),
        'name': contact.name.toString(),
        'phoneNumber': contact.phoneNumber.toString(),
      });
      print(
          'Insert successful: ${contact.userId}, ${contact.name}, ${contact.phoneNumber}');
    } catch (e) {
      print('Error inserting contact: $e');
    }
  }

  // Lấy tất cả contact theo userId
  Future<List<Contact>> getAllContacts(String userId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'contacts',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return List.generate(result.length, (i) {
        return Contact.fromJson(result[i]);
      });
    } else {
      return [];
    }
  }

  // Xóa contact theo contactId
  Future<void> deleteContact(int contactId) async {
    final db = await database;

    try {
      await db.delete(
        'contacts',
        where: 'contactId = ?',
        whereArgs: [contactId],
      );
      print('Delete successful: $contactId');
    } catch (e) {
      print('Error deleting contact: $e');
    }
  }

  // Cập nhật thông tin contact
  Future<void> updateContact(Contact contact) async {
    final db = await database;

    try {
      await db.update(
        'contacts',
        {
          'userId': contact.userId.toString(),
          'name': contact.name.toString(),
          'phoneNumber': contact.phoneNumber.toString(),
        },
        where: 'contactId = ?',
        whereArgs: [contact.contactId],
      );
      print('Update successful: ${contact.contactId}');
    } catch (e) {
      print('Error updating contact: $e');
    }
  }
}
