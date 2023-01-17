import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {}

abstract class BaseMVVMState<T extends StatefulWidget, VM extends BaseViewModel>
    extends BaseState<T> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => buildViewModel(),
        child: Consumer<VM>(
          builder: (ctx, vm, _) {
            return buildChild(ctx, vm);
          },
        ));
  }

  VM buildViewModel();

  Widget buildChild(ctx, VM vm);
}

abstract class BaseViewModel extends ChangeNotifier {}
