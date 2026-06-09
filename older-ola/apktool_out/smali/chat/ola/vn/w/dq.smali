.class Lchat/ola/vn/w/dq;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public a:Lchat/ola/vn/p/g;

.field public b:Lchat/ola/vn/w/ce;

.field protected c:Z

.field protected d:Lchat/ola/vn/w/ci;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/w/dq;->c:Z

    new-instance v1, Lchat/ola/vn/w/ce;

    invoke-direct {v1, p1}, Lchat/ola/vn/w/ce;-><init>(Ljava/io/InputStream;)V

    iput-object v1, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    iput-boolean v0, p0, Lchat/ola/vn/w/dq;->c:Z

    return-void
.end method

.method private a(Lchat/ola/vn/w/s;)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    if-nez v0, :cond_1

    return-void

    :cond_1
    :try_start_0
    iget v0, p1, Lchat/ola/vn/w/s;->b:I

    int-to-short v0, v0

    invoke-static {}, Lchat/ola/vn/w/ch;->a()Lchat/ola/vn/w/ch;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/w/ch;->a(S)Lchat/ola/vn/w/bb;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    iget-object v2, p0, Lchat/ola/vn/w/dq;->d:Lchat/ola/vn/w/ci;

    invoke-interface {v0, p1, v1, v2}, Lchat/ola/vn/w/bb;->a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private b()Lchat/ola/vn/w/s;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    invoke-virtual {v0}, Lchat/ola/vn/w/ce;->a()Lchat/ola/vn/w/s;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/w/dq;->c:Z

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    invoke-virtual {v1}, Lchat/ola/vn/w/ce;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iput-object v0, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    return-void

    :catchall_0
    move-exception v1

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_1
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    return-void

    :goto_1
    iput-object v0, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    throw v1
.end method

.method public a(Lchat/ola/vn/p/g;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    iget-object v0, p0, Lchat/ola/vn/w/dq;->b:Lchat/ola/vn/w/ce;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ce;->a(Lchat/ola/vn/p/g;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/ci;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/dq;->d:Lchat/ola/vn/w/ci;

    return-void
.end method

.method public run()V
    .locals 5

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/w/dq;->c:Z

    const/16 v1, 0xa

    :goto_0
    const/16 v2, 0xa

    :catch_0
    :cond_0
    :goto_1
    iget-boolean v3, p0, Lchat/ola/vn/w/dq;->c:Z

    if-nez v3, :cond_3

    const/4 v3, 0x1

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/w/dq;->b()Lchat/ola/vn/w/s;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v4, :cond_2

    add-int/lit8 v2, v2, -0x1

    if-gtz v2, :cond_1

    iput-boolean v3, p0, Lchat/ola/vn/w/dq;->c:Z

    iget-object v3, p0, Lchat/ola/vn/w/dq;->d:Lchat/ola/vn/w/ci;

    invoke-virtual {v3, v0}, Lchat/ola/vn/w/ci;->c(Z)V

    iget-object v3, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    if-eqz v3, :cond_0

    :goto_2
    iget-object v3, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    invoke-interface {v3}, Lchat/ola/vn/p/g;->d()V

    goto :goto_1

    :cond_1
    const-wide/16 v3, 0x1f4

    :try_start_1
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :cond_2
    invoke-direct {p0, v4}, Lchat/ola/vn/w/dq;->a(Lchat/ola/vn/w/s;)V

    goto :goto_0

    :catch_1
    iput-boolean v3, p0, Lchat/ola/vn/w/dq;->c:Z

    iget-object v3, p0, Lchat/ola/vn/w/dq;->d:Lchat/ola/vn/w/ci;

    invoke-virtual {v3, v0}, Lchat/ola/vn/w/ci;->c(Z)V

    iget-object v3, p0, Lchat/ola/vn/w/dq;->a:Lchat/ola/vn/p/g;

    if-eqz v3, :cond_0

    goto :goto_2

    :cond_3
    return-void
.end method
