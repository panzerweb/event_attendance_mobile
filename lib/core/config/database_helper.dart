import 'package:event_attendance_mobile/feature/present/data/models/priority_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'dart:async';
// import 'package:flutter/widgets.dart';

/*
  SQFlite Database Helper
  Database helper to avoid SQL injection and exposure or raw SQL query

  Sample usage for implementation:

    class EventRepoimpl implements EventRepository {
      final DatabaseHelper db;

      // Methods
    }

  Allows the implementation to access the database methods such as 
  CREATE, READ, UPDATE, and DELETE
  
  Usage for main.dart:
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();

      final sqlFliteDb = DatabaseHelper.instance;

      final eventRepository = EventRepoimpl(sqlFliteDb);

      // So the Cubit has an application-wide lifecycle and is 
      // accessible across all routes
      
      runApp(
        BlocProvider(
          create: (_) => EventCubit(eventRepository),
          child: const MyApp(), //Now EventCubit is available to all the routes
        ),
      );
  
  Here, we create and inject the database and repository before the app starts, 
  then provide the Cubit at the root of the widget tree so it is available across 
  all routes inside MyApp().
}

*/

class DatabaseHelper {
  static final _databaseName = 'present_mobile.db';
  static final _databaseVersion = 1;

  // TABLES
  static final eventTable = 'events';
  static final eventPriorityTable = 'event_priority';
  static final attendeesTable = 'attendees';

  final DateTime date = DateTime.now();
  String get formattedDate => DateFormat('yyyy-MM-dd').format(date);

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database?
  _database; // This will refer to a single-wide app reference to the database

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    // ignore: avoid_print
    print("Init Database");

    return await openDatabase(
      path,
      version: _databaseVersion,
      onOpen: (db) async {
        // ignore: avoid_print
        print("Opened database: $_databaseName");
      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON'); //Turns on Foreign Keys
      },
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  // Currently have 3 existing tables: event_priority, events, and attendees table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $eventPriorityTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      priority_name TEXT NOT NULL,
      created_at TEXT
    )
    ''');

    await _createDefaultEventPriority(db);

    await db.execute('''
    CREATE TABLE $eventTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_name TEXT,
            start_date TEXT,
            end_date TEXT,
            event_description TEXT,
            is_complete INTEGER DEFAULT 0,
            priority_id INTEGER,
            created_at TEXT,
            FOREIGN KEY (priority_id) REFERENCES $eventPriorityTable(id)
          )
      ''');

    await db.execute('''
      CREATE TABLE $attendeesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        attendee_name TEXT,
        event_id INTEGER,
        is_blacklisted INTEGER DEFAULT 0,
        created_at TEXT,
        FOREIGN KEY (event_id) REFERENCES $eventTable(id) ON DELETE CASCADE
      )
    ''');
  }

  List<PriorityModel> get eventPriorities => [
    PriorityModel(id: 1, priority_name: 'low', created_at: formattedDate),
    PriorityModel(id: 2, priority_name: 'medium', created_at: formattedDate),
    PriorityModel(id: 3, priority_name: 'high', created_at: formattedDate),
  ];

  Future<void> _createDefaultEventPriority(Database database) async {
    for (var priority in eventPriorities) {
      await database.insert(eventPriorityTable, priority.toMap());
    }
  }
}
