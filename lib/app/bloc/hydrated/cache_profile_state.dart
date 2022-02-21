import 'package:equatable/equatable.dart';
import 'package:quiz_app/app/bloc/hydrated/cached_profile_event.dart';

class CacheProfileState extends Equatable {
  const CacheProfileState({
    this.name = '',
    this.isAdmin = false,
  });

  CacheProfileState copyWith({
    String? name,
    bool? isAdmin,
  }) {
    return CacheProfileState(
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  final String name;
  final bool isAdmin;

  @override
  List<Object?> get props => [name, isAdmin];
}
