.class Lcom/facebook/accountkit/internal/EmailLoginController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/EmailLoginController;->logIn(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/EmailLoginController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/EmailLoginController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 6

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    return-void

    :cond_1
    :try_start_1
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    goto :goto_0

    :cond_2
    const-string v1, "privacy_policy"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v2, v2, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    const-string v3, "privacy_policy"

    invoke-virtual {v2, v3, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string v1, "terms_of_service"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v2, v2, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    const-string v3, "terms_of_service"

    invoke-virtual {v2, v3, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_4
    :try_start_2
    const-string v1, "can_attempt_seamless_login"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    const-string v2, "expires_at"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    mul-long v2, v2, v4

    if-eqz v1, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-lez v1, :cond_5

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->ACCOUNT_VERIFIED:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    :cond_5
    :try_start_3
    const-string v1, "login_request_code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v2, v2, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setLoginCode(Ljava/lang/String;)V

    const-string v1, "expires_in_sec"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v3, v3, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3, v1, v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setExpiresInSeconds(J)V

    const-string v1, "interval_sec"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setInterval(I)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->PENDING:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->handle(Lcom/facebook/accountkit/internal/LoginModelImpl;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :catch_1
    :try_start_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :goto_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$1;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    throw p1
.end method
