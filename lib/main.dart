import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(App());

List<String> tasks = [];
final Color c = Color(0xFF212121);
final Color d = Colors.white;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REDGINGGER',
      theme: ThemeData(
        scaffoldBackgroundColor: d,
        primaryColor: c,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String tsk;
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: 'L',
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: SvgPicture.asset(
                  'assets/lg.svg',
                  color: c,
                ),
              ))),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: c,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
          )),
      Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller,
                onChanged: (t) {
                  tsk = t;
                },
                onSubmitted: (t) {
                  tasks.add(tsk);
                  _controller.clear();
                },
                decoration: InputDecoration(
                    prefixText: "  ",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          tasks.add(tsk);
                          _controller.clear();
                        }),
                    fillColor: d,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)))),
              ))),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 75.0),
              child: FlatButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TasksList())),
                  child: Text(
                    "SHOW MY TASKS",
                    style: TextStyle(fontSize: 20.0, color: d),
                  ))))
    ]));
  }
}

class TasksList extends StatefulWidget {
  TasksList({Key key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Stack(children: <Widget>[
        Container(
          color: d,
          height: MediaQuery.of(context).size.height / 8 + 32,
        ),
        Column(children: <Widget>[
          Container(
            child: Hero(
                tag: 'L',
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(
                    'assets/lg.svg',
                    color: c,
                  ),
                )),
            color: d,
            height: MediaQuery.of(context).size.height / 8,
          ),
          Container(
            color: c,
            height: 2,
          )
        ]),
        Positioned(
            left: MediaQuery.of(context).size.width / 4 * 3,
            top: MediaQuery.of(context).size.height / 8 - 29,
            child: CircleAvatar(
              backgroundColor: c,
              radius: 30.0,
            ))
      ]),
      Flexible(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: tasks.isEmpty
                  ? Text("NO TASKS")
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, i) => ListTile(
                          trailing: IconButton(
                              icon: Icon(Icons.done),
                              onPressed: () => setState(() {
                                    tasks.removeAt(i);
                                  })),
                          title: Text(tasks[i])))))
    ]));
  }
}
