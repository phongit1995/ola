.class Lchat/ola/vn/message/aa$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/message/aa;->F()V
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
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/aa;


# direct methods
.method constructor <init>(Lchat/ola/vn/message/aa;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->l()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ".voice."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    invoke-static {v3}, Lchat/ola/vn/message/aa;->a(Lchat/ola/vn/message/aa;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    iget-object v3, v3, Lchat/ola/vn/message/aa;->l:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-static {p1, v1}, Lchat/ola/vn/util/o;->c(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lchat/ola/vn/message/aa;->E:Z

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    iget-object v1, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    invoke-static {v1}, Lchat/ola/vn/message/aa;->a(Lchat/ola/vn/message/aa;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/message/aa;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    iget-object v0, p0, Lchat/ola/vn/message/aa$1;->a:Lchat/ola/vn/message/aa;

    invoke-static {v0}, Lchat/ola/vn/message/aa;->a(Lchat/ola/vn/message/aa;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/aa;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/aa$1;->a([Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/aa$1;->a(Ljava/lang/String;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 0

    return-void
.end method
