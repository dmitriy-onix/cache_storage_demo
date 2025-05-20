//@formatter:off

import 'package:cache_storage_demo/presentation/screen/main_screen/bloc/main_screen_bloc.dart';
import 'package:get_it/get_it.dart';

//{imports end}

void registerBloc(GetIt getIt) {
  getIt.registerFactory<MainScreenBloc>(MainScreenBloc.new);
//{bloc end}
}
