import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, this.index});

  final int? index;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var task = Hive.box('Taskaty');
  var doneTask = Hive.box('DoneTasks');
  @override
  void initState() {
    super.initState();

    if (widget.index != null ) {
      var taskData = Hive.box("Taskaty").getAt(widget.index!);
      taskController.text = taskData["task"];
      descriptionController.text = taskData["description"];
      dateController.text = taskData["date"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Task"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Task title is required";
                  }
                  return null;
                },
                controller: taskController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Enter task title",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Task description is required";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Enter task description",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Task date is required";
                  }
                  return null;
                },
                controller: dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Enter task date",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.index != null) {
                      Hive.box("Taskaty").putAt(
                        widget.index!,
                        {
                          "task": taskController.text,
                          "description": descriptionController.text,
                          "date": dateController.text,
                          "completed": false,
                        },
                      );
                    } else {
                      var data = {
                        "task": taskController.text,
                        "description": descriptionController.text,
                        "date": dateController.text,
                        "completed": false,
                      };

                      task.add(data);
                    }

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}