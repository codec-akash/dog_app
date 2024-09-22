import 'package:collection/collection.dart';
import 'package:dog_app/bloc/dog_bloc/dog_bloc.dart';
import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/model/dog_breed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogCard extends StatefulWidget {
  final DogBreed dogBreed;
  const DogCard({super.key, required this.dogBreed});

  @override
  State<DogCard> createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        key: ValueKey(widget.dogBreed.breedName),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dogBreed.breedName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (widget.dogBreed.subBreeds.isNotEmpty) ...[
                  RotatedBox(
                    quarterTurns: isExpanded ? 1 : 3,
                    child: const Icon(Icons.chevron_left),
                  ),
                ],
              ],
            ),
            if (isExpanded) ...[
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.dogBreed.subBreeds
                          .mapIndexed(
                            (index, subBreed) => SubBreedCard(
                              index: index,
                              subBreed: subBreed,
                              key: ValueKey(subBreed),
                            ),
                          )
                          .toList(),
                    ],
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

class SubBreedCard extends StatefulWidget {
  final int index;
  final String subBreed;
  const SubBreedCard({super.key, required this.index, required this.subBreed});

  @override
  State<SubBreedCard> createState() => _SubBreedCardState();
}

class _SubBreedCardState extends State<SubBreedCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DogBloc>().add(LoadDogImage(name: widget.subBreed));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.index + 1}: ${widget.subBreed}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
