import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_cubit.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_state.dart';

class LeaderboardsScreen extends StatelessWidget {
  const LeaderboardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboards'),
      ),
      body: BlocProvider(
        create: (context) => getIt<LeaderboardsCubit>()..getLeaderboards(),
        child: BlocConsumer<LeaderboardsCubit, LeaderboardState>(
          listener: (context, state) {
            if (state.submissionStatus.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Cannot get leaderboards'),
                ));
            }
          },
          builder: (context, state) {
            if (state.submissionStatus.isSubmissionInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.submissionStatus.isSubmissionSuccess) {
              if (state.leaderboards.isEmpty) {
                return const Center(
                  child: Text('No Current Leaderboards'),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: state.leaderboards.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final user = state.leaderboards[index];
                    return Card(
                      child: ListTile(
                        title: Text('$index ${user.name}'),
                        subtitle: Text(user.email),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
