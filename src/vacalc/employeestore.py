import os
import csv
import datetime
import operator


class VacalcError(RuntimeError):
    pass


class EmployeeStore(object):

    def __init__(self, db_file):
        self._db_file = db_file
        if self._db_file and os.path.isfile(self._db_file):
            self._employees = self._read_employees(self._db_file)
        else:
            self._employees = {}

    def _read_employees(self, path):
        employees = {}
        with open(path) as db:
            for row in csv.reader(db):
                employee = Employee(row[0].decode('UTF-8'),
                                    self._parse_date(row[1]))
                employees[employee.name] = employee
        return employees

    def refresh(self):
        self.__init__(self._db_file)

    def get_employee(self, name):
        try:
            return self._employees[name]
        except KeyError:
            raise VacalcError("Employee '%s' not found." % name)

    def get_all_employees(self):
        return sorted(self._employees.values(),
                      key=operator.attrgetter('name'))

    def add_employee(self, name, startdate):
        self._validate_name(name)
        employee = Employee(name, self._parse_date(startdate))
        self._employees[employee.name] = employee
        self._serialize(employee)
        return employee

    def _validate_name(self, name):
        if not name:
            raise VacalcError('No name given.')
        if name in self._employees:
            raise VacalcError("Employee '%s' already exists in the system."
                              % name)

    def _serialize(self, employee):
        if not self._db_file:
            return
        with open(self._db_file, 'a') as db:
            writer = csv.writer(db, lineterminator='\n')
            writer.writerow([employee.name.encode('UTF-8'), employee.startdate])

    def _parse_date(self, datestring):
        if not datestring:
            raise VacalcError('No start date given.')
        try:
            year, month, day = (int(item) for item in datestring.split('-'))
        except ValueError:
            raise VacalcError('Invalid start date.')
        try:
            return datetime.date(year, month, day)
        except ValueError, err:
            raise VacalcError(err.args[0].capitalize() + '.')


class Employee(object):

    def __init__(self, name, startdate):
        self.name = name
        self.startdate = startdate
