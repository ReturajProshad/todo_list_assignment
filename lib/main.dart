import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(Taskmanage());
}

// ignore: must_be_immutable
class Taskmanage extends StatefulWidget {
  bool islight = true;
  Taskmanage({Key? key});

  @override
  State<Taskmanage> createState() => _TaskmanageState();
}

bool iconT = false;
// ignore: non_constant_identifier_names
IconData Darkicon = Icons.night_shelter;
IconData lighticon = Icons.wb_shade;

ThemeData darktheme = ThemeData(
    brightness: Brightness.dark,
    cardTheme: CardTheme(
      color: Colors.amberAccent.withOpacity(.4),
      shadowColor: Colors.red,
      elevation: .2,
    ));

ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    cardTheme: const CardTheme(
      color: Color.fromARGB(142, 21, 38, 224),
    ));

class _TaskmanageState extends State<Taskmanage> {
  // _TaskmanageState({required this.islight});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management",
      // themeMode: ThemeMode.dark,
      theme: iconT ? darktheme : lighttheme,
      // primarySwatch: Colors.amber,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Task Management"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                iconT = !iconT;
                setState(() {});
              },
              icon: Icon(iconT ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: const Homepage(),
      ),
    );
  }
}
