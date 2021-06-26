import 'package:flutter/material.dart';
import 'package:movieapp/base/base_bloc.dart';
import 'package:provider/provider.dart';

class BaseProviderBloc<T extends BaseBloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BaseProviderBloc({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  @override
  _BaseProviderBlocState createState() => _BaseProviderBlocState<T>();
}

class _BaseProviderBlocState<T extends BaseBloc>
    extends State<BaseProviderBloc> {
  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (BuildContext context) {
        return widget.bloc;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    print("${widget.bloc.runtimeType} is dispose");
    super.dispose();
  }
}
