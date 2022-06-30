// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:advice_slip_api_clean/features/advice/domain/repositories/advice_repository.dart';
import 'package:advice_slip_api_clean/features/advice/domain/usecases/get_concrete_advice.dart.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAdviceRepository extends Mock
    implements AdviceRepository {}

void main() {
  late MockAdviceRepository mockAdviceRepository;
  late GetConcreteAdvice usecase;

  setUp(() {
    mockAdviceRepository = MockAdviceRepository();
    usecase = GetConcreteAdvice(mockAdviceRepository);
  });

  const tId = 1;
  const tAdvice = Advice(id: 1, advice: 'Be honest!');

  test(
    'should get advice for the number from the repository',
    () async {
      when(mockAdviceRepository.getConcreteAdvice(tId))
          .thenAnswer((_) async => Right(tAdvice));

      final result = await usecase.call(Params(number: tId));

      expect(result, Right(tAdvice));
      verify(mockAdviceRepository.getConcreteAdvice(tId));
      verifyNoMoreInteractions(mockAdviceRepository);
    },
  );
}
