.class public abstract Lchat/ola/vn/tradingvip/a;
.super Lchat/ola/vn/m/f;


# instance fields
.field private a:Lchat/ola/vn/tradingvip/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/tradingvip/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tradingvip/a;->a:Lchat/ola/vn/tradingvip/a;

    return-void
.end method

.method public abstract c()Lchat/ola/vn/tradingvip/a;
.end method

.method public final d()Lchat/ola/vn/tradingvip/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/tradingvip/a;->a:Lchat/ola/vn/tradingvip/a;

    return-object v0
.end method

.method public e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public h()Landroid/content/Intent;
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/a;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    return-object v0
.end method

.method public j()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/a;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
