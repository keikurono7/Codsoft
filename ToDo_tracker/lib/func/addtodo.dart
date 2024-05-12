import 'package:flutter/material.dart';

class addtodo extends StatelessWidget {
  final controller;
  final VoidCallback save;
  final VoidCallback cancel;

  addtodo ({
    super.key,
    required this.controller,
    required this.save,
    required this.cancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(13),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      content: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                hintText: "Add what to do",
                hintStyle: TextStyle(color: Colors.grey),

              ),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: save,
                    child: const Text("Add", style: TextStyle(color: Colors.white, fontSize: 20),)
                ),
                const SizedBox(
                    width: 10,
                ),
                ElevatedButton(
                    onPressed: cancel,
                    child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20),)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
