.class Lchat/ola/vn/network/e$60$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e$60;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/e$60;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e$60;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$60$1;->a:Lchat/ola/vn/network/e$60;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->b(Landroid/content/Context;)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/e$60$1;->a:Lchat/ola/vn/network/e$60;

    iget-object v0, v0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/e$60$1;->a:Lchat/ola/vn/network/e$60;

    iget-object v0, v0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    const v2, 0x7f0f00a2

    const v3, 0x7f0f0397

    const v4, 0x7f0f04ea

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/network/e$60$1$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/network/e$60$1$1;-><init>(Lchat/ola/vn/network/e$60$1;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
