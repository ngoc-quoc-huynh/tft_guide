import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

extension BlocExtension<E, S> on Bloc<E, S> {
  // Debounce incoming request within 300 milliseconds.
  // Only the first event will be handled.
  EventTransformer<Event> debounce<Event>() => (events, mapper) => events
      .debounce(
        const Duration(milliseconds: 300),
        leading: true,
        trailing: false,
      )
      .switchMap(mapper);
}
