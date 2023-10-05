import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AnswerPollPage extends StatefulWidget {
  final PollModel poll;
  const AnswerPollPage({super.key, required this.poll});

  @override
  State<AnswerPollPage> createState() => _AnswerPollPageState();
}

class _AnswerPollPageState extends State<AnswerPollPage> {
  Size get _size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);
    return BlocConsumer<AnswerPollBloc, AnswerPollState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AnswerPollLoading:
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog(
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                context: context,
                builder: (context) => Container());

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 10),
              content: Row(
                children: [
                  CircularProgressIndicator(
                    color: AppColors.kWhite,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Loading...',
                    style: AppTextTheme.kBody1(color: AppColors.kWhite),
                  ),
                ],
              ),
              backgroundColor: AppColors.kBlue,
            ));
            break;
          case AnswerPollSuccess:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Poll answered successfully',
                style: AppTextTheme.kBody1(color: AppColors.kWhite),
              ),
              backgroundColor: Colors.green,
            ));
            context.pop();
            break;
          case AnswerPollError:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                (state as SignInError).message,
                style: AppTextTheme.kBody1(color: AppColors.kWhite),
              ),
              backgroundColor: AppColors.kRed,
            ));
            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.kLightBlue3,
            appBar: AppBar(
              title: Text(
                widget.poll.title!,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.kTitle3(color: AppColors.kWhite),
              ),
              iconTheme: IconThemeData(color: AppColors.kWhite, size: 30),
              backgroundColor: AppColors.kBlue,
            ),
            body: SizedBox(
                width: _size.width,
                height: _size.height,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: widget.poll.questions
                      .map((e) => AnswerPollPageItemWidget(
                            size: _size,
                            pollId: widget.poll.id!,
                            question: e,
                            pageController: _pageController,
                            index: widget.poll.questions.indexOf(e),
                            itemCount: widget.poll.questions.length,
                          ))
                      .toList(),
                )));
      },
    );
  }
}

class AnswerPollPageItemWidget extends StatefulWidget {
  AnswerPollPageItemWidget({
    super.key,
    required Size size,
    required this.pollId,
    required this.question,
    required PageController pageController,
    required this.index,
    required this.itemCount,
  })  : _size = size,
        _pageController = pageController;

  final Size _size;
  final String pollId;
  final QuestionModel question;
  final PageController _pageController;
  final int index;
  final int itemCount;

  @override
  State<AnswerPollPageItemWidget> createState() =>
      _AnswerPollPageItemWidgetState();
}

class _AnswerPollPageItemWidgetState extends State<AnswerPollPageItemWidget> {
  late List<bool> selected;

  //InitState
  @override
  void initState() {
    super.initState();
    selected = widget.question.options.map((e) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnswerPollBloc, AnswerPollState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: widget._size.width * 0.9,
            height: widget._size.height * 0.8,
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  widget.question.text!,
                  style: AppTextTheme.kTitle3(color: AppColors.kBlack),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: selected[index]
                                ? AppColors.kLightBlue3
                                : AppColors.kWhite,
                            minimumSize: Size(widget._size.width * 0.9, 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: AppColors.kBlack))),
                        onPressed: () {
                          setState(() {
                            if (widget.question.type == 0) {
                              selected = widget.question.options
                                  .map((e) => false)
                                  .toList();
                            }
                            selected[index] = !selected[index];
                          });
                        },
                        child: SizedBox(
                          width: widget._size.width * 0.8,
                          child: Text(
                            widget.question.options[index].text!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextTheme.kBody1(color: AppColors.kBlack),
                          ),
                        )),
                  ),
                  itemCount: widget.question.options.length,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: widget.index != 0
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    widget.index != 0
                        ? ElevatedButton(
                            onPressed: () {
                              context.read<AnswerPollBloc>().add(
                                  BackButtonPressed());
                              widget._pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kWhite,
                                minimumSize: Size(widget._size.width * 0.3, 40),
                                elevation: 0,
                                side: BorderSide(color: AppColors.kBlue)),
                            child: Text(
                              'Back',
                              style:
                                  AppTextTheme.kBody1(color: AppColors.kBlue),
                            ))
                        : const SizedBox(),
                    ElevatedButton(
                      onPressed: selected.contains(true)
                          ? () {
                              if (widget.itemCount - 1 == widget.index) {
                                context.read<AnswerPollBloc>().add(
                                    FinishButtonPressed(
                                        pollId: widget.pollId,
                                        questionId: widget.question.id!,
                                        text: widget.question.options
                                            .where((element) => selected[widget
                                                .question.options
                                                .indexOf(element)])
                                            .map((e) => e.text!)
                                            .toList()));
                              } else {
                                context.read<AnswerPollBloc>().add(
                                    NextButtonPressed(
                                        questionId: widget.question.id!,
                                        text: widget.question.options
                                            .where((element) => selected[widget
                                                .question.options
                                                .indexOf(element)])
                                            .map((e) => e.text!)
                                            .toList()));
                                widget._pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kBlue,
                          minimumSize: Size(widget._size.width * 0.3, 40),
                          elevation: 0),
                      child: Text(
                        widget.itemCount - 1 == widget.index
                            ? 'Finish'
                            : 'Next',
                        style: AppTextTheme.kBody1(color: AppColors.kWhite),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
