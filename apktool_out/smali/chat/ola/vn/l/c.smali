.class public Lchat/ola/vn/l/c;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/util/List<",
        "Ljava/lang/String;",
        ">;>;"
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/network/a/a/p;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Void;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 p1, 0x0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/l/c;->a:Lchat/ola/vn/network/a/a/p;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/l/c;->a:Lchat/ola/vn/network/a/a/p;

    invoke-virtual {v0}, Lchat/ola/vn/network/a/a/p;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/http/a;->f(Ljava/lang/String;)[B

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/l/c;->a:Lchat/ola/vn/network/a/a/p;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/a/a/p;->b([B)Ljava/util/List;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    return-object p1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-object p1
.end method

.method public a(Lchat/ola/vn/network/a/a/p;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/l/c;->a:Lchat/ola/vn/network/a/a/p;

    return-void
.end method

.method protected a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/l/c;->a:Lchat/ola/vn/network/a/a/p;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/p;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/l/c;->a([Ljava/lang/Void;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/l/c;->a(Ljava/util/List;)V

    return-void
.end method
