import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/widgets/loading_widget.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

extension BuildAsyncValue<T> on AsyncValue<T> {
  ///
  /// Build the [AsyncValue] when it is ready by just passing the [onData]
  /// You can override [onError] and [onLoading] as well or stick with the
  /// defaults.
  ///
  Widget build(
    Widget Function(T data) onData, {
    Widget Function(Object, StackTrace?)? onError,
    Widget Function()? onLoading,
  }) {
    return when<Widget>(
        data: onData,
        error: onError ??
            ((error, stackTrace) {
              error.logException(stackTrace: stackTrace);
              return const SizedBox.shrink();
            }),
        loading: onLoading ??
            (() {
              return const Center(child: LoadingWidget());
            }));
  }
}
