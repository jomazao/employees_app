import 'package:employees_app/src/ui/screens/employee_details_screen/employee_details_screen.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_card.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      create: (_) => EmployeeListBloc()..loadEmployees(),
      child: Builder(
        builder: (context) {
          final bloc = context.watch<EmployeeListBloc>();
          final filteredEmployees = bloc.filteredEmployees;
          final newEmployees = filteredEmployees.where((e) => e.isNew);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: TextFormField(
                  onChanged: (text) => bloc.filterByName(text),
                  decoration: InputDecoration(
                      hintText: 'Buscar empleado por nombre',
                      suffixIcon: Icon(
                        Icons.person_search,
                      )),
                ),
                bottom: TabBar(tabs: [
                  Tab(
                    text: 'Todos',
                  ),
                  Tab(text: 'Nuevos')
                ]),
              ),
              body: TabBarView(
                children: [
                  ListView(
                    children: filteredEmployees
                        .map((e) => EmployeeCard(
                              employee: e,
                              onTap: () => Navigator.pushNamed(
                                  context, EmployeeDetailsScreen.routeName,
                                  arguments: e),
                            ))
                        .toList(),
                  ),
                  newEmployees.isNotEmpty
                      ? ListView(
                          children: newEmployees
                              .map((e) => EmployeeCard(
                                    employee: e,
                                    markNew: false,
                                    onTap: () => Navigator.pushNamed(context,
                                        EmployeeDetailsScreen.routeName,
                                        arguments: e),
                                  ))
                              .toList(),
                        )
                      : Center(child: Text('No hay empleados nuevos')),
                ],
              ),
              floatingActionButton: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                      heroTag: 'asc',
                      child: Icon(Icons.arrow_upward),
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Ordenando por menor salario'),
                          duration: Duration(milliseconds: 1500),
                        ));
                        bloc.sortBySalary();
                      }),
                  SizedBox(
                    width: 2,
                  ),
                  FloatingActionButton(
                      heroTag: 'desc',
                      child: Icon(Icons.arrow_downward),
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Ordenando por mayor salario'),
                          duration: Duration(milliseconds: 1500),
                        ));
                        bloc.sortBySalary(upward: false);
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
