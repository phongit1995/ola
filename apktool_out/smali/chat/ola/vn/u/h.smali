.class Lchat/ola/vn/u/h;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public a:Lchat/ola/vn/w/ce;

.field protected b:Z

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;"
        }
    .end annotation
.end field

.field private d:Lchat/ola/vn/u/d;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;Lchat/ola/vn/u/d;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/u/h;->b:Z

    new-instance v1, Lchat/ola/vn/w/ce;

    invoke-direct {v1, p1}, Lchat/ola/vn/w/ce;-><init>(Ljava/io/InputStream;)V

    iput-object v1, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    iput-boolean v0, p0, Lchat/ola/vn/u/h;->b:Z

    iput-object p2, p0, Lchat/ola/vn/u/h;->d:Lchat/ola/vn/u/d;

    return-void
.end method

.method private a(Lchat/ola/vn/w/s;)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/u/h;->c:Ljava/util/List;

    if-nez v0, :cond_1

    return-void

    :cond_1
    :try_start_0
    iget v0, p1, Lchat/ola/vn/w/s;->b:I

    int-to-short v0, v0

    invoke-static {v0}, Lchat/ola/vn/u/k;->a(S)Lchat/ola/vn/u/a;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/u/h;->c:Ljava/util/List;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/u/h;->c:Ljava/util/List;

    invoke-interface {v0, p1, v2}, Lchat/ola/vn/u/a;->a(Lchat/ola/vn/w/s;Ljava/util/List;)V

    monitor-exit v1

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private b()Lchat/ola/vn/w/s;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    invoke-virtual {v0}, Lchat/ola/vn/w/ce;->a()Lchat/ola/vn/w/s;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/u/h;->c:Ljava/util/List;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/u/h;->b:Z

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    invoke-virtual {v1}, Lchat/ola/vn/w/ce;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    throw v1

    :catch_0
    :goto_0
    iput-object v0, p0, Lchat/ola/vn/u/h;->a:Lchat/ola/vn/w/ce;

    iput-object v0, p0, Lchat/ola/vn/u/h;->d:Lchat/ola/vn/u/d;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/u/h;->c:Ljava/util/List;

    return-void
.end method

.method public run()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/u/h;->b:Z

    const/4 v0, 0x5

    :goto_0
    const/4 v1, 0x5

    :goto_1
    iget-boolean v2, p0, Lchat/ola/vn/u/h;->b:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-nez v2, :cond_2

    const/4 v2, 0x1

    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/u/h;->b()Lchat/ola/vn/w/s;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-nez v3, :cond_1

    add-int/lit8 v1, v1, -0x1

    if-gez v1, :cond_0

    :try_start_2
    iput-boolean v2, p0, Lchat/ola/vn/u/h;->b:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_0
    const-wide/16 v4, 0x3e8

    :try_start_3
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :catch_0
    :cond_1
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/u/h;->d:Lchat/ola/vn/u/d;

    invoke-virtual {v1}, Lchat/ola/vn/u/d;->a()V

    invoke-direct {p0, v3}, Lchat/ola/vn/u/h;->a(Lchat/ola/vn/w/s;)V

    goto :goto_0

    :catch_1
    iput-boolean v2, p0, Lchat/ola/vn/u/h;->b:Z

    iget-object v2, p0, Lchat/ola/vn/u/h;->d:Lchat/ola/vn/u/d;

    invoke-virtual {v2}, Lchat/ola/vn/u/d;->b()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_1

    :catch_2
    :cond_2
    return-void
.end method
