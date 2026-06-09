.class Lcom/facebook/accountkit/internal/PhoneLoginController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/PhoneLoginController;->logIn(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/PhoneLoginController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 7

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-eqz v0, :cond_7

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    return-void

    :cond_1
    :try_start_1
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    goto :goto_0

    :cond_2
    const-string v0, "privacy_policy"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    const-string v2, "privacy_policy"

    invoke-virtual {v1, v2, v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string v0, "terms_of_service"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    const-string v2, "terms_of_service"

    invoke-virtual {v1, v2, v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_4
    :try_start_2
    const-string v0, "can_attempt_seamless_login"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    const-string v1, "expires_at"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    const-wide/16 v3, 0x3e8

    mul-long v1, v1, v3

    if-eqz v0, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    cmp-long v0, v1, v3

    if-lez v0, :cond_5

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v0, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->ACCOUNT_VERIFIED:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    :cond_5
    :try_start_3
    const-string v0, "login_request_code"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "expires_in_sec"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v3, v3, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3, v1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setExpiresInSeconds(J)V

    const-string v1, "min_resend_interval_sec"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v5, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v1

    const/4 v5, 0x0

    add-long v5, v3, v1

    invoke-virtual {p1, v5, v6}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setResendTime(J)V

    goto :goto_1

    :cond_6
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setResendTime(J)V

    :goto_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->PENDING:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setLoginCode(Ljava/lang/String;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_2

    :catch_1
    :try_start_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :goto_2
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    throw p1

    :cond_7
    return-void
.end method
