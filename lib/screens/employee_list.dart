import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'create_emplo.dart';
import '../model/employee_model.dart';
import 'update_screen.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employees> employees = [];

  @override
  void initState() {
    super.initState();
    getData();
  }


  Future<void> getData() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          List<dynamic> data = responseData['data'];
          setState(() {
            employees = data.map((value) {
              return Employees(
                id: value['id'],
                name: value['employee_name'] as String,
                age: value['employee_age'].toString(),
                salary: value['employee_salary'] .toString(),
              );
            }).toList();
            print('list Length==-=> ${employees.length}');
          });
        } else {
          throw Exception('Data key not found in response');
        }
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error appropriately, e.g., show an error message to the user
    }
  }


  Future<void> deleteEmployee(int id) async {
    try {
      var url = Uri.parse('https://dummy.restapiexample.com/api/v1/delete/$id');
      var response = await http.delete(url);

      print(response);
      print(response.body);

      if (response.statusCode == 200) {
       
        setState(() {
          employees.removeWhere((employee) => employee.id == id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete employee'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error deleting employee: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while deleting employee'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    // double height=MediaQuery.of(context).size.height;
    // double width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 85, 9, 99),
          title: const Text(
            'Employee List',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final id = employees[index].id;
            return Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 5.0, right: 5.0),
              child: Card(
                shadowColor: const Color.fromARGB(255, 110, 109, 109),
                // elevation: 0,
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 35.0,
                  ),
                  title: Text(
                    employees[index].name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${employees[index].age}'),
                      Text('Salary ${employees[index].salary}')
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100, // Adjust the width as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return UpdateEmployee(id: id,);
                                },
                              ));
                            },
                            icon: const Icon(Icons.edit_document)),
                        const SizedBox(width: 3),
                        IconButton(
                            onPressed: () {
                              deleteEmployee(employees[index].id);
                            },
                            icon: const Icon(Icons.delete_forever)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 107, 105, 105),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const AddEmployee();
                },
              ),
            ).then((value) => getData());
          },
          child: const Icon(Icons.add, color: Color.fromARGB(255, 85, 9, 99)),
        ),
      ),
    );
  }
}
