import 'package:daily/pack.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<DailyEvent, CategoryState> {
  DailyRepository _locator = locator.get<DailyRepository>();
  @override
  CategoryState get initialState => CategoryInitialState();

  @override
  Stream<CategoryState> mapEventToState(
    DailyEvent event,
  ) async* {
    if (event is FetchAllDailysEventForCategory) {
      yield CategoryLoadingState();
      try {
        var liste = await _locator.getListFromRepositoryForCategories();
        yield CategoryLoadedState(categories: liste);
      } catch (e) {
        throw CategoryErrorState(e: e.toString());
      }
    } else if (event is AddCategoryEvent) {
      _locator.liftCategoryModelToRepo(event.model); //Ekle
      //---Yenile
      var liste = await _locator.getListFromRepositoryForCategories();
      yield CategoryLoadedState(categories: liste);
    } else if (event is DeleteCategoryEvent) {
      await _locator.deleteCategory(event.model); //sil
      //---yenile
      var liste = await _locator.getListFromRepositoryForCategories();
      yield CategoryLoadedState(categories: liste);
    } else if (event is UpdateCategoryEvent) {
      await _locator.updateCategoryModel(event.model);
      //---yenile
      var liste = await _locator.getListFromRepositoryForCategories();
      yield CategoryLoadedState(categories: liste);
    } 
  }
}
