import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/exceptions/remote_database.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/models/database/item.dart';
import 'package:tft_guide/domain/models/database/item_translation.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/item_translation.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note.dart';
import 'package:tft_guide/infrastructure/dtos/supabase/patch_note_translation.dart';

final class SupabaseRepository with LoggerMixin implements RemoteDatabaseApi {
  const SupabaseRepository();

  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<void> initialize() async {
    await Supabase.initialize(
      url: const String.fromEnvironment('url'),
      anonKey: const String.fromEnvironment('anon_key'),
      debug: false,
    );
    logInfo(
      'SupabaseRepository.initialize',
      'Initialized supabase.',
      stackTrace: StackTrace.current,
    );
  }

  @override
  Future<List<String>> loadAssetNames(DateTime? lastUpdated) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadAssetNames';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final assets = await _client.rpc<List<dynamic>>(
        'load_asset_names',
        params: {'last_updated': lastUpdated?.toIso8601String()},
      );
      final assetNames = assets.cast<String>();
      logInfo(
        methodName,
        'Loaded ${assetNames.length} assets.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return assetNames;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<Uint8List> loadAsset(String name) async {
    const methodName = 'SupabaseRepository.loadAsset';
    final parameters = {'name': name};

    try {
      final bytes = await _client.storage.from('assets').download(name);
      logInfo(
        methodName,
        'Loaded asset.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return bytes;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<BaseItemEntity>> loadBaseItems(DateTime? lastUpdated) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadBaseItems';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response =
          await _client.from(_tableNameBaseItem).select().maybeApply(
                lastUpdatedInUtc,
                (query, lastUpdated) => query.gt('updated_at', lastUpdated),
              );
      final items =
          response.map((json) => BaseItem.fromJson(json).toDomain()).toList();
      logInfo(
        methodName,
        'Loaded ${items.length} base items.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return items;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<FullItemEntity>> loadFullItems(DateTime? lastUpdated) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadFullItems';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response =
          await _client.from(_tableNameFullItem).select().maybeApply(
                lastUpdatedInUtc,
                (query, lastUpdated) => query.gt('updated_at', lastUpdated),
              );
      final items =
          response.map((json) => FullItem.fromJson(json).toDomain()).toList();
      logInfo(
        methodName,
        'Loaded ${items.length} full items.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return items;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<PatchNoteEntity>> loadPatchNotes(DateTime? lastUpdated) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadPatchNotes';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response =
          await _client.from(_tableNamePatchNote).select().maybeApply(
                lastUpdatedInUtc,
                (query, lastUpdated) => query.gt('updated_at', lastUpdated),
              );
      final patchNotes =
          response.map((json) => PatchNote.fromJson(json).toDomain()).toList();
      logInfo(
        methodName,
        'Loaded ${patchNotes.length} patch notes.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return patchNotes;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<BaseItemTranslationEntity>> loadBaseItemTranslations(
    DateTime? lastUpdated,
  ) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadBaseItemTranslations';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response =
          await _client.from(_tableNameBaseItemTranslation).select().maybeApply(
                lastUpdatedInUtc,
                (query, lastUpdated) => query.gt('updated_at', lastUpdated),
              );
      final translations = response
          .map((json) => BaseItemTranslation.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded ${translations.length} base item translations.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return translations;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<FullItemTranslationEntity>> loadFullItemTranslations(
    DateTime? lastUpdated,
  ) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadFullItemTranslations';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response =
          await _client.from(_tableNameFullItemTranslation).select().maybeApply(
                lastUpdated,
                (query, lastUpdated) => query.gt('updated_at', lastUpdated),
              );
      final translations = response
          .map((json) => FullItemTranslation.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded ${translations.length} full item translations.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return translations;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<List<PatchNoteTranslationEntity>> loadPatchNoteTranslations(
    DateTime? lastUpdated,
  ) async {
    final lastUpdatedInUtc = lastUpdated?.toUtc();
    const methodName = 'SupabaseRepository.loadPatchNoteTranslations';
    final parameters = {'lastUpdated': lastUpdatedInUtc?.toIso8601String()};

    try {
      final response = await _client
          .from(_tableNamePatchNoteTranslation)
          .select()
          .maybeApply(
            lastUpdated,
            (query, lastUpdated) => query.gt('updated_at', lastUpdated),
          );
      final translations = response
          .map((json) => PatchNoteTranslation.fromJson(json).toDomain())
          .toList();
      logInfo(
        methodName,
        'Loaded ${translations.length} patch notes translations.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );

      return translations;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  @override
  Future<int> loadAssetsCount() async {
    const methodName = 'SupabaseRepository.loadAssetsCount';

    try {
      final count = await _client.rpc<int>('load_assets_count');
      logInfo(
        methodName,
        'Loaded assets count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadBaseItemsCount() async {
    const methodName = 'SupabaseRepository.loadBaseItemsCount';

    try {
      final count = await _client.from(_tableNameBaseItem).count();
      logInfo(
        methodName,
        'Loaded base items count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadFullItemsCount() async {
    const methodName = 'SupabaseRepository.loadFullItemsCount';

    try {
      final count = await _client.from(_tableNameFullItem).count();
      logInfo(
        methodName,
        'Loaded full items count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadPatchNotesCount() async {
    const methodName = 'SupabaseRepository.loadPatchNotesCount';

    try {
      final count = await _client.from(_tableNamePatchNote).count();
      logInfo(
        methodName,
        'Loaded patch notes count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadBaseItemTranslationsCount() async {
    const methodName = 'SupabaseRepository.loadBaseItemTranslationsCount';

    try {
      final count = await _client.from(_tableNameBaseItemTranslation).count();
      logInfo(
        methodName,
        'Loaded base item translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadFullItemTranslationsCount() async {
    const methodName = 'SupabaseRepository.loadFullItemTranslationsCount';

    try {
      final count = await _client.from(_tableNameFullItemTranslation).count();
      logInfo(
        methodName,
        'Loaded full item translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> loadPatchNoteTranslationsCount() async {
    const methodName = 'SupabaseRepository.loadPatchNoteTranslationsCount';

    try {
      final count = await _client.from(_tableNamePatchNoteTranslation).count();
      logInfo(
        methodName,
        'Loaded patch note translations count: $count.',
        stackTrace: StackTrace.current,
      );

      return count;
    } catch (e, stackTrace) {
      _handleException(
        methodName: methodName,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> close() async {
    await _client.dispose();
    logInfo(
      'SupabaseRepository.close',
      'Closed repository.',
      stackTrace: StackTrace.current,
    );
  }

  Never _handleException({
    required String methodName,
    required Object exception,
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) {
    final (loggerException, throwException) = switch (exception) {
      ArgumentError(message: final String message)
          when message.startsWith('No host specified in URI /rest/v1/') =>
        (const InvalidUrlException(), const InvalidUrlException()),
      ArgumentError(message: final String message)
          when message.startsWith(
            'No host specified in URI %3Csupabase-url%3E/rest/v1/',
          ) =>
        (const ExceedUsageLimitException(), const ExceedUsageLimitException()),
      ClientException() => (exception, const NoConnectionException()),
      SocketException() => (exception, const NoConnectionException()),
      PostgrestException(:final code) when code == '42P01' => (
          exception,
          const TableNotFoundException(),
        ),
      PostgrestException(:final code) when code == 'PGRST202' => (
          exception,
          const FunctionNotFoundException(),
        ),
      StorageException(:final statusCode, :final message)
          when statusCode == '404' && message == 'Object not found' =>
        (exception, const AssetNotFoundException()),
      StorageException(:final statusCode, :final message)
          when statusCode == '404' && message == 'Bucket not found' =>
        (exception, const BucketNotFoundException()),
      Error() => throw exception,
      Exception() => (exception, const UnknownException()),
      _ => throw ArgumentError('$exception is not an error or exception'),
    };
    logException(
      methodName,
      exception: loggerException,
      stackTrace: stackTrace,
      parameters: parameters,
    );

    throw throwException;
  }

  static const _tableNameBaseItem = 'base_item';
  static const _tableNameFullItem = 'full_item';
  static const _tableNamePatchNote = 'patch_note';
  static const _tableNameBaseItemTranslation = 'base_item_translation';
  static const _tableNameFullItemTranslation = 'full_item_translation';
  static const _tableNamePatchNoteTranslation = 'patch_note_translation';
}

extension<T> on PostgrestFilterBuilder<T> {
  PostgrestFilterBuilder<T> maybeApply<V>(
    V? value,
    PostgrestFilterBuilder<T> Function(
      PostgrestFilterBuilder<T>,
      V,
    ) apply,
  ) =>
      switch (value) {
        null => this,
        V() => apply(this, value),
      };
}
