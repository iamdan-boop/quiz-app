import 'package:equatable/equatable.dart';

abstract class CachedProfileEvent extends Equatable {}

class InsertCacheInfo extends CachedProfileEvent {
  InsertCacheInfo({
    required this.name,
    required this.isAdmin,
  });

  final String name;
  final bool isAdmin;

  @override
  List<Object?> get props => [name, isAdmin];
}
