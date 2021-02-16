import 'package:employees_app/src/config/app_colors.dart';
import 'package:employees_app/src/ui/screens/employee_details_screen/employee_details_screen.dart';
import 'package:employees_app/src/ui/screens/employee_list_screen/employee_list_bloc.dart';
import 'package:employees_app/src/ui/widgets/employee_card.dart';
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
                title: bloc.searching
                    ? Row(
                        children: [
                          InkWell(
                              onTap: bloc.disableSearch,
                              child: Icon(
                                Icons.arrow_back,
                                color: AppColors.green,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: TextFormField(
                                onChanged: (text) => bloc.filterByName(text),
                                decoration: InputDecoration(
                                    hintText: 'Buscar por nombre',
                                    suffixIcon: Icon(
                                      Icons.person_search,
                                      color: AppColors.green,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Empleados',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: bloc.enableSearch,
                            child: Icon(
                              Icons.search_outlined,
                            ),
                          ),
                        ],
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
                                context,
                                EmployeeDetailsScreen.routeName,
                                arguments: e,
                              ),
                            ))
                        .toList(),
                  ),
                  newEmployees.isNotEmpty
                      ? ListView(
                          children: newEmployees
                              .map((e) => EmployeeCard(
                                    employee: e,
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
                      child: Image.asset(
                        'assets/desc.png',
                        height: 50,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Ordenando por menor salario'),
                          duration: Duration(milliseconds: 1500),
                        ));
                        bloc.sortBySalary();
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  FloatingActionButton(
                      heroTag: 'desc',
                      child: Image.asset(
                        'assets/asc.png',
                        height: 50,
                      ),
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
