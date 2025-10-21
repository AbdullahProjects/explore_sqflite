import 'package:explore_sqflite/helper/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Initialize Database'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var db = await DatabaseHelper.instance.database;
              },
              child: Text("Click Here"),
            ),
            SizedBox(height: 20),

            // Raw SQL Queries
            Text(
              'Raw SQL Queries',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Insert Values Into Table'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                DatabaseHelper db = DatabaseHelper.instance;
                db.insertValueIntoStudentTable();
              },
              child: Text("Click Here"),
            ),
            SizedBox(height: 20),
            Text('Get Student Records'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                DatabaseHelper db = DatabaseHelper.instance;
                db.getAllStudentRecords();
              },
              child: Text("Click Here"),
            ),
            SizedBox(height: 20),
            Text('Update Student Record At ID'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                DatabaseHelper db = DatabaseHelper.instance;
                db.updateStudentRecordById(5);
              },
              child: Text("Click Here"),
            ),
            SizedBox(height: 20),
            Text('Delete All Student Records'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                DatabaseHelper db = DatabaseHelper.instance;
                db.deleteAllStudentRecords();
              },
              child: Text("Click Here"),
            ),

            // SQL Helpers
            SizedBox(height: 20),
            Text(
              'SQL Helper Methods',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
