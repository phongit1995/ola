.class Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
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
.field final synthetic a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;


# direct methods
.method private constructor <init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V

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

    move-result-object v1

    sget-object v2, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget-object v3, Lchat/ola/vn/entry/VideoEntry;->a:[Ljava/lang/String;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-string v6, "datetaken DESC"

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    invoke-interface {p1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_5

    const/16 v1, 0x2710

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/entry/VideoEntry;->a(Landroid/database/Cursor;)Lchat/ola/vn/entry/VideoEntry;

    move-result-object v3

    iget-wide v4, v3, Lchat/ola/vn/entry/VideoEntry;->d:J

    const-wide/32 v6, 0x300000

    cmp-long v8, v4, v6

    if-ltz v8, :cond_1

    goto :goto_0

    :cond_1
    new-instance v4, Lchat/ola/vn/entity/i;

    invoke-direct {v4}, Lchat/ola/vn/entity/i;-><init>()V

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Lchat/ola/vn/entity/i;->a(S)V

    iget-object v5, v3, Lchat/ola/vn/entry/VideoEntry;->c:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lchat/ola/vn/entity/i;->m(Ljava/lang/String;)V

    iget-wide v5, v3, Lchat/ola/vn/entry/VideoEntry;->f:J

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/entity/i;->a(J)V

    iget-wide v5, v3, Lchat/ola/vn/entry/VideoEntry;->g:J

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/entity/i;->b(J)V

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, -0x1

    :goto_0
    if-lez v1, :cond_2

    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-nez v3, :cond_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    if-nez p1, :cond_4

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/i;

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->m()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/l;->d:Ljava/lang/String;

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p1

    iget v0, p1, Lchat/ola/vn/entity/l;->g:I

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p1, Lchat/ola/vn/entity/l;->g:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    return-object v2

    :catch_0
    :cond_5
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

    if-eqz p1, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/cloud/b;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-interface {v1, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    new-instance p1, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c$1;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;)V

    invoke-static {v1, p1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    if-eqz v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1, v1}, Lchat/ola/vn/cloud/b;->b(Ljava/util/List;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->d(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->b(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Z)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$c;->a(Ljava/util/List;)V

    return-void
.end method
