import 'package:employees_app/src/config/app_colors.dart';
import 'package:employees_app/src/models/employee.dart';
import 'package:employees_app/src/ui/screens/employee_details_screen/employee_details_bloc.dart';
import 'package:employees_app/src/ui/widgets/employee_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final Employee _employee = ModalRoute.of(context).settings.arguments;
    final currencyFormat = new NumberFormat("\$#,##0", "es_CO");
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      create: (_) => EmployeeDetailsBloc(_employee),
      child: Builder(builder: (context) {
        final bloc = context.watch<EmployeeDetailsBloc>();
        final employee = bloc.employee;
        return Scaffold(
          appBar: AppBar(
            title: Text('Detalle'),
          ),
          key: _scaffoldKey,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/profile.png'),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height *
                                              0.3),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackGreen,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Switch(
                                        activeColor: AppColors.palePink,
                                        value: employee.isNew,
                                        onChanged: (value) {
                                          bloc.changeNew();
                                          _scaffoldKey.currentState
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                value
                                                    ? 'Marcado como nuevo empleado'
                                                    : 'Desmarcado como nuevo empleado',
                                              ),
                                              duration:
                                                  Duration(milliseconds: 1700),
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        '¡Nuevo!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      employee.name,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        employee.position,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 3,
                            child: Text(
                              currencyFormat.format(
                                employee.wage,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (employee.employees.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        'Este empleado no tiene personal a su cargo',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Personal a cargo',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                if (employee.employees.isNotEmpty)
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: employee.employees
                          .map((e) => EmployeeCard(
                                employee: e,
                                justName: true,
                                onTap: () {},
                              ))
                          .toList(),
                    ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
