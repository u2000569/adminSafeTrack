class SRoutes{
  static const login = '/login';
  static const forgetPassword = '/forgetPassword';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const media = '/media';
  static const user = '/user';
  //student
  static const student = '/student';
  static const addStudent = '/addStudent';
  static const editStudent = '/editStudent';
  static const studentDetail = '/studentDetail';

  //teacher
  static const teacher = '/teacher';
  static const addTeacher = '/addTeacher';
  static const editTeacher = '/editTeacher';

  //parent
  static const parent = '/parent';
  static const addParent = '/addParent';
  static const editParent = '/editParent';

  //grade
  static const grade = '/grade';
  static const createGrade = '/create_grade';

  static const settings = '/settings';
  static const profile = '/profile';

  static List sideMenuItems = [
    login,
    forgetPassword,
    dashboard,
    media,
    settings,
    profile,
    grade,
    teacher,
    student,
    parent
  ];
}