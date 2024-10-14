import 'package:equatable/equatable.dart';

final class AppUpdateInfo extends Equatable {
  const AppUpdateInfo({
    required this.version,
    required this.releaseNotes,
  });

  final String version;
  final String releaseNotes;

  @override
  List<Object?> get props => [
        version,
        releaseNotes,
      ];
}
