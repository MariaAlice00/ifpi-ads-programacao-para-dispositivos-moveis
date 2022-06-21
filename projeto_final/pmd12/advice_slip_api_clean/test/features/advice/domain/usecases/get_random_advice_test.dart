import 'package:advice_slip_api_clean/core/usecases/usecase.dart';
import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:advice_slip_api_clean/features/advice/domain/repositories/advice_repository.dart';
import 'package:advice_slip_api_clean/features/advice/domain/usecases/get_random_advice.dart';
import 'package:dartz/dartz.dart';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAdviceRepository extends Mock
    implements AdviceRepository {}

void main() {
  late MockAdviceRepository mockAdviceRepository;
  late GetRandomAdvice usecase;

  setUp(() {
    mockAdviceRepository = MockAdviceRepository();
    usecase = GetRandomAdvice(mockAdviceRepository);
  });

  final tAdvice = Advice(id: 1, advice: 'Be honest!');

  test(
    'should get advice from the repository',
    () async {
      when(mockAdviceRepository.getRandomAdvice()).thenAnswer((_) async => Right(tAdvice));
      
      final result = await usecase(NoParams());

      expect(result, Right(tAdvice));
      verify(mockAdviceRepository.getRandomAdvice());
      verifyNoMoreInteractions(mockAdviceRepository);
    },
  );
}