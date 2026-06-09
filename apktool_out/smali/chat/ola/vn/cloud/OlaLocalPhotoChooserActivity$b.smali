.class Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;
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
        "Lchat/ola/vn/entity/l;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;


# direct methods
.method private constructor <init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)V

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
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    aget-object p1, p1, v0

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lchat/ola/vn/entry/ImageEntry;->a:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-string v5, "datetaken DESC"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x64

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    if-eqz p1, :cond_4

    :catch_0
    :goto_0
    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_3

    new-instance v3, Lchat/ola/vn/entity/l;

    invoke-direct {v3}, Lchat/ola/vn/entity/l;-><init>()V

    const-string v4, "bucket_id"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    iget-object v4, v3, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    const/4 v5, 0x1

    if-nez v4, :cond_1

    const-string v4, "bucket_display_name"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    const-string v4, "_id"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    const-string v4, "_data"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lchat/ola/vn/entity/l;->d:Ljava/lang/String;

    new-instance v4, Lchat/ola/vn/entity/i;

    invoke-direct {v4}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v4, v5}, Lchat/ola/vn/entity/i;->a(S)V

    iget-object v6, v3, Lchat/ola/vn/entity/l;->d:Ljava/lang/String;

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/i;->m(Ljava/lang/String;)V

    const-string v6, "date_modified"

    invoke-interface {p1, v6}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {p1, v6}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Lchat/ola/vn/entity/i;->a(J)V

    iget-object v6, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    if-nez v6, :cond_0

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v6, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    :cond_0
    iget-object v6, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    invoke-interface {v6, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    iput v5, v3, Lchat/ola/vn/entity/l;->g:I

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v3, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object v3, v3, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v3

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/l;

    iget v4, v3, Lchat/ola/vn/entity/l;->g:I

    add-int/2addr v4, v5

    iput v4, v3, Lchat/ola/vn/entity/l;->g:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    const-string v4, "_data"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    new-instance v6, Lchat/ola/vn/entity/i;

    invoke-direct {v6}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/i;->a(S)V

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/i;->m(Ljava/lang/String;)V

    const-string v4, "date_modified"

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {p1, v4}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v4

    invoke-virtual {v6, v4, v5}, Lchat/ola/vn/entity/i;->a(J)V

    iget-object v4, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    if-nez v4, :cond_2

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v4, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    :cond_2
    iget-object v3, v3, Lchat/ola/vn/entity/l;->l:Ljava/util/List;

    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_0

    :cond_3
    :try_start_4
    invoke-interface {p1}, Landroid/database/Cursor;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_4
    return-object v2

    :catch_2
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Ljava/util/List;)Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Ljava/util/List;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b$1;-><init>(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;)V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/b/a;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->f(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;)Lchat/ola/vn/b/a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a:Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->b(Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;Z)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity$b;->a(Ljava/util/List;)V

    return-void
.end method
