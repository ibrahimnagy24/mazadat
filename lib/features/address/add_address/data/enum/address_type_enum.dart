import '../../../../../core/shared/blocs/main_app_bloc.dart';

enum AddressTypeEnum {
  home,
  office,
}

extension AddressTypeEnumExtension on AddressTypeEnum {
  String get displayName {
    switch (this) {
      case AddressTypeEnum.home:
        return mainAppBloc.isArabic ? 'المنزل' : 'Home';
      case AddressTypeEnum.office:
        return mainAppBloc.isArabic ? 'المكتب' : 'Office';
    }
  }

  String get apiValue {
    switch (this) {
      case AddressTypeEnum.home:
        return 'HOME';
      case AddressTypeEnum.office:
        return 'OFFICE';
    }
  }
}
