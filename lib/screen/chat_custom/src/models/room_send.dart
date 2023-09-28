import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// A class that represents a date header between messages.
@immutable
class RoomSend extends Equatable {
  /// Creates a date header.
  const RoomSend({
    this.id,
    this.motelId,
    this.phoneNumber,
    this.title,
    this.motelName,
    this.area,
    this.capacity,
    this.sex,
    this.money,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.addressDetail,
    this.images,
    this.adminVerified,
    this.isFavorite,
    this.totalViews,
    this.hostRank,
  });

  final int? id;
  final int? motelId;
  final String? phoneNumber;
  final String? title;
  final String? motelName;
  final int? area;
  final int? capacity;
  final int? sex;
  final int? money;
  final String? provinceName;
  final String? districtName;
  final String? wardsName;
  final String? addressDetail;
  final List<String>? images;
  final bool? adminVerified;
  final bool? isFavorite;
  final int? totalViews;
  final int? hostRank;

  /// Equatable props.
  @override
  List<Object> get props => [id!];
}
