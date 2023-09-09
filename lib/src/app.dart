import 'package:auau_gerador/src/cubit/dogs_cubit.dart';
import 'package:auau_gerador/src/data/model/cachorros_model.dart';
import 'package:auau_gerador/src/pages/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final cachorros = CachorrosModel();
    return MaterialApp(
      title: 'Dogs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          )),
      home: BlocProvider(
        create: (context) => DogsCubit(cachorros: cachorros)..getDog(),
        child: const HomePage(),
      ),
    );
  }
}
