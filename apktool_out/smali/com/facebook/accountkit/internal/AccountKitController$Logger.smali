.class public Lcom/facebook/accountkit/internal/AccountKitController$Logger;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/AccountKitController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Logger"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static logEvent(Ljava/lang/String;Landroid/os/Bundle;)V
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/facebook/accountkit/internal/InternalLogger;->logEvent(Ljava/lang/String;Landroid/os/Bundle;)V

    return-void
.end method

.method public static logInvalidUIManager()V
    .locals 2

    const-string v0, "ak_ui_manager_invalid"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logUIAccountVerified(Z)V
    .locals 4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_account_verified_view"

    const-string v2, "phone"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, p0, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmAccountVerified(Z)V
    .locals 4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_confirm_account_verified_view"

    const-string v2, "phone"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, p0, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmSeamlessLoginInteraction(Ljava/lang/String;)V
    .locals 1

    const-string v0, "ak_confirm_account_verified_view"

    invoke-static {v0, p0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logUIConfirmationCode()V
    .locals 5

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_confirmation_code_view"

    const-string v2, "phone"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmationCodeInteraction(Ljava/lang/String;)V
    .locals 2

    const-string v0, "ak_confirmation_code_view"

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmationCodeInteraction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p1, :cond_0

    :try_start_0
    const-string v1, "link"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const-string p1, "ak_confirmation_code_view"

    invoke-static {p1, p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmationCodeInteraction(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {p2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "confirmation_code"

    const-string p2, "equals"

    :goto_0
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    :cond_0
    const-string p1, "confirmation_code"

    const-string p2, "notEquals"

    goto :goto_0

    :cond_1
    const-string p1, "confirmation_code"

    const-string p2, "notSupplied"
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    const-string p1, "ak_confirmation_code_view"

    invoke-static {p1, p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIConfirmationCodeShown(Z)V
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "retry"

    if-eqz p0, :cond_0

    const-string p0, "true"

    goto :goto_0

    :cond_0
    const-string p0, "false"

    :goto_0
    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p0

    const-string v1, "ak_confirmation_code_view"

    const-string v2, "phone"

    const/4 v3, 0x1

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUICountryCode(ZLjava/lang/String;)V
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "country_code"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string v1, "ak_country_code_view"

    const-string v2, "phone"

    invoke-virtual {p1, v1, v2, p0, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUICustomFragment(Lcom/facebook/accountkit/ui/LoginType;Ljava/lang/String;Z)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "view_type"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p1, "view_provided"

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string p2, "ak_custom_view"

    sget-object v1, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "phone"

    goto :goto_0

    :cond_0
    const-string p0, "email"

    :goto_0
    invoke-virtual {p1, p2, p0, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logCustomUI(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIEmailLogin()V
    .locals 5

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_email_login_view"

    const-string v2, "email"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIEmailLoginInteraction(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "submitted_email"

    invoke-virtual {v0, v1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p3, "email_app_supplied_use"

    invoke-virtual {v0, p3, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p1, "email_selected_use"

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-string p1, "ak_email_login_view"

    invoke-static {p1, p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIEmailLoginShown(Z)V
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "get_accounts_perm"

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/Initializer;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->hasGetAccountsPermissions(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "true"

    goto :goto_0

    :cond_0
    const-string v2, "false"

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "retry"

    if-eqz p0, :cond_1

    const-string p0, "true"

    goto :goto_1

    :cond_1
    const-string p0, "false"

    :goto_1
    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p0

    const-string v1, "ak_email_login_view"

    const-string v2, "email"

    const/4 v3, 0x1

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIEmailVerify(Z)V
    .locals 4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_email_sent_view"

    const-string v2, "email"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, p0, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIEmailVerifyInteraction(Ljava/lang/String;)V
    .locals 2

    const-string v0, "ak_email_sent_view"

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIError(ZLcom/facebook/accountkit/ui/LoginType;)V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_error_view"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "phone"

    goto :goto_0

    :cond_0
    const-string p1, "email"

    :goto_0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, p0, v2}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIErrorInteraction(Ljava/lang/String;)V
    .locals 1

    const-string v0, "ak_error_view"

    invoke-static {v0, p0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private static logUIInteraction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method private static logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 1

    if-nez p2, :cond_0

    new-instance p2, Lorg/json/JSONObject;

    invoke-direct {p2}, Lorg/json/JSONObject;-><init>()V

    :cond_0
    :try_start_0
    const-string v0, "button_type"

    invoke-virtual {p2, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string v0, "phone"

    invoke-virtual {p1, p0, v0, p2}, Lcom/facebook/accountkit/internal/InternalLogger;->logButtonImpression(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIManager(Lcom/facebook/accountkit/ui/UIManager;)V
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    instance-of v1, p0, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v1, :cond_0

    const-string v1, "SkinManager"

    goto :goto_0

    :cond_0
    instance-of v1, p0, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;

    if-eqz v1, :cond_1

    const-string v1, "AdvancedUIManager"

    goto :goto_0

    :cond_1
    instance-of v1, p0, Lcom/facebook/accountkit/ui/ThemeUIManager;

    if-eqz v1, :cond_2

    const-string v1, "ThemeUIManager"

    goto :goto_0

    :cond_2
    instance-of v1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;

    if-eqz v1, :cond_3

    const-string v1, "BaseUIManager"

    goto :goto_0

    :cond_3
    const-string v1, "UIManager"

    :goto_0
    const-string v2, "ui_manager"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    instance-of v1, p0, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v1, :cond_4

    check-cast p0, Lcom/facebook/accountkit/ui/SkinManager;

    const-string v1, "skin_type"

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getSkin()Lcom/facebook/accountkit/ui/SkinManager$Skin;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "skin_manager_has_background_image"

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->hasBackgroundImage()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "skin_manager_primary_color"

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getPrimaryColor()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "skin_manager_tint"

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getTint()Lcom/facebook/accountkit/ui/SkinManager$Tint;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "skin_manager_tint_intensity"

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getTintIntensity()D

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p0

    const-string v1, "ak_ui_manager_view"

    invoke-virtual {p0, v1, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logUIManager(Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIPhoneLogin()V
    .locals 5

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_phone_login_view"

    const-string v2, "phone"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIPhoneLoginInteraction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p1, :cond_0

    :try_start_0
    const-string v1, "link"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const-string p1, "ak_phone_login_view"

    invoke-static {p1, p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIPhoneLoginInteraction(Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "phone_number_source"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p1, "submitted_phone_number"

    invoke-virtual {p2}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-string p1, "ak_phone_login_view"

    invoke-static {p1, p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIPhoneLoginShown(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "country_code"

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "country_code_source"

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "read_phone_number_permission"

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->hasReadPhoneStatePermissions(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "true"

    goto :goto_0

    :cond_0
    const-string p1, "false"

    :goto_0
    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "read_sms_permission"

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->hasReceiveSmsPermissions(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "true"

    goto :goto_1

    :cond_1
    const-string p1, "false"

    :goto_1
    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "sim_locale"

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Initializer;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->getCurrentCountry(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string p0, "retry"

    if-eqz p2, :cond_2

    const-string p1, "true"

    goto :goto_2

    :cond_2
    const-string p1, "false"

    :goto_2
    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p0

    const-string p1, "ak_phone_login_view"

    const-string p2, "phone"

    const/4 v1, 0x1

    invoke-virtual {p0, p1, p2, v1, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIResend(Z)V
    .locals 4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_resend_view"

    const-string v2, "phone"

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, p0, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIResendInteraction(Ljava/lang/String;)V
    .locals 1

    const-string v0, "ak_resend_view"

    invoke-static {v0, p0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIInteraction(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logUISendingCode(ZLcom/facebook/accountkit/ui/LoginType;)V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_sending_code_view"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "phone"

    goto :goto_0

    :cond_0
    const-string p1, "email"

    :goto_0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, p0, v2}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUISentCode(ZLcom/facebook/accountkit/ui/LoginType;)V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_sent_code_view"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "phone"

    goto :goto_0

    :cond_0
    const-string p1, "email"

    :goto_0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, p0, v2}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIVerifiedCode(ZLcom/facebook/accountkit/ui/LoginType;)V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_verified_code_view"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "phone"

    goto :goto_0

    :cond_0
    const-string p1, "email"

    :goto_0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, p0, v2}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static logUIVerifyingCode(ZLcom/facebook/accountkit/ui/LoginType;)V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->access$000()Lcom/facebook/accountkit/internal/Initializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_verifying_code_view"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/ui/LoginType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "phone"

    goto :goto_0

    :cond_0
    const-string p1, "email"

    :goto_0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, p0, v2}, Lcom/facebook/accountkit/internal/InternalLogger;->logImpression(Ljava/lang/String;Ljava/lang/String;ZLorg/json/JSONObject;)V

    return-void
.end method
