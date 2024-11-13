import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/app_update_info.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/app_github/app_update_info.dart';

void main() {
  group('fromJson', () {
    test(
      'returns correctly',
      () => expect(
        AppUpdateInfo.fromJson(
          const {
            'tag_name': 'v1.0.0',
            'body': '- Initial release.',
          },
        ),
        const AppUpdateInfo(
          tagName: 'v1.0.0',
          body: '- Initial release.',
        ),
      ),
    );

    test(
      'throws TypeError if key is not found.',
      () {
        expect(
          () => AppUpdateInfo.fromJson(
            const {'body': '- Initial release.'},
          ),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'toString',
              "type 'Null' is not a subtype of type 'String' in type cast",
            ),
          ),
        );
        expect(
          () => AppUpdateInfo.fromJson(
            const {
              'tag_name': 'v1.0.0',
            },
          ),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'toString',
              "type 'Null' is not a subtype of type 'String' in type cast",
            ),
          ),
        );
      },
    );

    test(
      'throws TypeError if value is wrong type.',
      () {
        expect(
          () => AppUpdateInfo.fromJson(
            const {
              'tag_name': 1,
              'body': '- Initial release.',
            },
          ),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'toString',
              "type 'int' is not a subtype of type 'String' in type cast",
            ),
          ),
        );
        expect(
          () => AppUpdateInfo.fromJson(
            const {
              'tag_name': 'v1.0.0',
              'body': 1,
            },
          ),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'toString',
              "type 'int' is not a subtype of type 'String' in type cast",
            ),
          ),
        );
      },
    );

    group('toDomain', () {
      test(
        'returns correctly.',
        () => expect(
          const AppUpdateInfo(
            tagName: 'v1.0.0',
            body: '- Initial release.',
          ).toDomain(),
          const domain.AppUpdateInfo(
            version: '1.0.0',
            releaseNotes: '- Initial release.',
          ),
        ),
      );
    });
  });
}
