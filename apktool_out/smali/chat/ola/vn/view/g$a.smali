.class Lchat/ola/vn/view/g$a;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/g;
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
        "Lchat/ola/vn/entity/i;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/g;


# direct methods
.method private constructor <init>(Lchat/ola/vn/view/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g$a;-><init>(Lchat/ola/vn/view/g;)V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/content/Context;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    aget-object p1, p1, v0

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lchat/ola/vn/entry/ImageEntry;->b:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-string v5, "datetaken DESC"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    invoke-interface {p1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    new-instance v2, Ljava/util/ArrayList;

    const/16 v3, 0x3e8

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/entry/ImageEntry;->a(Landroid/database/Cursor;)Lchat/ola/vn/entry/ImageEntry;

    move-result-object v3

    new-instance v4, Lchat/ola/vn/entity/i;

    invoke-direct {v4}, Lchat/ola/vn/entity/i;-><init>()V

    iget-object v5, v3, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lchat/ola/vn/entity/i;->j(Ljava/lang/String;)V

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lchat/ola/vn/entity/i;->a(S)V

    iget-wide v5, v3, Lchat/ola/vn/entry/ImageEntry;->g:J

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/entity/i;->a(J)V

    iget-object v5, v3, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    invoke-static {v5}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    new-instance v5, Ljava/io/File;

    iget-object v3, v3, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    invoke-direct {v5, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v5}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v5

    const-wide/16 v7, 0x0

    cmp-long v3, v5, v7

    if-lez v3, :cond_1

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    const/4 v5, 0x0

    sub-long v5, v3, v0

    const-wide/16 v3, 0x2710

    cmp-long v7, v5, v3

    if-gtz v7, :cond_2

    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v3, :cond_0

    :cond_2
    return-object v2

    :catch_0
    :cond_3
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-static {v1, v2}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;I)I

    iget-object v1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v1

    invoke-virtual {v1, p1}, Lchat/ola/vn/view/g$c;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->notifyDataSetChanged()V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;Z)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/view/g$a;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Z)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$a;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$a;->a(Ljava/util/List;)V

    return-void
.end method
