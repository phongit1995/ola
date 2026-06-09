.class public Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Landroid/content/Context;",
        "Ljava/lang/Void;",
        "Ljava/util/List<",
        "Lchat/ola/vn/pickercontacts/c;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;


# direct methods
.method public constructor <init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/content/Context;)Ljava/util/List;
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;"
        }
    .end annotation

    move-object/from16 v1, p1

    const/4 v2, 0x0

    if-eqz v1, :cond_7

    array-length v3, v1

    if-nez v3, :cond_0

    return-object v2

    :cond_0
    const/4 v3, 0x0

    aget-object v1, v1, v3

    if-nez v1, :cond_1

    return-object v2

    :cond_1
    :try_start_0
    sget-object v10, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    const/4 v4, 0x3

    new-array v6, v4, [Ljava/lang/String;

    const-string v4, "contact_id"

    aput-object v4, v6, v3

    const/4 v4, 0x1

    const-string v5, "display_name"

    aput-object v5, v6, v4

    const/4 v4, 0x2

    const-string v5, "starred"

    aput-object v5, v6, v4

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v5, v10

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v11

    if-eqz v11, :cond_7

    const-string v4, "display_name"

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v12

    const-string v4, "contact_id"

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v13

    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {v11}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v4

    if-eqz v4, :cond_6

    :goto_0
    new-instance v15, Lchat/ola/vn/pickercontacts/c;

    invoke-direct {v15}, Lchat/ola/vn/pickercontacts/c;-><init>()V

    invoke-interface {v11, v12}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v11, v13}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v5

    invoke-virtual {v15, v5, v6}, Lchat/ola/vn/pickercontacts/c;->a(J)V

    invoke-virtual {v15, v4}, Lchat/ola/vn/pickercontacts/c;->a(Ljava/lang/String;)V

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const/4 v7, 0x0

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "contact_id = "

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v8, 0x0

    const/16 v16, 0x0

    move-object v5, v10

    move-object v6, v7

    move-object v7, v3

    move-object v3, v9

    move-object/from16 v9, v16

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v4

    invoke-interface {v4}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v5

    if-eqz v5, :cond_4

    move-object v5, v2

    :cond_2
    const-string v6, "data1"

    invoke-interface {v4, v6}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {v4, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    const-string v7, "is_primary"

    invoke-interface {v4, v7}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v7

    invoke-interface {v4, v7}, Landroid/database/Cursor;->getInt(I)I

    move-result v7

    if-lez v7, :cond_3

    move-object v5, v6

    :cond_3
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v6

    if-nez v6, :cond_2

    goto :goto_1

    :cond_4
    move-object v5, v2

    :goto_1
    invoke-virtual {v15, v5}, Lchat/ola/vn/pickercontacts/c;->b(Ljava/lang/String;)V

    invoke-virtual {v15, v3}, Lchat/ola/vn/pickercontacts/c;->a(Ljava/util/List;)V

    invoke-interface {v14, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v11}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-nez v3, :cond_5

    goto :goto_2

    :cond_5
    const/4 v3, 0x0

    goto :goto_0

    :cond_6
    :goto_2
    invoke-interface {v11}, Landroid/database/Cursor;->close()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v14

    :catch_0
    move-exception v0

    move-object v1, v0

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_7
    return-object v2
.end method

.method protected a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {v0, v1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {v1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->c(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/pickercontacts/h;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/h;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->a(Ljava/util/List;)V

    return-void
.end method
