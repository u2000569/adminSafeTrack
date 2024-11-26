import 'package:adminpickready/features/admin/screens/grade/create_grades/create_grade.dart';
import 'package:adminpickready/features/admin/screens/parent/all_parent/parent.dart';
import 'package:adminpickready/features/admin/screens/student/add_student/add_student.dart';
import 'package:adminpickready/features/admin/screens/student/detail_student/detail_student.dart';
import 'package:adminpickready/features/admin/screens/teacher/add_teacher/add_teacher.dart';
import 'package:adminpickready/features/admin/screens/teacher/all_teacher/teacher.dart';
import 'package:adminpickready/features/authentication/screens/forget_password/forget_password.dart';
import 'package:adminpickready/features/authentication/screens/login/login.dart';
import 'package:adminpickready/features/personalization/screens/profile/profile.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:adminpickready/routes/routes_middleware.dart';

// import 'package:adminpickready/screens/teacherscreen.dart';
//import 'package:adminpickready/screens/adminsignin.dart';
import 'package:get/get.dart';
import '../features/admin/screens/dashboard/dashboard.dart';
import '../features/admin/screens/grade/all_grades/grades.dart';
import '../features/admin/screens/parent/add_parent/add_parent.dart';
import '../features/admin/screens/student/all_students/students.dart';
import '../features/admin/screens/student/edit_student/edit_student.dart';
import '../features/personalization/screens/settings/settings.dart';

class SAppRoute{
  static final List<GetPage> pages = [
    GetPage(name: SRoutes.login, page: () => const LoginScreen()),
    //GetPage(name: SRoutes.login, page: () => const AdminSignIn()),
    GetPage(name: SRoutes.dashboard, page: () => const DashboardScreen()),
    GetPage(name: SRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    // GetPage(name: SRoutes.user, page: () =>  const OldTeacherScreen()),

    // Student
    GetPage(name: SRoutes.student, page: () => const StudentScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.addStudent, page: () => const AddStudentScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.editStudent, page: () => const EditStudentScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.studentDetail, page: () => const DetailStudent(), middlewares: [SRouteMiddleware()]),

    // Teacher
    GetPage(name: SRoutes.teacher, page: () => const TeacherScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.addTeacher, page: () => const AddTeacher(), middlewares: [SRouteMiddleware()]),

    // Parent
    GetPage(name: SRoutes.parent, page: () => const ParentScreen(),middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.addParent, page: () => const AddParent(), middlewares: [SRouteMiddleware()]),  

    // Grade @ Class
    GetPage(name: SRoutes.grade, page: () => const GradeScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.createGrade, page: () => const CreateGradeScreen(), middlewares: [SRouteMiddleware()]),

    GetPage(name: SRoutes.settings, page: () => const SettingsScreen(), middlewares: [SRouteMiddleware()]),
    GetPage(name: SRoutes.profile, page: () => const ProfileScreen(), middlewares: [SRouteMiddleware()]),

  ];
}