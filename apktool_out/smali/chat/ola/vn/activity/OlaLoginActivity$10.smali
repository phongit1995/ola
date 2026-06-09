.class Lchat/ola/vn/activity/OlaLoginActivity$10;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$10;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$10;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v2, 0x7f0f00a2

    const v3, 0x7f0f02fe

    const v4, 0x7f0f002c

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/activity/OlaLoginActivity$10$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaLoginActivity$10$1;-><init>(Lchat/ola/vn/activity/OlaLoginActivity$10;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$10;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->o(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
