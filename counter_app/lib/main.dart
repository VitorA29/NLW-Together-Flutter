import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  void increment()
  {
    counter++;
    print(counter);
    setState(() {
      
    });
  }

  void subtract()
  {
    counter--;
    print(counter);
    setState(() {
      
    });
  }

  void reset()
  {
    counter = 0;
    print(counter);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Primeiro App"),
      ),
      body: Center(
        child: Text(
          "Contador\n$counter",
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              increment();
            },
          ),SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              subtract();
            },
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.restore),
            onPressed: () {
              reset();
            },
          ),
        ],
      ),
    );
  }
}
