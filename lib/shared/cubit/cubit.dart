import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/shared/cubit/states.dart';

import '../Network/local/sharedPreferences.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      //  isDark = fromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }
}
