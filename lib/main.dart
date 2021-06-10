import 'package:admin/screens/user/home/navigationBar.dart';
import 'package:admin/screens/user/product/product_screen.dart';
import 'package:admin/screens/user/category/category_screen.dart';
import 'package:admin/screens/user/home/home_screen.dart';
import 'package:admin/screens/user/search/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/user/userFunctionality/myaccount_screen.dart';
import 'package:flutter/material.dart';
import 'screens/user/userFunctionality/login_screen.dart';
import 'screens/user/userFunctionality/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        RegisterScreen.roteName: (ctx) => RegisterScreen(),
        MyBottomNavigationBar.roteName: (ctx) => MyBottomNavigationBar(),
        slider1.roteName: (ctx) => slider1(),
        Search.roteName: (ctx) => Search(),
        ViewProduct.roteName: (ctx) => ViewProduct(),
        LoginScreen.roteName: (ctx) => LoginScreen(),
        MyaccountScreen.roteName: (ctx) => MyaccountScreen(),
        CategoryScreen.roteName: (ctx) => CategoryScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
