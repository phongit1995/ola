.class Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;->a:Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;->a:Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;->a:Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    return-void
.end method
