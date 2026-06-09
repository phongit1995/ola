.class Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Landroid/content/Context;",
        "Ljava/lang/Void;",
        "Ljava/util/List<",
        "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;


# direct methods
.method private constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/content/Context;)Ljava/util/List;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    aget-object p1, p1, v0

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget-object v4, Lchat/ola/vn/entry/ImageEntry;->b:[Ljava/lang/String;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const-string v7, "datetaken DESC"

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    invoke-interface {p1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    new-instance v0, Ljava/util/ArrayList;

    const/16 v4, 0x3e8

    invoke-direct {v0, v4}, Ljava/util/ArrayList;-><init>(I)V

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/entry/ImageEntry;->a(Landroid/database/Cursor;)Lchat/ola/vn/entry/ImageEntry;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    iget-object v6, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {v5, v6, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;)V

    const/4 v6, 0x1

    iput-short v6, v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    iget-object v6, v4, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    iput-object v6, v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    iget-object v6, v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-static {v6}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    new-instance v6, Ljava/io/File;

    iget-object v7, v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v6}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v10, v6, v8

    if-lez v10, :cond_1

    iget-wide v6, v4, Lchat/ola/vn/entry/ImageEntry;->g:J

    iput-wide v6, v5, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->a:J

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const/4 v6, 0x0

    sub-long v6, v4, v2

    const-wide/16 v4, 0x2710

    cmp-long v8, v6, v4

    if-gtz v8, :cond_2

    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v4, :cond_0

    :cond_2
    return-object v0

    :catch_0
    :cond_3
    return-object v1
.end method

.method protected a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/util/List;)Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a$1;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;)V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->b(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->notifyDataSetChanged()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Z)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$a;->a(Ljava/util/List;)V

    return-void
.end method
