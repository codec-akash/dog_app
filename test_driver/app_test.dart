import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/bloc/dog_bloc/dog_bloc.dart';
import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/bloc/dog_bloc/dog_state.dart';
import 'package:dog_app/main.dart';
import 'package:dog_app/model/dog_breed_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await Hive.initFlutter();
    await Hive.openBox('dogBreedsBox');

    await Hive.openBox('breeds');
  });
  group('Bloc Success Scenarios: ', () {
    const homeScreenUrl = 'https://dog.ceo/api/breeds/list/all';
    Map<String, dynamic> data = {
      "message": {"affenpinscher": [], "african": []},
      "status": "success"
    };

    blocTest<DogBloc, DogBlocState>(
      'test case when data is loaded',
      setUp: (() {
        return http.get(Uri.parse(homeScreenUrl));
      }),
      act: (bloc) => bloc.add(LoadDogList()),
      build: () => DogBloc(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const DogStateLoading(currentEvent: LoadDogList()),
        DogListLoaded(DogBreeds(
            breeds: [DogBreed(breedName: "breedName", subBreeds: [])]))
      ],
    );
  });

  testWidgets('check the launch of the app', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(MyApp());

    expect(find.text('Dog Data Loading...'), findsOneWidget);

    await Future.delayed(const Duration(milliseconds: 200));
  });
}
