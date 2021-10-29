// import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:flutter/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp( 
//       // Hide the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Pravin data',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List _items = [];

//   // Fetch content from the json file
//   Future<void> readJson() async {
//     final dynamic response = await rootBundle.loadString('asset/data.json');
//     final data = await json.decode(response);
//     setState(() {
//       _items = data ;
//     });
//     print(_items);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Data',
//         ),
//       ),
//       body: Center(
//           child: Column(
//           children : [
//             // Display the data loaded from sample.json
//             _items.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                       itemCount: _items.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: const EdgeInsets.all(10),
//                           child: Column(
//                             children: [
//                               Text(_items[index]["first_name"] + " " + _items[index]["last_name"]),
//                               Text(_items[index]["username"]),
//                               Text(_items[index].containsKey("status") ? _items[index]["status"] : "N/A")
                                
//                               ],
//                                 )
//                         );
//                       },
//                     ),
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'data:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'All Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List _items = [];

  //Fetch content from json file
  Future<void>readJson()async{
    final dynamic response = await rootBundle.loadString('asset/data.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;
    });
    print(_items[5].containsKey("avatar") );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            //Display data loaded from json file
            _items.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: _items[index].containsKey("avatar") ? NetworkImage(_items[index]["avatar"]) : NetworkImage("https://www.vhv.rs/dpng/d/526-5268314_empty-avatar-png-user-icon-png-transparent-png.png"),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(_items[index]["first_name"] + " " + _items[index]["last_name"]),
                              Text(_items[index]["username"]),
                              Text(_items[index].containsKey("status") ? _items[index]["status"] : "N/A")
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(_items[index]["last_seen_time"])
                            ],
                          ),
                        )
                      ],
                    ),
                    // child: ListTile(
                    //   leading: Text(_items[index]["id"].toString()),
                    //   title: Text(_items[index]["first_name"].toString() + " " + _items[index]["last_name"].toString()),
                    //   subtitle: Text(_items[index]["username"].toString()),
                    //   ),
                  );
                }
              ),
            ) : Container()
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: readJson,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}