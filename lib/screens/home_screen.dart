

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
  List<Employee>empList=[];
  bool isSearch=false;
  TextEditingController searchController=TextEditingController();
  List<Employee>eList;
  getSearchResult(String text){
    empList.clear();
    eList.forEach((element) {
      if(element.name==text){
        empList.add(element);
      }
    });
    return empList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:TextField(
          decoration: new InputDecoration(
            hintText: 'Enter name',
          ),
          controller: searchController,
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
                color: Colors.yellow,
                onPressed: (){
                  setState(() {
                    isSearch=true;
                    getSearchResult(searchController.value.text);
                  });
                }, child: Text('Search')),
          ),

          Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
                color: Colors.red,
                onPressed: (){
                  setState(() {
                    isSearch=false;
                    searchController.clear();

                  });
                }, child: Text('clear')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.all(10),
            //   child: TextField(
            //     decoration: new InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.red, width: 1.0),
            //       ),
            //       hintText: 'Enter name',
            //     ),
            //     controller: searchController,
            //   ),
            // ),
           // Row(
           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
           //   children: [
           //     FlatButton(
           //       color: Colors.blue,
           //       onPressed: (){
           //         setState(() {
           //           isSearch=true;
           //           getSearchResult(searchController.value.text);
           //         });
           //       }, child: Text('Search')),
           //
           //     FlatButton(
           //         color: Colors.blue,
           //         onPressed: (){
           //           setState(() {
           //             isSearch=false;
           //             searchController.clear();
           //
           //           });
           //         }, child: Text('clear')),],
           // ),
            isSearch?empList.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: empList.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    context.read<EmployeeProvider>().setCurrentEmployee(empList[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployeeDetails()),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(empList[index].name??''),
                    ),
                  ),
                );
              },
            ):
                Center(
                  child: Text('No name found'),
                ):
            ListView(
              shrinkWrap: true,
              children: [
                FutureBuilder(
                    future: emp,
                    builder: (context,snapshots){
                      if(snapshots.connectionState==ConnectionState.done){
                        eList=snapshots.data;
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
          ],
        ),
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