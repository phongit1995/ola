.class Lchat/ola/vn/activity/PurchaseKENActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/q;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/PurchaseKENActivity;
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

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v2, 0x7f0f00a2

    const v3, 0x7f0f035a

    const v4, 0x7f0f0480

    const/4 v5, 0x0

    new-instance v6, Lchat/ola/vn/activity/PurchaseKENActivity$6$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$6$1;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity$6;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/p;)V
    .locals 7

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object v1

    const/4 v2, 0x3

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-virtual {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p1, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    const-string v5, "inapp"

    iget-object v6, p1, Lchat/ola/vn/entity/p;->e:Ljava/lang/String;

    invoke-interface/range {v1 .. v6}, Lcom/android/vending/billing/IInAppBillingService;->getBuyIntent(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "BUY_INTENT"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Landroid/app/PendingIntent;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-virtual {p1}, Landroid/app/PendingIntent;->getIntentSender()Landroid/content/IntentSender;

    move-result-object v1

    const/16 v2, 0x3e9

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const/4 p1, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/activity/PurchaseKENActivity;->startIntentSenderForResult(Landroid/content/IntentSender;ILandroid/content/Intent;III)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v0, 0x7f0f00a2

    const v1, 0x7f0f035a

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/i/c;)Lchat/ola/vn/i/c;

    :cond_0
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    :cond_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p3

    invoke-virtual {p3, p1}, Lchat/ola/vn/e;->k(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string p3, "Deposit KEN by IAP"

    invoke-virtual {p1, p3}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object p1

    const/4 p3, 0x3

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, p3, v0, p2}, Lcom/android/vending/billing/IInAppBillingService;->consumePurchase(ILjava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/p;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v0, v0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v2, v0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v0, v0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->f(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {v0, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->b(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/util/List;)Ljava/util/List;

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->f(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :goto_2
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_6

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/p;

    iget-object v2, v0, Lchat/ola/vn/entity/p;->d:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/entity/p;->c:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object v2

    iget-object v3, v0, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v0, v0, Lchat/ola/vn/entity/p;->j:Ljava/lang/String;

    invoke-static {v2, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_3

    :cond_3
    iget-object v2, v0, Lchat/ola/vn/entity/p;->d:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/entity/p;->a:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->f(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v2

    iget-object v3, v0, Lchat/ola/vn/entity/p;->o:Lchat/ola/vn/entity/ae;

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v0, v0, Lchat/ola/vn/entity/p;->j:Ljava/lang/String;

    invoke-static {v2, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->b(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_3

    :cond_4
    iget-object v2, v0, Lchat/ola/vn/entity/p;->d:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/entity/p;->b:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v2, v2, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    iget-object v3, v0, Lchat/ola/vn/entity/p;->n:Lchat/ola/vn/entity/a;

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, v0, Lchat/ola/vn/entity/p;->j:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->f(Ljava/lang/String;)Ljava/lang/String;

    :cond_5
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->g(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->h(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_8

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->j(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_4

    :catch_0
    move-exception p1

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_4
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->j(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    goto :goto_5

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->k(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/content/ServiceConnection;

    move-result-object p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->l(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    :cond_8
    :goto_5
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/i/c;)Lchat/ola/vn/i/c;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public b()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v1, 0x7f0f00a2

    const v2, 0x7f0f035a

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/i/c;)Lchat/ola/vn/i/c;

    :cond_0
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    :cond_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p3

    invoke-virtual {p3, p1}, Lchat/ola/vn/e;->k(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$6;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object p1

    const/4 p3, 0x3

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, p3, v0, p2}, Lcom/android/vending/billing/IInAppBillingService;->consumePurchase(ILjava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    return-void
.end method
