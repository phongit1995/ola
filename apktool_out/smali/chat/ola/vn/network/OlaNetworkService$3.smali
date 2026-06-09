.class Lchat/ola/vn/network/OlaNetworkService$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->A(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/network/OlaNetworkService;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->b:Lchat/ola/vn/network/OlaNetworkService;

    iput-object p2, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/d;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->h(Ljava/io/File;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :cond_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/network/OlaNetworkService;->y()Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_1
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/mg/ola/common/d/d;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "jpg"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "jpeg"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "png"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    :cond_2
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->h(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c/x;->b()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$3;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    goto :goto_0

    :cond_3
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->j(Ljava/lang/String;)V

    :cond_4
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$3;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/network/OlaNetworkService;->j(Lchat/ola/vn/network/OlaNetworkService;)Ljava/lang/ref/WeakReference;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/s/b;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$3;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Lchat/ola/vn/s/b;->A(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_5
    return-void
.end method
