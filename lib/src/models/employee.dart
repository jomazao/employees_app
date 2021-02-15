class Employee {
  int id;
  String name;
  String position;
  int wage;
  List<Employee> employees;

  Employee({
    this.id,
    this.name,
    this.position,
    this.wage,
    this.employees,
  });

  factory Employee.fromMap(Map map) => Employee(
        id: map['id'],
        name: map['name'],
        position: map['position'],
        wage: map['wage'],
        employees: [],
      );
}