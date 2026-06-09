.class Lchat/ola/vn/activity/PurchaseKENActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/PurchaseKENActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/PurchaseKENActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->p(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$4;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v3, 0x7f0f0354

    invoke-virtual {v2, v3}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
