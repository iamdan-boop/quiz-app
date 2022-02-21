import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_app/app/bloc/authentication_bloc.dart';
import 'package:quiz_app/app/bloc/authentication_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/leaderboards.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/create.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/quizes.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String user = '';

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  Future<void> getUserName() async {
    final _userName = await const FlutterSecureStorage().read(key: 'user');
    user = _userName ?? user;
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateQuizScreen(),
          ),
        ),
        tooltip: 'quizes',
        child: const Icon(
          Icons.book,
          color: Colors.lightBlueAccent,
        ),
      ),
      body: const QuizesScreen(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaderboardsScreen(),
                ),
              ),
              child: const Text(
                'Leaderboards',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          'Name: $user',
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTap: () => context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested()),
                            text: 'Sign out',
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              child: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.lightBlueAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
