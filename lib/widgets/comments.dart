import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_comments_model.dart';
import 'package:kbin_mobile/repositories/entry_comments_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'loading_full.dart';

Widget buildCommentList(BuildContext context, int entryId) {
  return FutureBuilder(
    future: (EntryCommentsRepository()).fetchEntryComments(entryId),
    builder: (BuildContext context,
        AsyncSnapshot<List<EntryCommentsItem>> snapshot) {
      if (snapshot.hasData) {
        int index = 0;
        return Container(
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                for (EntryCommentsItem item in snapshot.data!)
                  buildItem(context, item, index++),
              ],
            ));
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(BuildContext context, EntryCommentsItem comment, int index) {
  return Container(
    color: index.isEven
        ? Colors.black.withOpacity(0.03)
    // ? Colors.black.withOpacity(0.15)
        : Colors.transparent,
    padding: const EdgeInsets.only(left:15, right:15, top: 30, bottom: 30),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: comment.user.avatar != null
            ? Image.network(
                Media().getThumbUrl(comment.user.avatar!.filePath),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.person),
      )),
      Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.user.username,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(timeago.format(comment.createdAt, locale: 'pl'),
                  style: const TextStyle(color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(comment.body),
              ),
            ],
          ))
    ]),
  );
}
