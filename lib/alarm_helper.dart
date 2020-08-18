import 'package:clock_app/model/alarm_model.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper.creatInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper.creatInstance();
    }
    return _alarmHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm(
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnDateTime text not null,
            $columnPending integer,
            $columnColorIndex integer)
      ''');
      },
    );
    return database;
  }

  void insetAlarm(AlarmModel alarmModel) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmModel.toMap());
    print('result : $result');
  }

  Future<List<AlarmModel>> getAlarms() async {
    List<AlarmModel> _alarms = [];
    var db = await this.database;
    var result =
        await db.rawQuery("SELECT * FROM $tableAlarm ORDER BY $columnId DESC");
    result.forEach((element) {
      var alrmModel = AlarmModel.fromMap(element);
      _alarms.add(alrmModel);
    });
    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
