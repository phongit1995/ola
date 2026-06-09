.class Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    const v1, 0x7f0f00a2

    const v2, 0x7f0f02fe

    const v3, 0x7f0f002c

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2$1;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->b(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
