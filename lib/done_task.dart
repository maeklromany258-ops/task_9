import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'add_task.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({super.key});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Done Tasks"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: Hive.box("DoneTasks").length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Checkbox(
                value:
                Hive.box("DoneTasks").getAt(index)["completed"] ??
                    false,
                onChanged: (value) {
                  Hive.box("DoneTasks").putAt(index, {
                    ...Hive.box("DoneTasks").getAt(index),
                    "completed": value,
                  });
                  setState(() {});
                  if (value == false) {
                    Hive.box("Taskaty").add(Hive.box("DoneTasks").getAt(index));
                    Hive.box("DoneTasks").deleteAt(index);
                  }
                  setState(() {});
                },
              ),
              title: Text(Hive.box("DoneTasks").getAt(index)["task"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Hive.box("DoneTasks").getAt(index)["description"]),
                  Text(
                    Hive.box("DoneTasks").getAt(index)["date"] ?? "No date",
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
                      Hive.box("DoneTasks").deleteAt(index);
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