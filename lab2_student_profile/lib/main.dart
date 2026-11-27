/*lab 2
angelo_monterroyo
jose_michael_paredes
karl_pelinia
bscs 3-1
*/

import 'package:material_ui/material_ui.dart';
void main() {
  runApp(const MyApp());
}

//main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF206B45),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAF8),
      ),
      home: const StudentProfilePage(),
    );
  }
}

// student profile
class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  // student info
  final String studentName = 'Angelo M. Monterroyo';
  final String age = '21 years old';
  final String course = 'Bachelor of Computer Science';
  final String yearSection = '3rd Year - BSCS 3-1';
  final String aboutMe =
      'I am a student who loves to sleep all day';
  final String achievements =
      'With Honors from Grade 9 to 12, Full-Scholar';
  final String skills =
      'Sleeping, Reading, Designing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text(
          'Student Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF206B45),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // main content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F2E9),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: [

                  // avatar
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFFB8D8C4),
                    child: Icon(
                      Icons.person,
                      size: 38,
                      color: Color(0xFF206B45),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // student name and course
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF206B45),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '$course • $yearSection',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // name
            ProfileField(
              label: 'Name',
              value: studentName,
            ),

            // age
            ProfileField(
              label: 'Age',
              value: age,
            ),

            // course / year / section
            ProfileField(
              label: 'Course/Year/Section',
              value: '$course / $yearSection',
            ),

            // about me
            ProfileField(
              label: 'About me',
              value: aboutMe,
            ),

            // achievements
            ProfileField(
              label: 'Achievements',
              value: achievements,
            ),

            // skills
            ProfileField(
              label: 'Skills',
              value: skills,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable widget for displaying student information
class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Field Label
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF206B45),
            ),
          ),

          const SizedBox(height: 4),

          // Field Value
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
