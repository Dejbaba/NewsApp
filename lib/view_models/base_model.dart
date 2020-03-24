import 'package:news/enums/view_state.dart';
import 'package:scoped_model/scoped_model.dart';


class BaseModel extends Model {
  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState state) {
    _state = state;
    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}
