import 'package:dreamer/common/request_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamConsumer<T extends RequestNotifier> extends Consumer {
  final bool snackOnError;
  final Widget Function(BuildContext context, T value, Widget child)
      loadingBuilder;
  final Widget Function(BuildContext context, T value, Widget child)
      errorBuilder;

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
      Future<Null>.delayed(Duration(), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 6),
            content: Text(requestNotifier.errorMessage),
          ),
        );
      });
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
