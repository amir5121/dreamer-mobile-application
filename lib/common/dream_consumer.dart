import 'package:dreamer/common/request_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamConsumer<T extends RequestNotifier> extends Consumer {
  final bool snackOnError;
  final Widget Function(BuildContext context, T value, Widget child) loadingBuilder;
  final Widget Function(BuildContext context, T value, Widget child) errorBuilder;

  DreamConsumer({
    Key key,
    this.snackOnError = true,
    @required builder,
    this.errorBuilder,
    this.loadingBuilder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, builder: builder, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    T requestNotifier = Provider.of<T>(context);
    if (requestNotifier.hasError && snackOnError) {
      Future<Null>.delayed(
        Duration(),
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 6),
              content: Text(requestNotifier.errorMessage),
            ),
          );
        },
      );
    }
    if (requestNotifier.isLoading && loadingBuilder != null) {
      return loadingBuilder(
        context,
        requestNotifier,
        child,
      );
    }
    if (requestNotifier.hasError && errorBuilder != null) {
      return errorBuilder(
        context,
        requestNotifier,
        child,
      );
    }
    return builder(
      context,
      requestNotifier,
      child,
    );
  }
}

class DreamConsumer2<A extends RequestNotifier, B extends RequestNotifier>
    extends Consumer2 {
  final bool snackOnError;
  final Widget Function(BuildContext context, A value, B value2, Widget child)
      loadingBuilder;
  final Widget Function(BuildContext context, A value, B value2, Widget child)
      errorBuilder;

  DreamConsumer2({
    Key key,
    this.snackOnError = true,
    @required builder,
    this.errorBuilder,
    this.loadingBuilder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, builder: builder, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    A requestNotifier = Provider.of<A>(context);
    B requestNotifier2 = Provider.of<B>(context);
    if ((requestNotifier.hasError || requestNotifier2.hasError) && snackOnError) {
      Future<Null>.delayed(Duration(), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 6),
            content:
                Text("${requestNotifier.errorMessage}. ${requestNotifier2.errorMessage}"),
          ),
        );
      });
    }
    if ((requestNotifier.isLoading || requestNotifier2.isLoading) &&
        loadingBuilder != null) {
      return loadingBuilder(
        context,
        requestNotifier,
        requestNotifier2,
        child,
      );
    }
    if ((requestNotifier.hasError || requestNotifier2.hasError) && errorBuilder != null) {
      return errorBuilder(
        context,
        requestNotifier,
        requestNotifier2,
        child,
      );
    }
    return builder(
      context,
      requestNotifier,
      requestNotifier2,
      child,
    );
  }
}
