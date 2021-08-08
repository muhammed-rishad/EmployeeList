

import 'package:employee_directry_application/models/employee.dart';
import 'package:employee_directry_application/provider/employee_provider.dart';
import 'package:employee_directry_application/screens/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future <List<Employee>> emp;
  Future<List<Employee>> getEmployee()async{
    List<Employee>empList=await context.read<EmployeeProvider>().getEmployee();
    return empList;
  }

  bool isSearch=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [

          FutureBuilder(
              future: emp,
              builder: (context,snapshots){
                if(snapshots.connectionState==ConnectionState.done){
                  List<Employee>eList=snapshots.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: eList.length,
                      itemBuilder:(context,index){
                        return InkWell(
                          onTap: (){
                            context.read<EmployeeProvider>().setCurrentEmployee(eList[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmployeeDetails()),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(eList[index].name??''),
                            ),
                          ),
                        );
                      });
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emp=getEmployee();
  }
}