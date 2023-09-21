import 'package:equatable/equatable.dart';

import 'tv_detail_model.dart';

class TVDetailResponse extends Equatable {
  final TVDetailModel tvDetail;

  const TVDetailResponse({required this.tvDetail});

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVDetailResponse(tvDetail: TVDetailModel.fromJson(json));

  Map<String, dynamic> toJson() => tvDetail.toJson();

  @override
  List<Object?> get props => [tvDetail];
}
