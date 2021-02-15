import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final Function onTap;
  final bool markNew;
  const EmployeeCard({Key key, this.employee, this.onTap, this.markNew = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Text(
                '${employee.name}',
              ),
            ),
            if (markNew)
              Expanded(
                  flex: 1, child: employee.isNew ? Text('¡New!') : SizedBox())
          ],
        ),
      ),
    );
  }
}
