import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertest/tap.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;

  late AnimationController _controller;
  late Animation<double> _animation;
  late bool viewChip = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  void _incrementCounter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
    _controller.forward().then((value) => {_stateChange()});
  }

  void _stateChange() {
    setState(() {
      viewChip = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/back.jpg'), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (build, child) {
                return Transform.translate(
                  offset: Offset(
                      0.0,
                      (1 - _animation.value) *
                              (MediaQuery.of(context).size.height / 4) +
                          (MediaQuery.of(context).size.height / 4)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _animation.value * 5,
                      sigmaY: _animation.value * 5,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 100,
                        width: 200,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              },
            ),
            if (viewChip)
              Positioned(
                top: (MediaQuery.of(context).size.height / 4) * 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    spacing: 2.0,
                    children: [
                      InputChip(
                        label: Text('aaa'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TapApp(
                                        title: 'aaa',
                                      )));
                        },
                      ),
                      InputChip(
                        label: Text('dialog'),
                        onPressed: () {
                          showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                                return AleatDialogSimple();
                              });
                        },
                      ),
                      _buildChip("#test12312"),
                      _buildChip("#test1"),
                      _buildChip("#test"),
                      _buildChip("#test12412"),
                      _buildChip("#test"),
                      _buildChip("#test"),
                      _buildChip("test4144"),
                      _buildChip("test11111111111111"),
                      _buildChip("test"),
                      _buildChip("test"),
                      _buildChip("test"),
                      _buildChip("test"),
                      _buildChip("test"),
                      _buildChip("test"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: Colors.orange,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(20))),
      label: Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}

class AleatDialogSimple extends StatelessWidget {
  const AleatDialogSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return AlertDialog(
    //   title: Text('test'),
    //   content: Text('text'),
    // );
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: AlertDialog(
        title: Text('test'),
        content: Text('text'),
        actions: [
          GestureDetector(
            child: Text('OK'),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
