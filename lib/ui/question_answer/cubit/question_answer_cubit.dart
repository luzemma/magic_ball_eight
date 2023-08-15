import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_ball_eight/services/accelerometer_service.dart';

class QuestionAnswerCubit extends Cubit<QuestionAnswerState> {
  QuestionAnswerCubit()
      : _accelerometerService = AccelerometerService(),
        super(const QuestionAnswerState());

  static const _minimum = 15.0;

  void startListen() {
    _accelerometerService.listen().onData(
      (data) {
        if (data.x.abs() > _minimum || data.y.abs() > _minimum) {
          emit(QuestionAnswerState(isInitial: false, x: data.x, y: data.y));
        } else {
          if (!state.isInitial) {
            emit(const QuestionAnswerState(isInitial: false));
          }
        }
      },
    );
  }

  final AccelerometerService _accelerometerService;

  @override
  Future<void> close() {
    _accelerometerService.close();
    return super.close();
  }
}

class QuestionAnswerState extends Equatable {
  const QuestionAnswerState({this.isInitial = true, this.x, this.y});

  final bool isInitial;
  final double? x;
  final double? y;

  @override
  List<Object?> get props => [isInitial, x, y];
}
