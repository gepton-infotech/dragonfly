import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'package_info_state.dart';

class PackageInfoCubit extends Cubit<PackageInfoState> {
  PackageInfoCubit() : super(PackageInfoInitial());

  Future<void> getPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(PackageInfoFound(packageInfo: packageInfo));
  }
}
