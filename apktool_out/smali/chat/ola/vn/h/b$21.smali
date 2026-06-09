.class final Lchat/ola/vn/h/b$21;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/util/List;I)V
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
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:I


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/util/List;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/b$21;->a:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/h/b$21;->b:Ljava/util/List;

    iput p3, p0, Lchat/ola/vn/h/b$21;->c:I

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 3

    const-string p1, ".contact.dat"

    monitor-enter p1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/h/b$21;->a:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/d;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v2, ".contact.dat"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/h/b$21;->b:Ljava/util/List;

    iget v2, p0, Lchat/ola/vn/h/b$21;->c:I

    invoke-static {v1, v0, v2}, Lchat/ola/vn/h/b;->a(Ljava/io/File;Ljava/util/List;I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_1
    :try_start_2
    monitor-exit p1

    const/4 p1, 0x0

    return-object p1

    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/h/b$21;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
