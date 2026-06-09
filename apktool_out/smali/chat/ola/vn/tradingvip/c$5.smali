.class Lchat/ola/vn/tradingvip/c$5;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tradingvip/c;->x()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tradingvip/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/tradingvip/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tradingvip/c$5;->a:Lchat/ola/vn/tradingvip/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/tradingvip/c$5;->a:Lchat/ola/vn/tradingvip/c;

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/tradingvip/c$5;->a:Lchat/ola/vn/tradingvip/c;

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0f009f

    const v1, 0x7f0f0443

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object p1, p0, Lchat/ola/vn/tradingvip/c$5;->a:Lchat/ola/vn/tradingvip/c;

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/tradingvip/c$5;->a:Lchat/ola/vn/tradingvip/c;

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->B()V

    return-void
.end method
