import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final Function onTap;
  const EmployeeCard({Key key, this.employee, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Text('${employee.name}'),
      ),
    );
  }
}
