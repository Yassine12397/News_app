import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/theme_cubit/themeState.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);
  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }
}
