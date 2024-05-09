class Employees{
  final String name;
  final String age ;
 final String salary;
   final int id;

  Employees({required this.name,required this.age,required this.salary,required this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'salary': salary,
      'age': age,
    };
  }
}