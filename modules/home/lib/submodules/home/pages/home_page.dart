import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/submodules/home/widgets/poll_card_list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});

  final UserModel? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size get _size => MediaQuery.of(context).size;
  late UserModel? userCache = widget.user;
  String? campaignId;
  TextEditingController campaignNameController = TextEditingController();
  List<PollModel> polls = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case UserCacheLoadedState:
            setState(() {
              userCache = (state as UserCacheLoadedState).user;
            });
            break;
          case CampaignCacheLoadedState:
            setState(() {
              campaignId = (state as CampaignCacheLoadedState).campaignId;
            });
            context
                .read<HomeBloc>()
                .add(GetPollsEvent(campaignId: campaignId!));
            break;
          case PollsLoadedState:
            setState(() {
              polls = (state as PollsLoadedState).polls;
            });
            break;
          default:
        }
      },
      builder: (context, state) {
        if (userCache == null) {
          context.read<HomeBloc>().add(GetUserCacheEvent());
        }
        if (campaignId == null) {
          context.read<HomeBloc>().add(GetCampaignCacheEvent());
        }
        return Scaffold(
          backgroundColor: AppColors.kLightBlue3,
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.kBlue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          userCache?.firstName ?? '',
                          style: AppTextTheme.kTitle3(color: AppColors.kWhite),
                        )
                      ],
                    )),
                const HomeListTile(
                  title: 'Home',
                  selected: true,
                ),
                HomeListTile(
                  title: 'Settings',
                  onTap: () {
                    context.goNamed(AppRoutesName.profile, extra: userCache);
                  },
                ),
                const Spacer(),
                HomeListTile(
                  title: 'Logout',
                  onTap: () {
                    context.read<HomeBloc>().add(LogoutEvent());
                    context.goNamed(AppRoutesName.signIn);
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.kWhite, size: 30),
            backgroundColor: AppColors.kBlue,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      campaignId == null || campaignId!.isEmpty
                          ? 'Your Polls'
                          : 'Your Polls - ${campaignId!}',
                      style: AppTextTheme.kTitle3(color: AppColors.kBlack),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                    title: Text(
                                      'Update Campaign',
                                      style: AppTextTheme.kTitle3(
                                          color: AppColors.kBlack),
                                    ),
                                    content: TextFormField(
                                      controller: campaignNameController,
                                      style: AppTextTheme.kBody1(
                                          color: AppColors.kBlack),
                                      decoration: InputDecoration(
                                        labelText: 'Campaign Name',
                                        labelStyle: AppTextTheme.kBody1(
                                            color: AppColors.kBlack),
                                        fillColor: AppColors.kWhite,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: AppColors.kWhite,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: AppColors.kWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(false),
                                        style: TextButton.styleFrom(
                                          fixedSize: const Size(90, 30),
                                        ),
                                        child: Text('Cancel',
                                            style: AppTextTheme.kBody2(
                                                color: AppColors.kBlue)),
                                      ),
                                      TextButton(
                                        onPressed: () => context.pop(true),
                                        style: TextButton.styleFrom(
                                            fixedSize: const Size(90, 30),
                                            backgroundColor: AppColors.kBlue),
                                        child: Text(
                                          'Save',
                                          style: AppTextTheme.kBody2(
                                              color: AppColors.kWhite),
                                        ),
                                      ),
                                    ],
                                  )).then((value) {
                            setState(() {
                              if (value) {
                                campaignId = campaignNameController.text;
                                context.read<HomeBloc>().add(
                                    UpdateCampaignButtonPressed(
                                        campaignId: campaignId!));
                              }
                            });
                          });
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state is HomeLoading
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (var i = 0; i < 5; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: SkeletonPollCardListItemWidget(
                                size: _size,
                              ),
                            )
                        ],
                      )
                    : polls.isEmpty ? SizedBox(
                      height: _size.height * 0.5,
                      child: Center(
                        child: Text(
                          'No polls found!',
                          style: AppTextTheme.kTitle3(color: AppColors.kBlack),
                        ),
                      ),
                    ) : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: polls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                                onTap: () => context.goNamed('answer-poll',
                                    extra: polls[index]),
                                child: PollCardListItemWidget(
                                    size: _size,
                                    title: polls[index].title,
                                    description: polls[index].description,
                                    date: DateFormat('dd/MM/yyyy')
                                        .format(polls[index].startDate!)
                                        .toString())),
                          );
                        }),
              ],
            ),
          )),
        );
      },
    );
  }
}

class HomeListTile extends StatelessWidget {
  final String? title;
  final bool? selected;
  final void Function()? onTap;

  const HomeListTile(
      {super.key, required this.title, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title!,
        style: AppTextTheme.kTitle3(
            color: selected! ? AppColors.kBlue : AppColors.kBlack,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class SkeletonPollCardListItemWidget extends StatelessWidget {
  const SkeletonPollCardListItemWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.kWhite, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 125,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.kGrey,
                highlightColor: AppColors.kLightGrey,
                child: Container(
                  width: size.width * 0.7,
                  height: 22,
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: AppColors.kGrey,
                highlightColor: AppColors.kLightGrey,
                child: Container(
                  width: size.width * 0.7,
                  height: 14,
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Shimmer.fromColors(
                baseColor: AppColors.kGrey,
                highlightColor: AppColors.kLightGrey,
                child: Container(
                  width: size.width * 0.35,
                  height: 14,
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const Spacer(),
              Shimmer.fromColors(
                baseColor: AppColors.kGrey,
                highlightColor: AppColors.kLightGrey,
                child: Container(
                  width: size.width * 0.2,
                  height: 12,
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: AppColors.kGrey,
            highlightColor: AppColors.kLightGrey,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.kBlack,
            ),
          )
        ],
      ),
    );
  }
}
