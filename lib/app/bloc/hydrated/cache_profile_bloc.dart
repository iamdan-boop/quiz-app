import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quiz_app/app/bloc/hydrated/cache_profile_state.dart';
import 'package:quiz_app/app/bloc/hydrated/cached_profile_event.dart';

class CacheProfileBloc
    extends HydratedBloc<CachedProfileEvent, CacheProfileState> {
  CacheProfileBloc() : super(const CacheProfileState()) {
    on<InsertCacheInfo>((event, emit) => emit(
          state.copyWith(name: event.name, isAdmin: event.isAdmin),
        ));
  }

  @override
  CacheProfileState? fromJson(Map<String, dynamic> json) {
    return json['user'] as CacheProfileState;
  }

  @override
  Map<String, dynamic>? toJson(CacheProfileState state) {
    return <String, dynamic>{
      'name': state.name,
      'isAdmin': state.isAdmin,
    };
  }
}
