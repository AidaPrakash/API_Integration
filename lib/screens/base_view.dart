import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pon/core/viewmodels/base_view_model.dart';

import '../locator.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) onModelDisposed;
  BaseView({this.builder, this.onModelReady,this.onModelDisposed});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }
   @override
  void dispose() {
    if (widget.onModelDisposed != null) {
      widget.onModelDisposed(model);
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}

