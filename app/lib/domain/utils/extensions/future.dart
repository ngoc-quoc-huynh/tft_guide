extension FutureExtension<T> on Future<T> {
  static Future<List<T>> runParallel<T>(
    List<Future<T> Function()> tasks, {
    void Function(int progress)? onProgress,
  }) async {
    int progress = 0;
    bool hasError = false;

    final futures = tasks.map((task) async {
      try {
        final data = await task();
        if (!hasError) {
          onProgress?.call(progress++);
        }
        return data;
      } on Exception {
        hasError = true;
        rethrow;
      }
    });

    return Future.wait(
      futures,
      eagerError: true,
    );
  }
}
