import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'employee_list.dart';

//import 'login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      Scaffold(
        body: Stack(
            children: [
              Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 8.0
          ),
             child:Container(
              decoration: const BoxDecoration(
               image: DecorationImage(
                image:AssetImage('assets/images/employee.jpg'),
                fit: BoxFit.cover)
              ),
              child: Center(
                child: Column(
                  children: [
                   const Expanded(
                      flex: 1,
                      child: Text('Welcome to Wahni IT Solution Pvt Ltd',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                         OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context, PageTransition(
                            alignment: Alignment.center,
                            type: PageTransitionType.rotate, duration:const Duration(seconds:1), 
                            child: const EmployeeList()));
                      },
                        child:const Text('GetStart',
                    style: TextStyle(
                     color:Colors.white,
                     fontSize: 40.0,
                     fontWeight: FontWeight.bold
                    ),)),

                      ],
                    )
                   
                  
                    
                    
                  ],
                ),
              ),
               ),
              )

            ],
            
              // child: Stack(
              //   children: [
              //     Image.asset('assets/images/screenSplash.jpg')
              //   ],
              //   // child: Center(
              //   //   child: Column(
              //   //     children: [
              //   //       Text('Its time to explore Kerala',
              //   //       style: TextStyle(
              //   //         fontSize: 35,
              //   //       ),
              //   //       textAlign: TextAlign.center,)
              //   //     ],
              //   //   ),
              //   // ),
              // ),
            
          ),
        
      ),
    );
  }
}