.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$4;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v1, 0x7f0f00a2

    const v2, 0x7f0f0354

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
