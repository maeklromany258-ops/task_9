import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:task_9/theme_contorller.dart';


import 'add_task.dart';
import 'done_task.dart';


class Home extends StatefulWidget {
  final ThemeController themeController;

  const Home({super.key, required this.themeController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoneTasks()),
              ).then((value) {
                setState(() {});
              });
            },
          ),
          IconButton(onPressed: () {
            widget.themeController.toggleTheme();
          }, icon: Icon(CupertinoIcons.moon)),
        ],
        title: const Text("Tasty"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Task added successfully",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              );
              setState(() {});
            });
          },
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Add Task",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(width: 10),
              Icon(Icons.add, color: Colors.white, size: 30),
            ],
          ),
        ),
      ),
      body: (Hive.box("Taskaty").isEmpty)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "No tasks found",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: Hive.box("Taskaty").length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Checkbox(
                value:
                Hive.box("Taskaty").getAt(index)["completed"] ??
                    false,
                onChanged: (value) {
                  Hive.box("Taskaty").putAt(index, {
                    ...Hive.box("Taskaty").getAt(index),
                    "completed": value,
                  });
                  setState(() {});
                  if (value == true) {
                    Hive.box(
                      "DoneTasks",
                    ).add(Hive.box("Taskaty").getAt(index));
                    Hive.box("Taskaty").deleteAt(index);
                  }
                },
              ),
              title: Text(Hive.box("Taskaty").getAt(index)["task"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Hive.box("Taskaty").getAt(index)["description"]),
                  Text(
                    Hive.box("Taskaty").getAt(index)["date"] ?? "No date",
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(index: index),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Hive.box("Taskaty").deleteAt(index);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}