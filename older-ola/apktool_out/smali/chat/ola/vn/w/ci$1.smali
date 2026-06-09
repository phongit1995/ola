.class Lchat/ola/vn/w/ci$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$1;->a:Lchat/ola/vn/w/ci;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/ci$1;->a:Lchat/ola/vn/w/ci;

    invoke-static {v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v0

    monitor-enter v0

    :goto_0
    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/w/ci$1;->a:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/w/ci$1;->a:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;)Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/w/bk;

    iget-object v2, p0, Lchat/ola/vn/w/ci$1;->a:Lchat/ola/vn/w/ci;

    invoke-static {v2, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    goto :goto_0

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
