import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({Key key, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${employee.name}'),
    );
  }
}
