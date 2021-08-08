import 'package:employee_directry_application/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/2,
              child: Image.network(context.read<EmployeeProvider>().currentEmployee.profileImage??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text(context.read<EmployeeProvider>().currentEmployee.name??'Name is Null'),
            SizedBox(height: 10,),
            Text(context.read<EmployeeProvider>().currentEmployee.company.name?? 'Company is null')
          ],
        ),
      ),
    );
  }
}
