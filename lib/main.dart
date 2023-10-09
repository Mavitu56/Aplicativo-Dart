  import 'package:flutter/material.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Press to fill'),
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
    int _counter10=0;
    late AnimationController _animationController;
    late AnimationController _animationController2;
    late Animation<double> _scaleAnimation;
    double _ballSize = 50.0;
  @override
    void initState() {
      super.initState();
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 230),
      );
       _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
      _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_ballSize > 50.0) {
            _animationController.reverse();
          }
        } else if (status == AnimationStatus.dismissed) {
          if (_ballSize < 50.0) {
            _ballSize = 50.0;
          }
        }
      });
    }

    void _incrementCounter() {
      setState(() {
        _counter++;
      if (_counter%10==0) {
        _animateBallWither();
        _counter10++; // Inicia a animação de diminuir a bola
      } else {
        _animateBallGrow(); // Inicia a animação de aumentar a bola
      }
      });
    }
    void _animateBallGrow() {
      _ballSize += 5.0;
      _animationController.forward(from: 0);
    }

    void _animateBallWither() {
    if (_counter%10==0) {
      final animation = Tween<double>(begin: _ballSize, end: 50.0).animate(
        CurvedAnimation(
          parent: _animationController2,
          curve: Curves.easeInOut,
        ),
      );
      animation.addListener(() {
        setState(() {
          _ballSize = animation.value;
        });
      });
      _animationController2.forward(from: 0);
    }
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
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Icon(
                        Icons.sports_soccer,
                        size: _ballSize,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
              const Text(
                'Número de vezes que a bomba foi apertada:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height:100),
            Text(
              'Número de bolas enchidas: $_counter10',
            ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Image.asset('images/bomba_de_ar.png', width: 36.0, height: 36.0), 
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }
