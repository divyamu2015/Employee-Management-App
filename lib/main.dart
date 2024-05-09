import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//import 'screens/employee_list.dart';
import 'screens/splash_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark)
      ),
      home:const SplashScreen(),
    );
  
  
    
  }
}