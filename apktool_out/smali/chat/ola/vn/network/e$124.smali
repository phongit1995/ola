.class Lchat/ola/vn/network/e$124;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$124;->a:Lchat/ola/vn/network/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$124;->a:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    const/4 v1, 0x7

    if-ne v0, v1, :cond_2

    const/4 v0, 0x0

    invoke-static {v0}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$124;->a:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lchat/ola/vn/network/OlaNetworkService;->k:Z

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->c(Landroid/content/Context;)V

    goto :goto_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v2, 0x7f0f01f5

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    :goto_0
    invoke-static {v0, v2}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    goto :goto_1

    :cond_1
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/network/e$124;->a:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/network/e$124;->a:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    invoke-interface {v1}, Lchat/ola/vn/network/f;->l()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    :cond_2
    return-void
.end method
