.class Lchat/ola/vn/activity/PurchaseKENActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


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

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object v0

    if-eqz v0, :cond_c

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-virtual {v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "inapp"

    const/4 v3, 0x0

    const/4 v4, 0x3

    invoke-interface {v0, v4, v1, v2, v3}, Lcom/android/vending/billing/IInAppBillingService;->getPurchases(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "RESPONSE_CODE"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    const/4 v2, 0x0

    if-nez v1, :cond_2

    :try_start_1
    const-string v3, "INAPP_PURCHASE_DATA_LIST"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    const/4 v3, 0x0

    :goto_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-ge v3, v5, :cond_2

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :try_start_2
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v7, "productId"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "purchaseToken"

    invoke-virtual {v6, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v8

    invoke-virtual {v8, v7}, Lchat/ola/vn/e;->l(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_0

    sget-object v6, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, ""

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v9, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v9}, Lchat/ola/vn/activity/PurchaseKENActivity;->b(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/p/q;

    move-result-object v9

    invoke-virtual {v6, v7, v5, v8, v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/q;)V

    goto :goto_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v5

    invoke-virtual {v5, v7}, Lchat/ola/vn/e;->k(Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v5}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object v5

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v5, v4, v7, v6}, Lcom/android/vending/billing/IInAppBillingService;->consumePurchase(ILjava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :cond_1
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_1
    :cond_2
    :try_start_3
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "ITEM_ID_LIST"

    invoke-static {}, Lchat/ola/vn/activity/PurchaseKENActivity;->B()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Landroid/os/Bundle;->putStringArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v3

    const-string v5, "inapp"

    invoke-interface {v1, v4, v3, v5, v0}, Lcom/android/vending/billing/IInAppBillingService;->getSkuDetails(ILjava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "RESPONSE_CODE"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_c

    const-string v1, "DETAILS_LIST"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {v1, v3}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/util/List;)Ljava/util/List;

    goto :goto_2

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->clear()V

    :goto_2
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_2
    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_b

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :try_start_4
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    new-instance v1, Lchat/ola/vn/entity/p;

    invoke-direct {v1}, Lchat/ola/vn/entity/p;-><init>()V

    const-string v3, "productId"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "productId"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    :cond_4
    const-string v3, "description"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    const-string v3, "description"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    :cond_5
    const-string v3, "price"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    const-string v3, "price"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    :cond_6
    const-string v3, "price_amount_micros"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    const-string v3, "price_amount_micros"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v3

    iput-wide v3, v1, Lchat/ola/vn/entity/p;->k:J

    :cond_7
    const-string v3, "price_currency_code"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    const-string v3, "price_currency_code"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lchat/ola/vn/entity/p;->l:Ljava/lang/String;

    :cond_8
    const-string v3, "title"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_9

    const-string v3, "title"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lchat/ola/vn/entity/p;->h:Ljava/lang/String;

    :cond_9
    const-string v3, "type"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    const-string v3, "type"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/p;->d:Ljava/lang/String;

    :cond_a
    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$1;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto/16 :goto_3

    :cond_b
    :try_start_5
    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$1$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$1$1;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity$1;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    :catch_3
    :cond_c
    return-void
.end method
