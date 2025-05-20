import 'package:cache_storage_demo/presentation/screen/main_screen/bloc/main_screen_imports.dart';
import 'package:cache_storage_demo/presentation/screen/main_screen/widgets/d_b_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreenState, MainScreenBloc,
    MainScreenSR, MainScreen> {
  @override
  Widget buildWidget(BuildContext context) {
    return srObserver(
      context: context,
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox.expand(
          child: blocConsumer(
            builder: (state) => Column(
              children: [
                /*const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _onIsar(context),
                  child: const Text('test Isar'),
                ),*/
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onHive(context),
                  title: 'Hive CE',
                  timeInfo: state.hive,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onObjectBox(context),
                  title: 'ObjectBox',
                  timeInfo: state.objectBox,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onSembast(context),
                  title: 'Sembast',
                  timeInfo: state.sembast,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onDrift(context),
                  title: 'Drift',
                  timeInfo: state.drift,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onFloor(context),
                  title: 'Floor',
                  timeInfo: state.floor,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onRealm(context),
                  title: 'Realm',
                  timeInfo: state.realm,
                ),
              ],
            ),
            listener: (context, state) {},
          ),
        ),
      ),
      onSR: _onSingleResult,
    );
  }

  @override
  MainScreenBloc createBloc() => GetIt.I.get<MainScreenBloc>();

  void _onSingleResult(BuildContext context, MainScreenSR singleResult) {
    switch (singleResult) {
      case LoadFinished():
        break;
    }
  }

  void _onIsar(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.isarCall());
  }

  void _onHive(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.hiveCall());
  }

  void _onObjectBox(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.objectBoxCall());
  }

  void _onSembast(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.sembastCall());
  }

  void _onDrift(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.driftCall());
  }

  void _onFloor(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.floorCall());
  }

  void _onRealm(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.realmCall());
  }
}
