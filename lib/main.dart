import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel/home.dart';
import 'RoomS.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'hotel',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
      theme: ThemeData.dark(),
      routes: {
        'home': (context) => home(),
        //'room': (context) => Room(),
      },
    );
  }
}
