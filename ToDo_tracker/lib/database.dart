import 'package:hive/hive.dart';

class ToDoData {

  List todo = [];

  final _mybox = Hive.box('mybox');

  void initialrun(){
    todo = [["Go for a run", false]];
  }

  void load(){
    todo = _mybox.get("TODO");
  }

  void update(){
    _mybox.put("TODO",todo);
  }

}