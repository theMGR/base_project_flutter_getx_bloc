import 'package:flutter/material.dart';
import 'package:project/core/utils/print_utils.dart';

enum StepsPageType { TYPE_STATELESS_WIDGET, TYPE_STATEFUL_WIDGET }

enum StepPageNumber {
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX,
  SEVEN,
  EIGHT,
  NINE,
  TEN,
  ELEVEN,
  TWELVE,
  THIRTEEN,
  FOURTEEN,
  FIFTEEN,
  SIXTEEN,
  SEVENTEEN,
  EIGHTEEN,
  NINETEEN,
  TWENTY
}

// start EmptyStateless
class EmptyStateless extends StatelessWidget {
  const EmptyStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center, child: Text("Empty Stateless"));
  }
}
// end EmptyStateless

// start EmptyStateful
class EmptyStateful extends StatefulWidget {
  const EmptyStateful({Key? key}) : super(key: key);

  @override
  _EmptyStatefulState createState() => _EmptyStatefulState();
}

class _EmptyStatefulState extends State<EmptyStateful> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center, child: Text("Empty Stateful"));
  }
}

// end EmptyStateful

class StepsPage extends StatelessWidget {
  final StepsPageType stepsPageType;
  final StatelessWidget statelessWidget;
  final StatefulWidget statefulWidget;
  final String pageTitle;
  final Color pageTitleColour;
  final Color pageIndicatorColour;

  StepsPage(
      {Key? key,
      this.pageTitle = "",
      this.stepsPageType = StepsPageType.TYPE_STATELESS_WIDGET,
      this.statelessWidget = const EmptyStateless(),
      this.statefulWidget = const EmptyStateful(),
      this.pageTitleColour = Colors.black,
      this.pageIndicatorColour = Colors.black45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.stepsPageType == StepsPageType.TYPE_STATELESS_WIDGET) {
      return _content(this.statelessWidget);
    } else if (this.stepsPageType == StepsPageType.TYPE_STATEFUL_WIDGET) {
      return _content(this.statefulWidget);
    } else {
      return Container();
    }
  }

  Widget _content(Widget widget) {
    String pageTitleText = pageTitle.trim().length > 0 ? pageTitle : "";

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 48,
          child: Row(
            children: [
              Text(pageTitleText, style: TextStyle(color: pageTitleColour, fontSize: 20, fontWeight: FontWeight.w500), maxLines: 1),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Divider(
                        color: pageIndicatorColour,
                        thickness: 2,
                      )))
            ],
          ),
        ),
        Expanded(child: widget)
      ],
    );
  }
}

class StepsPager2 extends StatefulWidget {
  final List<StepsPage> listWidgets;
  final List<Widget> actions;
  final String appBarTitle;

  const StepsPager2({Key? key, this.listWidgets = const [], this.actions = const [], this.appBarTitle = ""}) : super(key: key);

  @override
  StepsPagerState2 createState() => StepsPagerState2(listWidgets: listWidgets, actions: actions, appBarTitle: appBarTitle);
}

class StepsPagerState2 extends State<StepsPager2> {
  final List<Widget> actions;
  final String appBarTitle;

  final List<StepsPage> listWidgets;

  PageController _pageController = PageController();

  int _currentIndex = 0;

  StepsPagerState2({
    required this.listWidgets,
    required this.actions,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (listWidgets.isNotEmpty) {
      return _content(context);
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          'No Pages available',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }

  Widget _content(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        if (_currentIndex == 0) {
          return true;
        } else {
          _onBackClicked();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle.isNotEmpty ? appBarTitle : 'Step Page'),
          actions: actions.isNotEmpty ? actions : <Widget>[Container()],
        ),
        body: Container(
          height: double.infinity,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: listWidgets,
            scrollDirection: Axis.horizontal,
            // reverse: true,
            // physics: BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                Print.Reference("page index :-> $_currentIndex");
              });
            },
          ),
        ),
      ),
    );
  }

  void _onNextClicked(int index) {
    Print.Reference("onNext given input index :..:--> $index");
    if (index >= 0 && index < listWidgets.length) {
      _currentIndex = index;
      Print.Reference("onNext index :..:--> $_currentIndex");
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
    }
  }

  void onNextClicked() {
    Print.Reference("onNext index before increment:..:--> $_currentIndex");
    ++_currentIndex;
    Print.Reference("onNext index after increment:..:--> $_currentIndex");
    if (_currentIndex >= 0 && _currentIndex < listWidgets.length) {
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
    }
  }

  void _onBackClicked() {
    Print.Reference("onBack index :..:--> $_currentIndex");
    _pageController.animateToPage(--_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }
}
