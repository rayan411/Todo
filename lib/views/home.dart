import 'package:flutter/material.dart';
import '../services/add_todo.dart';
import 'todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "To Do List",
          style:  TextStyle(fontSize: 32),
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTodo();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: PageView(
        children: const [
          Center(
            child: Todos(),
          ),
          Center(),
        ],
      ),
    );
  }
}
