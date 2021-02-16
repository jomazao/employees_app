import 'package:employees_app/src/config/app_colors.dart';
import 'package:employees_app/src/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final Function onTap;
  final bool justName;

  const EmployeeCard({
    Key key,
    this.employee,
    this.onTap,
    this.justName = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = new NumberFormat("\$#,##0", "es_CO");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 80, maxHeight: 90),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!justName)
              ColoredBox(
                color: employee.isNew ? AppColors.palePink : AppColors.blue,
                child: SizedBox(
                  width: 10,
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        '${employee.name}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    if (!justName)
                      Expanded(
                        flex: 4,
                        child: Text(
                          '${currencyFormat.format(
                            employee.wage,
                          )}',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.right,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
