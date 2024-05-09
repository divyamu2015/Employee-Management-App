import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/employee_model.dart';

class UpdateEmployee extends StatefulWidget {
  const UpdateEmployee({super.key,required this.id});
  final int id;

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
   
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final int _min = 18;
  final int _max = 70;
   //final int id;
  final double _minSalary = 45000.0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();

  Future<void> updateDatas() async {
  String name = _nameController.text;
  String age = _ageController.text;
  String salary = _salaryController.text;

  Employees updatedEmployee = Employees(
    name: name, age: age, salary: salary, id: 0);

  var url = Uri.parse('https://dummy.restapiexample.com/api/v1/update/');
  var response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      //'id':id,
      'name': updatedEmployee.name,
      'age': updatedEmployee.age,
      'salary': updatedEmployee.salary,
      
    }),
  );


  if (response.statusCode == 200) {
   
    ScaffoldMessenger.of(context).showSnackBar(
    const  SnackBar(
        content: Text('Employee updated successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  } else {
    
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(
        content: Text('Failed to update employee'),
        duration: Duration(seconds: 2), 
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 9, 99),
        title: const Text(
          'Employee List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(children: [
              Stack(children: [
                Image.asset(
                  'assets/images/handshake-01-01.jpg',
                  height: height * 0.40,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: height * 0.50,
                  width: width,
                  // decoration:const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     stops: [0.6,1.0],
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //     Colors.transparent,
                  //     Colors.white
                  //   ])
                  // ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Join Us',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.1)),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter employee name';
                                } else if (value.length < 3) {
                                  return 'Employee Name is too short';
                                } else if (value.length > 20) {
                                  return 'Employee Name is too long';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                labelText: 'Employee Name',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _ageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter employee age';
                          }
                          int age = int.tryParse(value)!;
                          if (age < _min || age > _max) {
                            return 'Age must be between $_min and $_max';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                          labelText: 'Employee Age',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _salaryController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter employee salary';
                          }
                          double salary = double.tryParse(value)!;
                          if (salary < _minSalary) {
                            return 'Salary must be at least $_minSalary';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                          labelText: 'Salary',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                updateDatas();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Update Employee'),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _formkey.currentState!.reset();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Form reset successfully'),
                                  duration:
                                      Duration(seconds: 2), // Adjust as needed
                                ),
                              );
                            },
                            child: const Text('Reset'),
                          )
                        ],
                      )
                    ],
                  ),
                ))
              ]),
            ]),
          ),
        ),
      ),
    ));
  }
}
