import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'start_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

   @override
  void initState() {
    navigatPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/new-employee.png',
              width: 200,),
              
            ],
          )
          ),
      ));
  }
  Future navigatPage() async{
 await Future.delayed(const Duration(seconds: 3));
  Navigator.push(context, PageTransition(
    child: StartPage(),
     type: PageTransitionType.rotate,
     duration: const Duration(seconds: 2),
     alignment: Alignment.center )
   
  );
 }
}