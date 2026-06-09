.class Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;->a:Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;->a:Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;->a:Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;

    const v2, 0x7f0f009f

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;->a:Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;

    const v3, 0x7f0f02fe

    invoke-virtual {v2, v3}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6$1;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;)V

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
