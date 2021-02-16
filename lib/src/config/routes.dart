import 'package:employees_app/src/ui/screens/employee_details_screen/employee_details_screen.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_list_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final routes = {
    EmployeeListScreen.routeName: (context)=>
            EmployeeListScreen(),
    EmployeeDetailsScreen.routeName: (context) =>
            EmployeeDetailsScreen(),
  };
}
