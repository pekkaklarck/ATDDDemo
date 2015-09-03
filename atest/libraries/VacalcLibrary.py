import os
import tempfile

from vacalc.employeestore import EmployeeStore


def get_employee_names():
    default_db = os.path.join(tempfile.gettempdir(), 'vacalcdb.csv')
    db_file = os.environ.get('VACALC_DB', default_db)
    return [emp.name for emp in EmployeeStore(db_file).get_all_employees()]


def application_should_have_employees(expected):
    expected = [name.strip() for name in expected.split(',')]
    actual = get_employee_names()
    if actual != expected:
        raise AssertionError('Expected employees: %s\nActual employees: %s'
                             % (', '.join(expected), ', '.join(actual)))
