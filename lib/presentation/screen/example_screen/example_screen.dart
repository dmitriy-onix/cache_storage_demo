import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/domain/usecase/get_product_use_case.dart';
import 'package:cache_storage_demo/presentation/screen/example_screen/bloc/example_screen_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends BaseState<ExampleScreenState,
    ExampleScreenBloc, ExampleScreenSR, ExampleScreen> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _onGetProduct(context),
                child: const Text('Get product'),
              ),
              const SizedBox(width: 10),
              BlocSelector<ExampleScreenBloc, ExampleScreenState, String>(
                selector: (state) => state.hive,
                builder: (context, timeInfo) {
                  return Text(timeInfo);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              BlocSelector<ExampleScreenBloc, ExampleScreenState,
                  ProductEntity?>(
                selector: (state) => state.product,
                builder: (context, product) {
                  if (product == null) {
                    return const Text('No product data');
                  }
                  return Flexible(child: Text(product.toString()));
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  @override
  ExampleScreenBloc createBloc() => ExampleScreenBloc(
        getProductUseCase: GetIt.I.get<GetProductUseCase>(),
      );

  @override
  void onFailure(BuildContext context, Exception failure) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(failure.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    super.onFailure(context, failure);
  }

  void _onGetProduct(BuildContext context) {
    blocOf(context).add(const ExampleScreenEvent.hiveCall());
  }
}
