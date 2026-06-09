.class Lchat/ola/vn/view/g$b;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
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

    iput-object p1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g$b;-><init>(Lchat/ola/vn/view/g;)V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/content/Context;)Ljava/util/List;
    .locals 8
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

    sget-object v1, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lchat/ola/vn/entry/VideoEntry;->a:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-string v5, "datetaken DESC"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    invoke-interface {p1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_3

    const/16 v0, 0x3e8

    new-instance v1, Ljava/util/ArrayList;

    const/16 v2, 0x14

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/entry/VideoEntry;->a(Landroid/database/Cursor;)Lchat/ola/vn/entry/VideoEntry;

    move-result-object v2

    iget-wide v3, v2, Lchat/ola/vn/entry/VideoEntry;->d:J

    const-wide/32 v5, 0x300000

    cmp-long v7, v3, v5

    if-ltz v7, :cond_1

    goto :goto_0

    :cond_1
    new-instance v3, Lchat/ola/vn/entity/i;

    invoke-direct {v3}, Lchat/ola/vn/entity/i;-><init>()V

    iget-object v4, v2, Lchat/ola/vn/entry/VideoEntry;->c:Ljava/lang/String;

    invoke-virtual {v3, v4}, Lchat/ola/vn/entity/i;->j(Ljava/lang/String;)V

    const/4 v4, 0x2

    invoke-virtual {v3, v4}, Lchat/ola/vn/entity/i;->a(S)V

    iget-wide v4, v2, Lchat/ola/vn/entry/VideoEntry;->f:J

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/entity/i;->a(J)V

    iget-wide v4, v2, Lchat/ola/vn/entry/VideoEntry;->g:J

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/entity/i;->b(J)V

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-lez v0, :cond_2

    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v2, :cond_0

    :cond_2
    return-object v1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

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

    iget-object v1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-static {v1, v2}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;I)I

    iget-object v1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v1

    invoke-virtual {v1, p1}, Lchat/ola/vn/view/g$c;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->notifyDataSetChanged()V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;Z)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/view/g$b;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, v0}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Z)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$b;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$b;->a(Ljava/util/List;)V

    return-void
.end method
