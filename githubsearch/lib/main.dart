import 'package:flutter/material.dart';
import 'package:githubsearch/provider/home_provider.dart';
import 'package:githubsearch/shared/constants/theme.dart';
import 'package:githubsearch/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme,
        home: HomeScreen(),
      ),
    );
  }
}
