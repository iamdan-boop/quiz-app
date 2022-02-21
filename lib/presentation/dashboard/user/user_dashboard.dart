import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/bloc/authentication_bloc.dart';
import 'package:quiz_app/app/bloc/authentication_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/leaderboards.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/quiz.dart';
import 'package:quiz_app/presentation/dashboard/user/profile/user_profile.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  UserDashboardState createState() => UserDashboardState();
}

class UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LeaderboardsScreen(),
          ),
        ),
        tooltip: 'Leaderboards',
        child: const Icon(
          Icons.person,
          color: Colors.lightBlueAccent,
        ),
      ),
      body: const UserQuizScreen(),
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
                  builder: (context) => const UserProfileScreen(),
                ),
              ),
              child: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
              child: const Text(
                'Logout',
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
