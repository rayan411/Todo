import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/colors.dart';

class DeleteTodo extends StatefulWidget {
  final String todoId, todoName;

  const DeleteTodo({Key? key, required this.todoId, required this.todoName}) : super(key: key);

  @override
  State<DeleteTodo> createState() => _DeleteTodoState();
}

class _DeleteTodoState extends State<DeleteTodo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Delete Tpdo',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: AppColors.fontColor),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: <Widget>[
              const Text(
                'Are you sure you want to delete this todo?',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Text(
                widget.todoName.toString(),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            deleteTodo();
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.fontColor,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Future deleteTodo() async {
    var collection = FirebaseFirestore.instance.collection('todo');
    collection
        .doc(widget.todoId)
        .delete()
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Task deleted successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
  }
}

