import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProviders<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;
  BlocProviders({this.bloc, this.child, Key key}): super(key: key);
  @override
  _BlocProvidersState<T> createState() => _BlocProvidersState<T>();
  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BlocProviders<T>>();
    BlocProviders<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }
  static Type _typeOf<T>() => T;
}

class _BlocProvidersState<T> extends State<BlocProviders<BlocBase>> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
