class SampleQuotableModel {
  final int? count;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<SampleQuotableModelResults>? results;

  SampleQuotableModel({this.count, this.totalCount, this.page, this.totalPages, this.results});
}


class SampleQuotableModelResults {
  final String? id;
  final String? author;
  final String? content;
  final String? authorSlug;
  final int? length;
  final String? dateAdded;
  final String? dateModified;

  SampleQuotableModelResults({this.id, this.author, this.content, this.authorSlug, this.length, this.dateAdded, this.dateModified});
}
