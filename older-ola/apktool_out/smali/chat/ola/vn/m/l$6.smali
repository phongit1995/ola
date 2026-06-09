.class Lchat/ola/vn/m/l$6;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l;->x()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/l;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(DDF)V
    .locals 6

    const-wide/16 v0, 0x0

    cmpl-double p5, p1, v0

    if-eqz p5, :cond_0

    cmpl-double p5, p3, v0

    if-eqz p5, :cond_0

    :try_start_0
    sget-object p5, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p5, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-wide/16 v1, -0x1

    new-instance p5, Ljava/lang/StringBuilder;

    invoke-direct {p5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p5, p1, p2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {p5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p3, p4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string p2, ""

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;Z)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const p2, 0x7f0f00a2

    const p3, 0x7f0f02b5

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public j_()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    invoke-virtual {v0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009f

    const v2, 0x7f0f02d6

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public k_()V
    .locals 0

    return-void
.end method

.method public l_()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/l$6;->a:Lchat/ola/vn/m/l;

    invoke-virtual {v0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const v2, 0x7f0f02a1

    const v3, 0x7f0f02a2

    const v4, 0x7f0f065f

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/m/l$6$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/m/l$6$1;-><init>(Lchat/ola/vn/m/l$6;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
