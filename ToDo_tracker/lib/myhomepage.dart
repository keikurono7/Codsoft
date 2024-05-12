import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/database.dart';
import 'package:to_do_app/func/addtodo.dart';
import 'func/todolist.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _mybox = Hive.box('mybox');

  ToDoData data = ToDoData();

  @override
  void initState(){
    if(_mybox.get("TODO")==null){
      data.initialrun();
    }else{
      data.load();
    }
    super.initState();
  }

  final _controller  = TextEditingController();

  void appendtodo(){
    setState(() {
      data.todo.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    data.update();
  }

  void createtodo(){
    showDialog(
        context: context,
        builder: (context){
          return addtodo(
            controller: _controller,
            save: appendtodo,
            cancel: () => Navigator.of(context).pop(),
          );
        }
    );
  }

  edittodo(int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(13),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            content: SizedBox(
              height: 130,
              child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey)
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
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: (){
                              setState(() {
                                data.todo[index][0] = _controller.text;
                                _controller.clear();
                                Navigator.of(context).pop();
                              });
                              data.update();
                            },
                            child: const Text("Edit", style: TextStyle(color: Colors.white, fontSize: 20),)
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20),)
                        )
                      ],
                    )
                  ],
              ),
            ),
          );
        }
      );
  }


  deletetodo(int index){
    setState(() {
      data.todo.removeAt(index);
    });
    data.update();
  }

  void toggled(bool? value, int index){
    setState(() {
      data.todo[index][1] = !data.todo[index][1];
    });
    data.update();
  }
  @override
  Widget build(BuildContext context) {
    double count =0;
    int len = data.todo.length;
    for(int i=0; i<len ; i++){
      if(data.todo[i][1]==true)
        count++;
    }
    if(len == 0)
      len=1;
    count = count/len*100;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: createtodo,
          child: const Icon(Icons.edit_note, color: Colors.black, size: 40.0,),
          elevation: 20,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      PieChart(
                          swapAnimationDuration: const Duration(milliseconds: 1000),
                          PieChartData(
                              sections: [
                                PieChartSectionData(
                                    value: 100 - count,
                                    color: Colors.black,
                                    title: ""
                                ),
                                PieChartSectionData(
                                    value: count,
                                    radius: 90,
                                    color: Colors.white,
                                    title: ""
                                ),

                              ]
                          )
                      ),
                      Center(
                        child: Container(
                          height: 165,
                          width: 165,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${count.toStringAsPrecision(3)}%\nCompleted",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              MasonryGridView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: data.todo.length,
                itemBuilder: (context,index){
                  return ToDoList(
                    task: data.todo[index][0],
                    done: data.todo[index][1],
                    onChanged: (value) => toggled(value,index),
                    edtodo: ()=> edittodo(index),
                    deltodo: ()=> deletetodo(index),
                  );
                },
              ),
            ]
        )
    );
  }
}
