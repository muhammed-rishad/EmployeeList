
import 'dart:convert';

import 'package:employee_directry_application/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EmployeeProvider extends ChangeNotifier{
   Employee currentEmployee;
   List<Employee>employeeList=[];
   List<Employee>searchResult=[];


   setCurrentEmployee(Employee employee){
     currentEmployee=employee;
   }
   getEmployee() async {

    String uri = 'https://run.mocky.io/v3/bdcdffd7-df4c-4645-8290-d451ea6fe98a';
    var response = await http.get(Uri.parse(uri));
    print("usedCarsResponse" + response.body.toString());
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List<Employee> emp=(items as List).map((li) => Employee.fromJson(li)).toList();
      return emp;

    } else {
      print("exception" + response.body.toString());
      throw Exception('Failed to load internet');
    }
  }
   Future<List<Employee>> serchEmployee(String text) async {
     employeeList.clear();
    if(employeeList.isNotEmpty){
     await getEmployee();
      employeeList.forEach((element) {
        if(element.name==text){
          searchResult.add(element);
        }
      });
      return employeeList;
    }
   }


}
class EnrollStatus {
  static const int IDLE = 0;
  static const int LOADING = 1;
  static const int LOADED = 2;
}
