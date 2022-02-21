import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_cubit.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_state.dart';

class LeaderboardsScreen extends StatefulWidget {
  const LeaderboardsScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  final _refreshController = RefreshController();

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
            if (state.submissionStatus.isSubmissionSuccess) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () =>
                  context.read<LeaderboardsCubit>().getLeaderboards(),
              enablePullDown: true,
              header: const WaterDropHeader(),
              child: state.leaderboards.isEmpty
                  ? const Center(child: Text('No Current Leaderboards'))
                  : SizedBox(
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
                    ),
            );
          },
        ),
      ),
    );
  }
}
