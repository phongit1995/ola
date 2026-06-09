.class Lchat/ola/vn/network/e$60$2;
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
.field final synthetic a:J

.field final synthetic b:Lchat/ola/vn/network/e$60;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e$60;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$60$2;->b:Lchat/ola/vn/network/e$60;

    iput-wide p2, p0, Lchat/ola/vn/network/e$60$2;->a:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/e$60$2;->b:Lchat/ola/vn/network/e$60;

    iget-object v0, v0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/e$60$2;->b:Lchat/ola/vn/network/e$60;

    iget-object v0, v0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    const v2, 0x7f0f00a2

    const v3, 0x7f0f0393

    const v4, 0x7f0f0444

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/network/e$60$2$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/network/e$60$2$1;-><init>(Lchat/ola/vn/network/e$60$2;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    iget-wide v0, p0, Lchat/ola/vn/network/e$60$2;->a:J

    sput-wide v0, Lchat/ola/vn/h;->E:J

    sget-wide v0, Lchat/ola/vn/h;->E:J

    invoke-static {v0, v1}, Lchat/ola/vn/h/b;->a(J)V

    :cond_0
    return-void
.end method
