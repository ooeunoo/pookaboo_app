import 'package:dartz/dartz.dart';
import 'package:pookaboo/layers/toilet/data/models/route.dart';
import 'package:pookaboo/layers/toilet/data/models/toilet.dart';
import 'package:pookaboo/layers/toilet/domain/entities/get_nearby_toilets_params.dart';
import 'package:pookaboo/layers/toilet/domain/repositories/map_repository.dart';
import 'package:pookaboo/shared/error/failure.dart';
import 'package:pookaboo/shared/usecase/usecase.dart';

////////////////////////////////////////////////
// Get Routes
////////////////////////////////////////////////
class GetRoutesUseCase extends UseCase<GetRouteFormatResponse, GetRouteParams> {
  final MapRepository _repo;

  GetRoutesUseCase(this._repo);

  @override
  Future<Either<Failure, GetRouteFormatResponse>> call(GetRouteParams params) {
    return _repo.getRoutes(params);
  }
}

////////////////////////////////////////////////
// Get Near By Toilet
////////////////////////////////////////////////
class GetNearByToiletsUseCase
    extends UseCase<List<Toilet>, GetNearByToiletsParams> {
  final MapRepository _repo;

  GetNearByToiletsUseCase(this._repo);

  @override
  Future<Either<Failure, List<Toilet>>> call(GetNearByToiletsParams params) {
    return _repo.getNearByToiletsImpl(params);
  }
}

////////////////////////////////////////////////
// Get Toilet By Id
////////////////////////////////////////////////
class GetToiletByIdUseCase extends UseCase<Toilet, int> {
  final MapRepository _repo;

  GetToiletByIdUseCase(this._repo);

  @override
  Future<Either<Failure, Toilet>> call(int params) {
    return _repo.getToiletByIdImpl(params);
  }
}
