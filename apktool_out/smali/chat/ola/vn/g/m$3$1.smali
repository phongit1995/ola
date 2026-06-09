.class Lchat/ola/vn/g/m$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/g/m$3;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/g/m$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/g/m$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/m$3$1;->a:Lchat/ola/vn/g/m$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/g/m$3$1;->a:Lchat/ola/vn/g/m$3;

    iget-boolean v0, v0, Lchat/ola/vn/g/m$3;->a:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->l()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0, v1}, Lchat/ola/vn/c;->b(Z)V

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0, v1}, Lchat/ola/vn/c;->b(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->k()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
