.class Lchat/ola/vn/network/OlaNetworkService$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/network/OlaNetworkService;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService;JLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$2;->c:Lchat/ola/vn/network/OlaNetworkService;

    iput-wide p2, p0, Lchat/ola/vn/network/OlaNetworkService$2;->a:J

    iput-object p4, p0, Lchat/ola/vn/network/OlaNetworkService$2;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    new-instance v5, Lchat/ola/vn/network/OlaNetworkService$2$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/network/OlaNetworkService$2$1;-><init>(Lchat/ola/vn/network/OlaNetworkService$2;)V

    const v1, 0x7f0f0633

    const v2, 0x7f0f017c

    const v3, 0x7f0f065a

    const v4, 0x7f0f0577

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setCancelable(Z)V

    return-void
.end method
