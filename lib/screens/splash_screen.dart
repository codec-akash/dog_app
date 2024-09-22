import 'package:dog_app/bloc/dog_bloc/dog_bloc.dart';
import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/bloc/dog_bloc/dog_state.dart';
import 'package:dog_app/screens/homescreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DogBloc>().add(const LoadDogList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<DogBloc, DogBlocState>(
            listener: (context, state) {
              if (state is DogListLoaded) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DogListMain()));
              }
            },
            child: Container(),
          ),
          Text(
            "Dog Data Loading...",
          ),
        ],
      ),
    );
  }
}
