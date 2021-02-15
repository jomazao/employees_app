import 'package:employees_app/src/ui/screens/employee_details_screen.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_card.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeListBloc()..loadEmployees(),
      child: Builder(
        builder: (context) {
          final bloc = context.watch<EmployeeListBloc>();

          return Scaffold(
            body: ListView(
              children: bloc.employees
                  .map((e) => EmployeeCard(
                        employee: e,
                        onTap: () => Navigator.pushNamed(
                            context, EmployeeDetailsScreen.routeName,
                            arguments: e),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
