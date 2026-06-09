.class final Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->logInAppPurchaseEvent(Landroid/content/Context;ILandroid/content/Intent;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$context:Landroid/content/Context;

.field final synthetic val$purchaseData:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    iput-object p2, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$purchaseData:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 7

    iget-object p1, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-static {p1, p2}, Lcom/facebook/appevents/internal/InAppPurchaseEventManager;->getServiceInterface(Landroid/content/Context;Landroid/os/IBinder;)Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->access$002(Ljava/lang/Object;)Ljava/lang/Object;

    :try_start_0
    new-instance p1, Lorg/json/JSONObject;

    iget-object p2, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$purchaseData:Ljava/lang/String;

    invoke-direct {p1, p2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p2, "productId"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const-string v0, "autoRenewing"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    iget-object v1, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-static {}, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->access$000()Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, p2, v2, v0}, Lcom/facebook/appevents/internal/InAppPurchaseEventManager;->getPurchaseDetails(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Object;Z)Ljava/lang/String;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    iget-object p1, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    return-void

    :cond_0
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-static {v0}, Lcom/facebook/appevents/AppEventsLogger;->newLogger(Landroid/content/Context;)Lcom/facebook/appevents/AppEventsLogger;

    move-result-object v0

    new-instance v2, Landroid/os/Bundle;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Landroid/os/Bundle;-><init>(I)V

    const-string v3, "fb_iap_product_id"

    invoke-virtual {v2, v3, p2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_purchase_time"

    const-string v3, "purchaseTime"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_purchase_state"

    const-string v3, "purchaseState"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_purchase_token"

    const-string v3, "purchaseToken"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_package_name"

    const-string v3, "packageName"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_product_type"

    const-string v3, "type"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_product_title"

    const-string v3, "title"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_product_description"

    const-string v3, "description"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, p2, v3}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p2, "fb_iap_subs_auto_renewing"

    const-string v3, "autoRenewing"

    const/4 v4, 0x0

    invoke-virtual {p1, v3, v4}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p2, p1}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p1, "fb_iap_subs_period"

    const-string p2, "subscriptionPeriod"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p1, p2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p1, "fb_free_trial_period"

    const-string p2, "freeTrialPeriod"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p1, p2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p1, "fb_intro_price_amount_micros"

    const-string p2, "introductoryPriceAmountMicros"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p1, p2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    const-string p1, "fb_intro_price_cycles"

    const-string p2, "introductoryPriceCycles"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p1, p2}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    new-instance p1, Ljava/math/BigDecimal;

    const-string p2, "price_amount_micros"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v3

    long-to-double v3, v3

    const-wide v5, 0x412e848000000000L    # 1000000.0

    div-double/2addr v3, v5

    invoke-direct {p1, v3, v4}, Ljava/math/BigDecimal;-><init>(D)V

    const-string p2, "price_currency_code"

    invoke-virtual {v1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Ljava/util/Currency;->getInstance(Ljava/lang/String;)Ljava/util/Currency;

    move-result-object p2

    invoke-virtual {v0, p1, p2, v2}, Lcom/facebook/appevents/AppEventsLogger;->logPurchaseImplicitly(Ljava/math/BigDecimal;Ljava/util/Currency;Landroid/os/Bundle;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    :catch_0
    move-exception p1

    :try_start_2
    invoke-static {}, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->access$100()Ljava/lang/String;

    move-result-object p2

    const-string v0, "Error parsing in-app purchase data."

    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :goto_0
    iget-object p1, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    return-void

    :goto_1
    iget-object p2, p0, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger$1;->val$context:Landroid/content/Context;

    invoke-virtual {p2, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    throw p1
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    const/4 p1, 0x0

    invoke-static {p1}, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->access$002(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {}, Lcom/facebook/appevents/internal/AutomaticAnalyticsLogger;->access$100()Ljava/lang/String;

    move-result-object p1

    const-string v0, "In-app billing service disconnected"

    invoke-static {p1, v0}, Lcom/facebook/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
