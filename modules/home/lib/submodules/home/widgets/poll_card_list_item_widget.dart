import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class PollCardListItemWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? date;
  const PollCardListItemWidget(
      {super.key,
      required Size size,
      required this.title,
      required this.description,
      required this.date})
      : _size = size;

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 125,
      decoration: BoxDecoration(
          color: AppColors.kWhite, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _size.width * 0.7,
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.kTitle3(color: AppColors.kBlack),
                ),
              ),
              SizedBox(
                width: _size.width * 0.7,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    text: description,
                    style: AppTextTheme.kBody2(color: AppColors.kBlack),
                  ),
                ),
              ),
              Spacer(),
              Text(
                date!,
                style: AppTextTheme.kBody3(color: AppColors.kBlack),
              )
            ],
          ),
          const Spacer(),
          Container(
              child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.kBlack,
          ))
        ],
      ),
    );
  }
}
