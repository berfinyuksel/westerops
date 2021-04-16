part of 'filters_cubit.dart';

class FiltersState {
  bool? checkboxSortByDistanceValue;
  bool? checkboxFavoritesValue;
  bool? checkboxUserPointValue;
  bool? checkboxNewGuestValue;
  bool? checkboxOnlinePayment;
  bool? checkboxRestaurantPayment;
  bool? checkboxSelectAll;
  bool? checkboxMainCourse;
  bool? checkboxDrinks;
  bool? checkboxVegan;
  bool? checkboxHamburger;
  bool? checkboxDessert;
  bool? checkboxPizza;
  bool? checkboxChicken;
  bool? checkboxCoffe;
  bool? checkboxTakeOutPackage;
  bool? checkboxMotorCourier;
  TextEditingController? textFieldMinValue;
  TextEditingController? textFieldMaxValue;
  double? minValue;
  double? maxValue;
 

  FiltersState(
      {this.checkboxFavoritesValue,
      this.checkboxNewGuestValue,
      this.checkboxSortByDistanceValue,
      this.checkboxUserPointValue,
      this.checkboxRestaurantPayment,
      this.checkboxOnlinePayment,
      this.checkboxSelectAll,
      this.checkboxChicken,
      this.checkboxCoffe,
      this.checkboxDessert,
      this.checkboxDrinks,
      this.checkboxHamburger,
      this.checkboxMainCourse,
      this.checkboxPizza,
      this.checkboxVegan,
      this.checkboxMotorCourier,
      this.checkboxTakeOutPackage,
      this.textFieldMaxValue,
      this.textFieldMinValue,
      this.maxValue,
      this.minValue,
});
}
