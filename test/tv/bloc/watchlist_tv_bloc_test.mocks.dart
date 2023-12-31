// Mocks generated by Mockito 5.4.2 from annotations
// in tv/test/bloc/watchlist_tv_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/domain/entities/tv.dart' as _i11;
import 'package:core/domain/entities/tv_detail.dart' as _i7;
import 'package:core/domain/repositories/tv_repository.dart' as _i2;
import 'package:core/domain/usecases/get_watchlist_tv.dart' as _i10;
import 'package:core/domain/usecases/get_watchlist_tv_status.dart' as _i9;
import 'package:core/domain/usecases/remove_watchlist_tv.dart' as _i8;
import 'package:core/domain/usecases/save_watchlist_tv.dart' as _i4;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvRepository_0 extends _i1.SmartFake implements _i2.TvRepository {
  _FakeTvRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SaveWatchListTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchListTv extends _i1.Mock implements _i4.SaveWatchListTv {
  MockSaveWatchListTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTv extends _i1.Mock implements _i8.RemoveWatchlistTv {
  MockRemoveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  set repository(_i2.TvRepository? _repository) => super.noSuchMethod(
        Invocation.setter(
          #repository,
          _repository,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [GetWatchListTvStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvStatus extends _i1.Mock
    implements _i9.GetWatchListTvStatus {
  MockGetWatchListTvStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchListTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTv extends _i1.Mock implements _i10.GetWatchListTv {
  MockGetWatchListTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i11.TV>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i11.TV>>>.value(
            _FakeEither_1<_i6.Failure, List<_i11.TV>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i11.TV>>>);
}
