import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/presentation/screen/main_screen/bloc/main_screen_imports.dart';
import 'package:cache_storage_demo/presentation/screen/main_screen/widgets/d_b_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

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
    final resultNotifier =
        blocOf(context).realmCacheStorageNotifier?.resultNotifier;
    return srObserver(
      context: context,
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox.expand(
          child: blocConsumer(
            builder: (state) => Column(
              children: [
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onHive(context),
                  title: 'Hive CE',
                  timeInfo: state.hive,
                ),
                const SizedBox(height: 20),
                DBInfo(
                  onPressed: () => _onHiveNoJson(context),
                  title: 'Hive CE no JSON',
                  timeInfo: state.hiveNoJson,
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
                const SizedBox(height: 20),
                if (resultNotifier != null)
                  ValueListenableBuilder<Result<ProductEntity>?>(
                    valueListenable: resultNotifier,
                    builder: (context, result, child) {
                      if (result == null) {
                        return DBInfo(
                          onPressed: () => _onRealmVN(context),
                          title: 'Realm VN',
                          timeInfo: 'N/A',
                        );
                      }
                      if (result.isError) {
                        return Center(
                          child: Text('Error: ${result.asError.error}'),
                        );
                      }
                      if (result.isOk) {
                        final data = result.data;
                        logger.i('resultNotifier data: $data');
                        return DBInfo(
                          onPressed: () => _onRealmVN(context),
                          title: 'Realm VN',
                          timeInfo: state.realmVN,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                else
                  DBInfo(
                    onPressed: () => _onRealmVN(context),
                    title: 'Realm VN',
                    timeInfo: 'N/A',
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

  void _onHiveNoJson(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.hiveNoJsonCall());
  }

  void _onRealmVN(BuildContext context) {
    blocOf(context).add(const MainScreenEvent.realmVNCall());
  }
}
