import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final Employee employee = ModalRoute.of(context).settings.arguments;
    final currencyFormat = new NumberFormat("\$#,##0.00", "es_CO");
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
              child: CircleAvatar(
            child: Image.network(
                'https://pickaface.net/gallery/avatar/20121218_023015_4265_employee.png'),
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
            children: employee.employees.map((e) => Text(e.name)).toList(),
          )
        ],
      ),
    );
  }
}
