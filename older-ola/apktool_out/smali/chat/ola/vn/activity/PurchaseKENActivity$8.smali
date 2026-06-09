.class Lchat/ola/vn/activity/PurchaseKENActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/PurchaseKENActivity;->C()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p2}, Lcom/android/vending/billing/IInAppBillingService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lcom/android/vending/billing/IInAppBillingService;)Lcom/android/vending/billing/IInAppBillingService;

    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->j(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/lang/Runnable;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-exception p1

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->j(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/lang/Runnable;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lcom/android/vending/billing/IInAppBillingService;)Lcom/android/vending/billing/IInAppBillingService;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Landroid/content/ServiceConnection;)Landroid/content/ServiceConnection;

    :cond_0
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lcom/android/vending/billing/IInAppBillingService;)Lcom/android/vending/billing/IInAppBillingService;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$8;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Landroid/content/ServiceConnection;)Landroid/content/ServiceConnection;

    return-void
.end method
