.class Lchat/ola/vn/activity/OlaImageCropToolActivity$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageCropToolActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaImageCropToolActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageCropToolActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/String;
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->a(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/graphics/Bitmap;

    move-result-object p1

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->b(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->c(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {v2}, Landroid/graphics/Bitmap$CompressFormat;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {p1, v0}, Lcom/mg/ola/common/d/c;->b(Landroid/graphics/Bitmap;Ljava/io/File;)V

    goto :goto_0

    :cond_1
    invoke-static {p1, v0}, Lcom/mg/ola/common/d/c;->a(Landroid/graphics/Bitmap;Ljava/io/File;)V

    :goto_0
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->a(Lchat/ola/vn/activity/OlaImageCropToolActivity;Z)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, -0x1

    if-nez v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v2, "outputPath"

    invoke-virtual {v0, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->setResult(ILandroid/content/Intent;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->finish()V

    return-void

    :cond_0
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v0, "outputPath"

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->b(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->setResult(ILandroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a([Ljava/lang/Void;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageCropToolActivity$1;->a(Ljava/lang/String;)V

    return-void
.end method
