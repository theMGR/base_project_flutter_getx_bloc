abstract class Mapper<I, O> {
  O? transform(I? input);

  I? reverse(O? input);

  List<O?>? transformList({List<I?>? inList = const []}) {
    List<O?>? outList = [];
    if(inList != null) {
      for (var input in inList) {
        outList.add(transform(input));
      }
    }
    return outList;
  }

  List<I?>? reverseList({List<O?>? inList = const []}) {
    List<I?>? outList = [];
    if(inList != null) {
      for (var Output in inList) {
        outList.add(reverse(Output));
      }
    }
    return outList;
  }
}
