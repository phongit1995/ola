.class public Lchat/ola/vn/pickercontacts/b;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/pickercontacts/f;",
        "Ljava/lang/Void;",
        "Landroid/graphics/Bitmap;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/pickercontacts/f;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Lchat/ola/vn/pickercontacts/f;)Landroid/graphics/Bitmap;
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    aget-object p1, p1, v0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_0

    :try_start_1
    sget-object p1, Landroid/provider/ContactsContract$Contacts;->CONTENT_URI:Landroid/net/Uri;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/f;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {p1, v2, v3}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object p1

    const-string v0, "photo"

    invoke-static {p1, v0}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v2, "r"

    invoke-virtual {v0, p1, v2}, Landroid/content/ContentResolver;->openAssetFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/AssetFileDescriptor;->createInputStream()Ljava/io/FileInputStream;

    move-result-object p1

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-object p1

    :catch_0
    :cond_0
    return-object v1
.end method

.method protected a(Landroid/graphics/Bitmap;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/f;->a()Ljava/lang/ref/WeakReference;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;

    invoke-virtual {v1}, Lchat/ola/vn/pickercontacts/f;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/pickercontacts/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    invoke-virtual {v2, v1, p1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/b;->a:Lchat/ola/vn/pickercontacts/f;

    invoke-virtual {v1}, Lchat/ola/vn/pickercontacts/f;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Lchat/ola/vn/pickercontacts/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/b;->a([Lchat/ola/vn/pickercontacts/f;)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Landroid/graphics/Bitmap;

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/b;->a(Landroid/graphics/Bitmap;)V

    return-void
.end method
