import 'package:employee_directry_application/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                TextField(
                  controller: searchController,
                ),
                FlatButton(onPressed:(){
                  if(searchController.text==null){
                    final snackBar = SnackBar(
                      content: const Text('Yay! A SnackBar!'),
                    );
                  }else{
                    context.read<EmployeeProvider>().serchEmployee(searchController.value.text);
                  }
                }, child: Text('Search'))
              ],
            ),
          ],
        ),

      ),
    );
  }
}
