import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: non_constant_identifier_names
  List<TODO> Todos = [];
  final TextEditingController _textEditingControllerTitle =
      TextEditingController();
  final TextEditingController _textEditingControllerdescription =
      TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _DaysRequired = TextEditingController();

  @override
  void dispose() {
    _textEditingControllerTitle.dispose();
    _textEditingControllerdescription.dispose();
    super.dispose();
  }

  bool IsEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: Todos.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              onLongPress: () {
                /// Todos[index].isDone = !Todos[index].isDone;
                showDetails(index);
                if (mounted) {
                  setState(() {});
                }
              },
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  myText(context, index.toString(), Colors.black),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              title: myText(
                context,
                Todos[index].Title,
                Color.fromARGB(205, 0, 0, 0),
              ),
              subtitle: myText(
                context,
                Todos[index].Description,
                Color.fromARGB(191, 0, 0, 0),
              ),
              // trailing: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         _textEditingControllerTitle.text = Todos[index].Title;
              //         _textEditingControllerdescription.text =
              //             Todos[index].Description;
              //         _DaysRequired = Todos[index].deadline as TextEditingController;
              //         IsEdit = true;
              //         AddNew(index: index);
              //       },
              //       icon: Icon(Icons.edit),
              //     ),
              //     // IconButton(
              //     //   onPressed: () {
              //     //     Todos.removeAt(index);
              //     //     if (mounted) {
              //     //       setState(() {});
              //     //     }
              //     //   },
              //     //   icon: const Icon(Icons.delete_forever_outlined),
              //     // ),
              //   ],
              // ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 8.0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AddNew();
        },
      ),
    );
  }

  Widget myText(BuildContext context, String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void AddNew({int? index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _titleController = TextEditingController();
        TextEditingController _descriptionController = TextEditingController();
        TextEditingController _daysRequiredController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _daysRequiredController,
                decoration: InputDecoration(
                  hintText: 'Deadline',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();
                final daysRequired = _daysRequiredController.text.trim();

                if (title.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Title cannot be empty.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                if (daysRequired.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Days required cannot be empty.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                if (int.tryParse(daysRequired) == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Days must be a number.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                final newTask = TODO(
                  title,
                  description,
                  daysRequired,
                );

                if (index != null) {
                  Todos.replaceRange(index, index + 1, [newTask]);
                } else {
                  Todos.add(newTask);
                }

                _titleController.clear();
                _descriptionController.clear();
                _daysRequiredController.clear();
                Navigator.pop(context);
                if (mounted) {
                  setState(() {});
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  ////////////details show
  void showDetails(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Task Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title : ${Todos[index].Title}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Description : ${Todos[index].Description}"),
                  Text("Days Required: ${Todos[index].deadline}"),
                  ElevatedButton(
                    onPressed: () {
                      Todos.removeAt(index);
                      Navigator.pop(context);
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TODO {
  // ignore: non_constant_identifier_names
  String Title, Description;
  String deadline;
  TODO(this.Title, this.Description, this.deadline);
}
