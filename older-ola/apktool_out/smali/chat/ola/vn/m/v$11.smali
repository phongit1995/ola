.class Lchat/ola/vn/m/v$11;
.super Lchat/ola/vn/b/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/v;->b(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic g:Lchat/ola/vn/m/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/v;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$11;->g:Lchat/ola/vn/m/v;

    invoke-direct {p0, p2}, Lchat/ola/vn/b/e;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected a(Ljava/lang/String;Landroid/widget/EditText;)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/m/v$11;->g:Lchat/ola/vn/m/v;

    iget-object v1, v1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->B()J

    move-result-wide v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p1

    invoke-virtual/range {v0 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V

    new-instance p1, Lchat/ola/vn/m/v$11$1;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/m/v$11$1;-><init>(Lchat/ola/vn/m/v$11;Landroid/widget/EditText;)V

    const-wide/16 v0, 0x3e8

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method
