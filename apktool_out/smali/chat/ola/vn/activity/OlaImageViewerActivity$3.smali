.class Lchat/ola/vn/activity/OlaImageViewerActivity$3;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity;->f(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaImageViewerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/String;)Ljava/lang/Boolean;
    .locals 6

    new-instance v0, Ljava/io/File;

    const/4 v1, 0x1

    invoke-static {v1}, Lchat/ola/vn/d;->a(S)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v4, ".jpg"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    :try_start_0
    aget-object p1, p1, v3

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/o;->c(Ljava/lang/String;Ljava/lang/String;)Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v3, "jpg"

    invoke-static {p1, v2, v0, v3}, Lchat/ola/vn/util/l;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected a(Ljava/lang/Boolean;)V
    .locals 3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    sget-object v1, Lchat/ola/vn/d;->d:Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const v1, 0x7f0f0239

    invoke-static {p1, v1, v0}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I[Ljava/lang/Object;)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->a([Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->a(Ljava/lang/Boolean;)V

    return-void
.end method
