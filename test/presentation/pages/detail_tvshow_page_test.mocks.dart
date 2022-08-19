// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/detail_tvshow_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tvshow.dart' as _i10;
import 'package:ditonton/domain/entities/tvshow_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/get_detail_tvshow.dart' as _i2;
import 'package:ditonton/domain/usecases/get_recommendation_tvshow.dart' as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_byid_tvshow.dart' as _i4;
import 'package:ditonton/domain/usecases/insert_watchlist_tvshow.dart' as _i5;
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart' as _i6;
import 'package:ditonton/presentation/provider/detail_tvshow_notifier.dart'
as _i8;
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

class _FakeGetDetailTvShow_0 extends _i1.SmartFake
    implements _i2.GetDetailTvShow {
  _FakeGetDetailTvShow_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetRecommendationTvShow_1 extends _i1.SmartFake
    implements _i3.GetRecommendationTvShow {
  _FakeGetRecommendationTvShow_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListByIdTvShow_2 extends _i1.SmartFake
    implements _i4.GetWatchListByIdTvShow {
  _FakeGetWatchListByIdTvShow_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeInsertWatchlistTvShow_3 extends _i1.SmartFake
    implements _i5.InsertWatchlistTvShow {
  _FakeInsertWatchlistTvShow_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlistTvShow_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTvShow {
  _FakeRemoveWatchlistTvShow_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvShowDetail_5 extends _i1.SmartFake implements _i7.TvShowDetail {
  _FakeTvShowDetail_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [DetailTvShowNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockDetailTvShowNotifier extends _i1.Mock
    implements _i8.DetailTvShowNotifier {
  MockDetailTvShowNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetDetailTvShow get getDetailTvShow =>
      (super.noSuchMethod(
          Invocation.getter(#getDetailTvShow),
          returnValue:
          _FakeGetDetailTvShow_0(this, Invocation.getter(#getDetailTvShow)))
      as _i2.GetDetailTvShow);

  @override
  _i3.GetRecommendationTvShow get getRecommendationTvShow =>
      (super.noSuchMethod(Invocation.getter(#getRecommendationTvShow),
          returnValue: _FakeGetRecommendationTvShow_1(
              this, Invocation.getter(#getRecommendationTvShow)))
      as _i3.GetRecommendationTvShow);

  @override
  _i4.GetWatchListByIdTvShow get getWatchListByIdTvShow =>
      (super.noSuchMethod(Invocation.getter(#getWatchListByIdTvShow),
          returnValue: _FakeGetWatchListByIdTvShow_2(
              this, Invocation.getter(#getWatchListByIdTvShow)))
      as _i4.GetWatchListByIdTvShow);

  @override
  _i5.InsertWatchlistTvShow get insertWatchlistTvShow =>
      (super.noSuchMethod(Invocation.getter(#insertWatchlistTvShow),
          returnValue: _FakeInsertWatchlistTvShow_3(
              this, Invocation.getter(#insertWatchlistTvShow)))
      as _i5.InsertWatchlistTvShow);

  @override
  _i6.RemoveWatchlistTvShow get removeWatchlistTvShow =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistTvShow),
          returnValue: _FakeRemoveWatchlistTvShow_4(
              this, Invocation.getter(#removeWatchlistTvShow)))
      as _i6.RemoveWatchlistTvShow);

  @override
  _i7.TvShowDetail get detailTvShow =>
      (super.noSuchMethod(Invocation.getter(#detailTvShow),
          returnValue:
          _FakeTvShowDetail_5(this, Invocation.getter(#detailTvShow)))
      as _i7.TvShowDetail);

  @override
  _i9.RequestState get tvShowState =>
      (super.noSuchMethod(Invocation.getter(#tvShowState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);

  @override
  List<_i10.TvShow> get tvShowRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvShowRecommendations),
          returnValue: <_i10.TvShow>[]) as List<_i10.TvShow>);

  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);

  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
      as String);

  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);

  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
      as String);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
      as bool);

  @override
  _i11.Future<void> fetchDetailTvShow(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchDetailTvShow, [id]),
          returnValue: _i11.Future<void>.value(),
          returnValueForMissingStub: _i11.Future<void>.value())
      as _i11.Future<void>);

  @override
  _i11.Future<void> addWatchlist(_i7.TvShowDetail? tvShowDetail) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tvShowDetail]),
          returnValue: _i11.Future<void>.value(),
          returnValueForMissingStub: _i11.Future<void>.value())
      as _i11.Future<void>);

  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvShowDetail? tvShowDetail) =>
      (super.noSuchMethod(
          Invocation.method(#removeFromWatchlist, [tvShowDetail]),
          returnValue: _i11.Future<void>.value(),
          returnValueForMissingStub: _i11.Future<void>.value())
      as _i11.Future<void>);

  @override
  _i11.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValue: _i11.Future<void>.value(),
          returnValueForMissingStub: _i11.Future<void>.value())
      as _i11.Future<void>);

  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);

  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);

  @override
  void dispose() =>
      super.noSuchMethod(Invocation.method(#dispose, []),
          returnValueForMissingStub: null);

  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
