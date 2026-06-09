.class Lchat/ola/vn/c/t$6;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/c/t$a;",
        "Ljava/lang/Void;",
        "Landroid/graphics/Bitmap;",
        ">;"
    }
.end annotation


# instance fields
.field a:Lchat/ola/vn/c/t$a;

.field final synthetic b:Z

.field final synthetic c:Lchat/ola/vn/c/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/t;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/t$6;->c:Lchat/ola/vn/c/t;

    iput-boolean p2, p0, Lchat/ola/vn/c/t$6;->b:Z

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Lchat/ola/vn/c/t$a;)Landroid/graphics/Bitmap;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v2, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sput-object v2, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    :try_start_2
    aget-object p1, p1, v1

    iput-object p1, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-boolean p1, p0, Lchat/ola/vn/c/t$6;->b:Z

    if-eqz p1, :cond_0

    return-object v0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object p1, p1, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/c/t$6;->c:Lchat/ola/vn/c/t;

    invoke-static {v1}, Lchat/ola/vn/c/t;->e(Lchat/ola/vn/c/t;)Lchat/ola/vn/c/b;

    move-result-object v1

    invoke-virtual {v1, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, p1, Lchat/ola/vn/c/a;->c:J

    iget-object p1, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-object p1

    :catchall_0
    move-exception p1

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    :cond_1
    return-object v0
.end method

.method protected a(Landroid/graphics/Bitmap;)V
    .locals 5

    sget-object v0, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    sget-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v3, 0x0

    if-gtz v1, :cond_0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    goto :goto_0

    :cond_0
    sget-object v1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v4, 0x5

    if-ge v1, v4, :cond_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/c/t$6;->c:Lchat/ola/vn/c/t;

    invoke-static {v1}, Lchat/ola/vn/c/t;->c(Lchat/ola/vn/c/t;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/c/t$6;->c:Lchat/ola/vn/c/t;

    invoke-static {v1}, Lchat/ola/vn/c/t;->c(Lchat/ola/vn/c/t;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v3}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/c/t$b;

    iget-object v4, v1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    new-array v2, v2, [Lchat/ola/vn/c/t$a;

    iget-object v1, v1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    aput-object v1, v2, v3

    invoke-virtual {v4, v2}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_1
    :goto_0
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object v0, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object v0, v0, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    if-eqz v0, :cond_3

    if-eqz p1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object v0, v0, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iget-object v1, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object v1, v1, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/c/w;->b(Ljava/lang/String;Landroid/graphics/Bitmap;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object p1, p1, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iget-object v0, p0, Lchat/ola/vn/c/t$6;->a:Lchat/ola/vn/c/t$a;

    iget-object v0, v0, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    invoke-interface {p1, v0}, Lchat/ola/vn/c/w;->b(Ljava/lang/String;)V

    :cond_3
    return-void

    :catchall_0
    move-exception p1

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Lchat/ola/vn/c/t$a;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/t$6;->a([Lchat/ola/vn/c/t$a;)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Landroid/graphics/Bitmap;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/t$6;->a(Landroid/graphics/Bitmap;)V

    return-void
.end method
