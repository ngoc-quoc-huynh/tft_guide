import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/app_update_info.dart' as domain;

final class AppUpdateInfo extends Equatable {
  const AppUpdateInfo({
    required this.tagName,
    required this.body,
  });

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) => AppUpdateInfo(
        tagName: json['tag_name'] as String,
        body: json['body'] as String,
      );

  final String tagName;
  final String body;

  domain.AppUpdateInfo toDomain() => domain.AppUpdateInfo(
        version: tagName.replaceAll('v', ''),
        releaseNotes: body,
      );

  @override
  List<Object?> get props => [
        tagName,
        body,
      ];
}
