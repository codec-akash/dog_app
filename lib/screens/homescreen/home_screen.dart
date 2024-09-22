import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_app/bloc/dog_bloc/dog_bloc.dart';
import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/bloc/dog_bloc/dog_state.dart';
import 'package:dog_app/model/dog_breed_model.dart';
import 'package:dog_app/screens/homescreen/dog_card.dart';
import 'package:dog_app/utils/extension_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogListMain extends StatefulWidget {
  const DogListMain({super.key});

  @override
  State<DogListMain> createState() => _DogListMainState();
}

class _DogListMainState extends State<DogListMain> {
  DogBreeds? dogBreeds;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dogBreeds = context.read<DogBloc>().dogBreeds;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Dog List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocListener<DogBloc, DogBlocState>(
              listener: (context, state) {
                if (state is DogImageLoaded) {
                  context.removeSnackBar();
                  showBottomSheet(
                    context: context,
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(),
                    builder: (context) => Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: CachedNetworkImage(
                              imageUrl: state.dogImage,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, val) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is DogStateFailed &&
                    state.currentEvent is LoadDogImage) {
                  context.removeSnackBar();
                  context.showSnackBar(state.errorMsg);
                }
              },
              child: Container(),
            ),
            const SizedBox(height: 10),
            if (dogBreeds != null) ...[
              Expanded(
                child: ListView.separated(
                  itemCount: dogBreeds!.breeds.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) => DogCard(
                    dogBreed: dogBreeds!.breeds[index],
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
