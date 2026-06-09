.class Lchat/ola/vn/w/ci$14;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/w/bk;

.field final synthetic b:Z

.field final synthetic c:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$14;->a:Lchat/ola/vn/w/bk;

    iput-boolean p3, p0, Lchat/ola/vn/w/ci$14;->b:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    new-instance v0, Lchat/ola/vn/w/cg;

    iget-object v1, p0, Lchat/ola/vn/w/ci$14;->a:Lchat/ola/vn/w/bk;

    iget-short v1, v1, Lchat/ola/vn/w/bk;->ab:S

    invoke-direct {v0, v1}, Lchat/ola/vn/w/cg;-><init>(S)V

    iget-boolean v1, p0, Lchat/ola/vn/w/ci$14;->b:Z

    iput-boolean v1, v0, Lchat/ola/vn/w/cg;->a:Z

    invoke-static {}, Lchat/ola/vn/w/ch;->a()Lchat/ola/vn/w/ch;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/w/cg;->b()S

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/w/ch;->a(S)Lchat/ola/vn/w/bb;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v2}, Lchat/ola/vn/w/ci;->b(Lchat/ola/vn/w/ci;)Lchat/ola/vn/p/g;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/w/ci$14;->a:Lchat/ola/vn/w/bk;

    iget-object v3, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v3}, Lchat/ola/vn/w/ci;->b(Lchat/ola/vn/w/ci;)Lchat/ola/vn/p/g;

    move-result-object v3

    invoke-interface {v1, v2, v0, v3}, Lchat/ola/vn/w/bb;->a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->d(Lchat/ola/vn/w/ci;)Lchat/ola/vn/w/dr;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v2}, Lchat/ola/vn/w/ci;->c(Lchat/ola/vn/w/ci;)Z

    move-result v2

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/w/dr;->a(Lchat/ola/vn/w/cg;Z)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v0

    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/w/ci$14;->a:Lchat/ola/vn/w/bk;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v0

    monitor-enter v0

    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/w/ci$14;->c:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/w/ci$14;->a:Lchat/ola/vn/w/bk;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_1
    move-exception v1

    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v1
.end method
