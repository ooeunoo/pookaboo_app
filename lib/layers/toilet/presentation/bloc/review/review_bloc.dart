import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pookaboo/layers/toilet/data/models/review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pookaboo/layers/toilet/domain/entities/create_review_params.dart';
import 'package:pookaboo/layers/toilet/domain/usecases/review_usecase.dart';
import 'package:pookaboo/shared/utils/logging/log.dart';

part 'review_state.dart';
part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  /////////////////////////////////
  /// UseCase
  ////////////////////////////////
  final CreateToiletReviewUseCase _createToiletReviewUseCase;
  final GetToiletReviewsByToiletIdUseCase _getToiletReviewsByToiletIdUseCase;
  final GetToiletReviewsByUserIdUseCase _getToiletReviewsByUserIdUseCase;

  /////////////////////////////////
  /// Event Mapping
  ////////////////////////////////
  ReviewBloc(
      this._createToiletReviewUseCase,
      this._getToiletReviewsByToiletIdUseCase,
      this._getToiletReviewsByUserIdUseCase)
      : super(InitialState()) {
    on<CreateToiletReviewEvent>(_onCreateToiletReviewEvent);
    on<GetToiletReviewsByUserIdEvent>(_onGetToiletReviewsByUserIdEvent);
    on<GetToiletReviewsByToiletIdEvent>(_onGetToiletReviewsByToiletIdEvent);
  }

  /////////////////////////////////
  /// Property
  ////////////////////////////////

  /////////////////////////////////
  /// [CreateToiletReviewEvent] Event Handler
  ////////////////////////////////
  Future<void> _onCreateToiletReviewEvent(
      CreateToiletReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      final result = await _createToiletReviewUseCase.call(event.params);
      result.fold((l) {}, (r) {
        if (r) {
          emit(SuccessCreateToiletReviewState());
        }
      });
    } catch (e) {}
  }

  /////////////////////////////////
  /// [GetToiletReviewsByToiletIdEvent] Event Handler
  ////////////////////////////////
  Future<void> _onGetToiletReviewsByToiletIdEvent(
      GetToiletReviewsByToiletIdEvent event, Emitter<ReviewState> emit) async {
    try {
      final response =
          await _getToiletReviewsByToiletIdUseCase.call(event.toiletId);
      response.fold((l) {
        log.e(l);
      }, (r) {
        emit(LoadedToiletReviewsByToiletIdState(reviews: r));
      });
    } catch (e) {}
  }

  /////////////////////////////////
  /// [GetToiletReviewsByUserIdEvent] Event Handler
  ////////////////////////////////
  Future<void> _onGetToiletReviewsByUserIdEvent(
      GetToiletReviewsByUserIdEvent event, Emitter<ReviewState> emit) async {
    try {
      final response =
          await _getToiletReviewsByUserIdUseCase.call(event.userId);
      response.fold((l) {
        log.e(l);
      }, (r) {
        emit(LoadedToiletReviewsByUserIdState(reviews: r));
      });
    } catch (e) {}
  }
}
