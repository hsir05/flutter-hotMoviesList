import 'package:meta/meta.dart';

/**
 * State中所有属性都应该是只读的
 */
@immutable
class InitState {
  final int _count;
  get count => _count;

  InitState(this._count);

  InitState.initState() : _count = 0;
}
@immutable
class MoviesState {
  List _subjects = [];
  String _title = '';

  get subjects => _subjects;
  get title => _title;
}
/**
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */
enum Action { 
  increment,
  getMoviesData
}

/**
 * reducer会根据传进来的action生成新的CountState
 */
// CountState reducer(CountState state, action) {
//   //匹配Action
//   if (action == Action.increment) {
//     return CountState(state.count + 1);
//   }
//   return state;
// }
InitState reducer(InitState state, action) {
  //匹配Action
  if (action == Action.increment) {
    return InitState(state.count + 1);
  } else if (action == Action.getMoviesData) {
    return InitState(state.title);
  }
  return state;
}




