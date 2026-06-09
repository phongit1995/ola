.class public Lchat/ola/vn/c/j;
.super Lchat/ola/vn/c/b;


# instance fields
.field private b:Landroid/support/v4/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/LruCache<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/c/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(IZ)V
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/c/b;-><init>()V

    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    const-string v2, ".cached"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/c/j;->a:Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/c/j;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/j;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    :cond_0
    if-eqz p2, :cond_1

    invoke-direct {p0, p1}, Lchat/ola/vn/c/j;->a(I)V

    return-void

    :cond_1
    invoke-direct {p0, p1}, Lchat/ola/vn/c/j;->b(I)V

    return-void
.end method

.method private a(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/c/j$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/c/j$1;-><init>(Lchat/ola/vn/c/j;I)V

    iput-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    return-void
.end method

.method private b(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/c/j$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/c/j$2;-><init>(Lchat/ola/vn/c/j;I)V

    iput-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lchat/ola/vn/c/a;
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    invoke-virtual {v1, p1}, Landroid/support/v4/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/c/a;

    if-nez v1, :cond_1

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/j;->c(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object v1

    :cond_1
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;
    .locals 2

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    invoke-virtual {v1, p1, p2}, Landroid/support/v4/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/c/a;

    monitor-exit v0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    invoke-virtual {v1}, Landroid/support/v4/util/LruCache;->evictAll()V

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public b(Ljava/lang/String;)Lchat/ola/vn/c/a;
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/c/j;->b:Landroid/support/v4/util/LruCache;

    invoke-virtual {v1, p1}, Landroid/support/v4/util/LruCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/c/a;

    monitor-exit v0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
