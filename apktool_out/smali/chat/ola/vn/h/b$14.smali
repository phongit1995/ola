.class final Lchat/ola/vn/h/b$14;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h/b;->c(Ljava/lang/String;Ljava/util/List;)V
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


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/util/List;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/b$14;->a:Ljava/util/List;

    iput-object p2, p0, Lchat/ola/vn/h/b$14;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 5

    const-string p1, ".phoneignore.list"

    monitor-enter p1

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/h/b$14;->a:Ljava/util/List;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/h/b$14;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/h/b$14;->a:Ljava/util/List;

    invoke-static {v1}, Lchat/ola/vn/h/b;->f(Ljava/util/List;)[B

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/h/b$14;->b:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_3

    new-instance v3, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v4, ".phoneignore.list"

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    if-nez v1, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    goto :goto_1

    :cond_1
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z

    :cond_2
    invoke-static {v3, v1}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_0
    :cond_3
    :goto_1
    :try_start_1
    monitor-exit p1

    return-object v0

    :goto_2
    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/h/b$14;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
