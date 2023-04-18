import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/colors.dart';

class UpdateTodo extends StatefulWidget {
  final String todoId, todoName, todoDesc;

  const UpdateTodo(
      {Key? Key, required this.todoId, required this.todoName, required this.todoDesc})
      : super(key: Key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.todoName;
    taskDescController.text = widget.todoDesc;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32, color: AppColors.fontColor),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.square_list, color:  AppColors.fontColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon:  Icon(CupertinoIcons.bubble_left_bubble_right, color: AppColors.fontColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Row(
              //   children: <Widget>[
              //     const Icon(CupertinoIcons.tag, color: Colors.brown),
              //     const SizedBox(width: 15.0),
              //     Expanded(
              //       child: DropdownButtonFormField2(
              //         decoration: InputDecoration(
              //           isDense: true,
              //           contentPadding: EdgeInsets.zero,
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         isExpanded: true,
              //         value: widget.taskTag,
              //     //    buttonHeight: 60,
              //      //   buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              //       //  dropdownDecoration: BoxDecoration(
              //         //  borderRadius: BorderRadius.circular(15),
              //        // ),
              //         items: taskTags
              //             .map(
              //               (item) => DropdownMenuItem<String>(
              //                 value: item,
              //                 child: Text(
              //                   item,
              //                   style: const TextStyle(
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //               ),
              //             )
              //             .toList(),
              //         onChanged: (String? value) => setState(
              //           () {
              //             if (value != null) selectedValue = value;
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
            final todoName = taskNameController.text;
            final todoDesc = taskDescController.text;
            _updateTasks(todoName, todoDesc);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  Future _updateTasks(String todoName, String todoDesc) async {
    var collection = FirebaseFirestore.instance.collection('todo');
    collection
        .doc(widget.todoId)
        .update({'todoName': todoName, 'todoDesc': todoDesc})
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Todo updated successfully",
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
