import 'package:flutter/material.dart';

class OldTeacherScreen extends StatefulWidget {
  const OldTeacherScreen({super.key});

  @override
  State<OldTeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<OldTeacherScreen> {

  final _classNameController = TextEditingController();
  final List<String> _teachers = ['Teacher A', 'Teacher B', 'Teacher C'];
  String? _selectedTeacher;
  final List<Map<String, String>> _students = [];
  final _studentNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _studentAgeController = TextEditingController();
  
  void _addStudent() {
    setState(() {
      _students.add({
        'name': _studentNameController.text,
        'id': _studentIdController.text,
        'age': _studentAgeController.text,
      });
      _studentNameController.clear();
      _studentIdController.clear();
      _studentAgeController.clear();
    });
  }

  void _saveClass() {
    // Here you would send the class data to Firebase.
    print('Class Name: ${_classNameController.text}');
    print('Assigned Teacher: $_selectedTeacher');
    print('Students: $_students');

    // Clear the form
    _classNameController.clear();
    _selectedTeacher = null;
    _students.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _classNameController,
                  decoration: InputDecoration(
                    labelText: 'Class Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                ),
                const SizedBox(height: 16.0,),

                //Teacher Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedTeacher, 
                  decoration: InputDecoration(
                    labelText: 'Assign Teacher',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),
                  items: _teachers.map((teacher){
                    return DropdownMenuItem<String>(
                      value: teacher, 
                      child: Text(teacher)
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      _selectedTeacher = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0,),

                //Student Information Fields

                const Text(
                'Add Student',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),

                TextField(
                  controller: _studentNameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                ),

                const SizedBox(height: 8.0,),

                TextField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                ),

                const SizedBox(height: 8.0,),

                TextField(
                  controller: _studentAgeController,
                  decoration: InputDecoration(
                    labelText: 'Student Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 8.0,),
                ElevatedButton(
                  onPressed: _addStudent, 
                  child: const Text('Add Student')
                ),

                const SizedBox(height: 16.0,),

                //Display add students
                if(_students.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Added Students:',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _students.length,
                      itemBuilder: (context, index){
                        final student = _students[index];
                        return ListTile(
                          title: Text('${student['name']} (ID: ${student['id']})'),
                          subtitle:  Text('Age: ${student['age']}'),
                        );
                      },
                    )
                  ],
                ),

                const SizedBox(height: 16.0,),
                ElevatedButton(
                  onPressed: _saveClass, 
                  child: const Text('Save Class'),
                ),
              ],
            ),
          ),
        ) ,
      ) ,
    );
  }
}