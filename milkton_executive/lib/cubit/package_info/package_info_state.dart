part of 'package_info_cubit.dart';

@immutable
sealed class PackageInfoState {}

final class PackageInfoInitial extends PackageInfoState {}

final class PackageInfoFound extends PackageInfoState {
  final PackageInfo packageInfo;

  PackageInfoFound({required this.packageInfo});
}
