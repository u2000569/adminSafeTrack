import 'package:adminpickready/common/widgets/containers/rounded_container.dart';
import 'package:adminpickready/common/widgets/shimmers/shimmer.dart';
import 'package:adminpickready/features/admin/controllers/student/student_controller.dart';
import 'package:adminpickready/features/admin/models/student_model.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:adminpickready/utils/device/device_utility.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    controller.studentStatus.value = student.status;

    return SRoundedContainer(
      padding: const EdgeInsets.all(SSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Student Information', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(student.formattedAttendanceDate, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                flex: SDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status Attendance'),
                    Obx(
                      () {
                        if (controller.statusLoader.value) return const SShimmer(width: double.infinity, height: 55);
                        return SRoundedContainer(
                          radius: SSizes.cardRadiusSm,
                          padding: const EdgeInsets.symmetric(horizontal: SSizes.sm, vertical: 0),
                          backgroundColor: SHelperFunctions.getStudentStatusColor(controller.studentStatus.value).withOpacity(0.1),
                          child: DropdownButton<StudentStatus>(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            value: controller.studentStatus.value,
                            onChanged: (StudentStatus? newValue){
                              if(newValue != null){
                                controller.updateStudentStatus(student, newValue);
                              }
                            },
                            items: StudentStatus.values.map((StudentStatus status) {
                              return DropdownMenuItem<StudentStatus>(
                                value : status,
                                child: Text(
                                  status.name.capitalize.toString(),
                                  style: TextStyle(color: SHelperFunctions.getStudentStatusColor(controller.studentStatus.value)),
                                ),
                              );
                            },
                          ).toList(),
                          )
                        );
                    }
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}