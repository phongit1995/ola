.class final Lchat/ola/vn/network/OlaNetworkService$5;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object p1

    const-string v1, ".cached"

    invoke-direct {v0, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    :try_start_0
    invoke-static {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/io/File;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    invoke-static {v0}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :goto_0
    :try_start_1
    invoke-static {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/io/File;Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    invoke-static {v0}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :goto_1
    :try_start_2
    new-instance p1, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->a()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    :catch_2
    :goto_2
    new-instance p1, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->a()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    :try_start_3
    invoke-static {p1}, Lcom/mg/ola/common/d/c;->f(Ljava/io/File;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService$5;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
