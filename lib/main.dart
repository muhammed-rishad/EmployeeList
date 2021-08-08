import 'dart:convert';
import 'package:employee_directry_application/models/employee.dart';
import 'package:employee_directry_application/provider/employee_provider.dart';
import 'package:employee_directry_application/screens/employee_details.dart';
import 'package:employee_directry_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>EmployeeProvider(),
      child: MaterialApp(

        home:HomePage(),
      ),
    );
  }
}


