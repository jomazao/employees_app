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
            appBar: AppBar(
              title: TextFormField(
                onChanged: (text) => bloc.filterByName(text),
                decoration: InputDecoration(
                    hintText: 'Buscar',
                    suffixIcon: Icon(
                      Icons.person_search,
                    )),
              ),
            ),
            body: ListView(
              children: bloc.filteredEmployees
                  .map((e) => EmployeeCard(
                        employee: e,
                        onTap: () => Navigator.pushNamed(
                            context, EmployeeDetailsScreen.routeName,
                            arguments: e),
                      ))
                  .toList(),
            ),
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                    heroTag: 'asc',
                    child: Icon(Icons.arrow_upward),
                    onPressed: () => bloc.sortBySalary()),
                SizedBox(
                  width: 2,
                ),
                FloatingActionButton(
                    heroTag: 'desc',
                    child: Icon(Icons.arrow_downward),
                    onPressed: () => bloc.sortBySalary(upward: false))
              ],
            ),
          );
        },
      ),
    );
  }
}
