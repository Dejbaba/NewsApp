import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/view_models/base_model.dart';
import 'package:scoped_model/scoped_model.dart';


import '../../service_locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T>
  _builder; // Create a read-only ScopedModelDescendantBuilder
  final Function(T) onModelReady;

  BaseView({ScopedModelDescendantBuilder<T> builder, this.onModelReady})
      : _builder = builder;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T _model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(
            child: Container(color: Colors.red), builder: widget._builder));
  }
}
