.class Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/EmailLoginController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LoginModelCodeCallback"
.end annotation


# instance fields
.field final loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

.field final synthetic this$0:Lcom/facebook/accountkit/internal/EmailLoginController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 9

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result v1

    if-eqz v1, :cond_10

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isLoginInProgress()Z

    move-result v1

    if-nez v1, :cond_1

    goto/16 :goto_3

    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz p1, :cond_2

    sget-object p1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_2
    return-void

    :cond_3
    :try_start_1
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz p1, :cond_4

    sget-object p1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_1

    return-void

    :pswitch_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_4
    return-void

    :cond_5
    :try_start_2
    const-string v1, "status"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "pending"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    new-instance v3, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;

    iget-object v4, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v5, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-direct {v3, v4, v5}, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;-><init>(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;)V

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/EmailLoginController;->access$100(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;

    move-result-object v1
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v1, :cond_7

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz p1, :cond_6

    sget-object p1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_2

    return-void

    :pswitch_2
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_6
    return-void

    :cond_7
    :try_start_3
    const-string v2, "interval_sec"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3, v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setInterval(I)V

    const-string v2, "expires_in_sec"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {p1, v2, v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setExpiresInSeconds(J)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getInterval()I

    move-result p1

    int-to-long v4, p1

    cmp-long p1, v2, v4

    if-gez p1, :cond_9

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->EXPIRED_EMAIL_REQUEST:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz p1, :cond_8

    sget-object p1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_3

    return-void

    :pswitch_3
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_8
    return-void

    :cond_9
    :try_start_4
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result p1

    if-nez p1, :cond_a

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isLoginInProgress()Z

    move-result p1

    if-eqz p1, :cond_d

    :cond_a
    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getInterval()I

    move-result v2

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {p1, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto/16 :goto_1

    :cond_b
    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v1

    const-string v2, "token"

    invoke-static {v1, v2}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_c

    const-string v1, "access_token"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v1, "id"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "token_refresh_interval_sec"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6

    new-instance v1, Lcom/facebook/accountkit/AccessToken;

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationId()Ljava/lang/String;

    move-result-object v5

    new-instance v8, Ljava/util/Date;

    invoke-direct {v8}, Ljava/util/Date;-><init>()V

    move-object v2, v1

    invoke-direct/range {v2 .. v8}, Lcom/facebook/accountkit/AccessToken;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/util/Date;)V

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iget-object v2, v2, Lcom/facebook/accountkit/internal/EmailLoginController;->accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

    invoke-virtual {v2, v1}, Lcom/facebook/accountkit/internal/AccessTokenManager;->setCurrentAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    const-string v2, "state"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2, p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setFinalAuthState(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    :goto_0
    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    goto :goto_1

    :cond_c
    const-string v1, "code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setCode(Ljava/lang/String;)V

    const-string v1, "state"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setFinalAuthState(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    :catch_0
    :try_start_5
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/EmailLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :cond_d
    :goto_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz p1, :cond_e

    sget-object p1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_4

    return-void

    :pswitch_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_e
    return-void

    :catchall_0
    move-exception p1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    if-eqz v1, :cond_f

    sget-object v1, Lcom/facebook/accountkit/internal/EmailLoginController$3;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_5

    goto :goto_2

    :pswitch_5
    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_f
    :goto_2
    throw p1

    :cond_10
    :goto_3
    invoke-static {}, Lcom/facebook/accountkit/internal/EmailLoginController;->access$000()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Warning: Callback issues while activity not available."

    invoke-static {p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_2
        :pswitch_2
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0x1
        :pswitch_4
        :pswitch_4
    .end packed-switch

    :pswitch_data_5
    .packed-switch 0x1
        :pswitch_5
        :pswitch_5
    .end packed-switch
.end method
