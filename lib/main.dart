import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  String  getString( {  int a = 0, double b=0.0, bool c = false }){

    return "hello world";

  }*/

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      if(_counter<99.0)
        _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to CST2335',  style:TextStyle(letterSpacing: 5.0,fontSize: 30.0, color:Colors.blue ) ),
            Text('$_counter',  style: Theme.of(context).textTheme.headlineMedium,),

            Image.asset("images/algonquin.jpg", width: 200,height:200),
            Slider(
                min:0,
                value: _counter,
                onChanged: setNewValue,
            max:100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void setNewValue(double value)
  {
    setState(() {
      _counter = value;
    }); //update the GUI to new values

  }
}
