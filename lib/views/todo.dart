import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/delete_todo.dart';
import '../services/update_todo.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);
  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final fireStore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('todo').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No todo to display');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Color todoColor = AppColors.blueShadeColor;
                return Container(
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color:AppColors.shadowColor,
                        blurRadius: 5.0,
                        offset: Offset(0, 5), 
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 20,
                      height: 40,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.assignment,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['todoName'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    subtitle: Text(data['todoDesc']),
                    isThreeLine: true,
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: const [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              String todoId = (data['id']);
                              String todoName = (data['todoName']);
                              String todoDesc = (data['todoDesc']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => showDialog(
                                  context: context,
                                  builder: (context) => UpdateTodo(
                                    todoId: todoId,
                                    todoName: todoName,
                                    todoDesc: todoDesc,
                                  ),
                                ),
                              );
                            },
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              String todoId = (data['id']);
                              String todoName = (data['todoName']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => showDialog(
                                  context: context,
                                  builder: (context) => DeleteTodo(
                                      todoId: todoId, todoName: todoName),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                    dense: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
