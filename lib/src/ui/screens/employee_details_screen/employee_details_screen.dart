import 'package:employees_app/src/models/employee.dart';
import 'package:employees_app/src/ui/screens/employee_details_screen/employee_details_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final Employee _employee = ModalRoute.of(context).settings.arguments;
    final currencyFormat = new NumberFormat("\$#,##0.00", "es_CO");
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      create: (_) => EmployeeDetailsBloc(_employee),
      child: Builder(builder: (context) {
        final bloc = context.watch<EmployeeDetailsBloc>();
        final employee = bloc.employee;
        return Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DrawerHeader(
                    child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.2,
                        child: Image.network(
                            'https://pickaface.net/gallery/avatar/20121218_023015_4265_employee.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Es nuevo'),
                          Switch(
                            value: employee.isNew,
                            onChanged: (value) {
                              bloc.changeNew();
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    value
                                        ? 'Marcado como nuevo empleado'
                                        : 'Desmarcado como nuevo empleado',
                                  ),
                                  duration: Duration(milliseconds: 1700),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(employee.name),
                            Text(employee.position),
                          ],
                        )),
                    Expanded(
                      flex: 3,
                      child: Text(
                        currencyFormat.format(
                          employee.wage,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Column(
                  children:
                      employee.employees.map((e) => Text(e.name)).toList(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
