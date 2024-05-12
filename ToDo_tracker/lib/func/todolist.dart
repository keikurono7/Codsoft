import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  final String task;
  final bool done;
  final Function(bool?)? onChanged;
  final void Function()? deltodo;
  final void Function()? edtodo;

  ToDoList({
    super.key,
    required this.task,
    required this.done,
    this.onChanged,
    this.deltodo,
    this.edtodo
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: done ? Colors.grey: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 15),
              child: Row(
                children: [
                  Checkbox(
                      value: done,
                      onChanged: onChanged,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                  ),
                  Flexible(
                      child: Text(
                          task,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                          )
                      )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 50,
                  child: IconButton(
                    color: done ? Colors.white: Colors.black,
                    onPressed: edtodo,
                    icon: const Icon(Icons.edit, size: 25,),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: IconButton(
                    color: done ? Colors.white: Colors.black,
                    onPressed: deltodo,
                    icon: const Icon(Icons.delete, size: 25),
                ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
