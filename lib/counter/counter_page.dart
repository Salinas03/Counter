import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: CounterView(),
          ),
        ),
      ),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  bool isLimitReached = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterCubit, int>(
      listener: (context, state) {
        if (state == 10 || state == -10) {
          setState(() {
            isLimitReached = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black.withOpacity(0.8),
              content: const Text(
                '¡Límite alcanzado!',
                style: TextStyle(color: Colors.white, fontSize: 8),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          setState(() {
            isLimitReached = false;
          });
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Obtener el ancho disponible para ajustes responsivos
          double availableWidth = constraints.maxWidth;

          // Calculando tamaños proporcionales basados en el ancho disponible
          double titleFontSize = availableWidth * 0.06;
          double buttonIconSize = availableWidth * 0.1; 
          double buttonTextSize = availableWidth * 0.04; 

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contador',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isLimitReached
                    ? null
                    : () => context.read<CounterCubit>().increment(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonIconSize + 20, buttonIconSize + 20),
                ),
                child: Icon(Icons.add, size: buttonIconSize),
              ),
              const SizedBox(height: 5),
              BlocBuilder<CounterCubit, int>(
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isLimitReached
                    ? null
                    : () => context.read<CounterCubit>().decrement(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonIconSize + 20, buttonIconSize + 20),
                ),
                child: Icon(Icons.remove, size: buttonIconSize),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => context.read<CounterCubit>().reset(),
                child: Text('Reiniciar', style: TextStyle(fontSize: buttonTextSize)),
              ),
            ],
          );
        },
      ),
    );
  }
}