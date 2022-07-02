import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Fake Weather App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherHasData) {
                  return Column(
                    key: const Key('weather_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.result.cityName,
                            style: const TextStyle(
                              fontSize: 35.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${(state.result.temperature-273.75).toStringAsPrecision(3)} °C',
                              style: const TextStyle(
                                fontSize: 45.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return const Center(
                    child: Text('Deu algo errado!'),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 32.0
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Coloque o nome da cidade',
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  context.read<WeatherBloc>().add(OnCityChanged(query));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}