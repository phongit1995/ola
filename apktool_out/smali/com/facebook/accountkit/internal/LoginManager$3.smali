.class Lcom/facebook/accountkit/internal/LoginManager$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/LoginManager;->getCurrentAccount(Lcom/facebook/accountkit/AccountKitCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/LoginManager;

.field final synthetic val$accessToken:Lcom/facebook/accountkit/AccessToken;

.field final synthetic val$callback:Lcom/facebook/accountkit/AccountKitCallback;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/AccountKitCallback;Lcom/facebook/accountkit/AccessToken;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$accessToken:Lcom/facebook/accountkit/AccessToken;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 5

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_1
    :try_start_0
    const-string v0, "id"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "email"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    const-string v3, "address"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    move-object v1, v2

    :goto_0
    const-string v3, "phone"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    if-eqz p1, :cond_3

    const-string v3, "national_number"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "country_prefix"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_3
    move-object p1, v2

    move-object v3, p1

    :goto_1
    if-nez p1, :cond_4

    if-nez v3, :cond_4

    if-nez v1, :cond_4

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_ACCOUNT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_4
    if-nez p1, :cond_5

    if-nez v3, :cond_6

    :cond_5
    if-eqz p1, :cond_7

    if-nez v3, :cond_7

    :cond_6
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_ACCOUNT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_7
    if-eqz p1, :cond_8

    new-instance v4, Lcom/facebook/accountkit/PhoneNumber;

    invoke-direct {v4, p1, v3, v2}, Lcom/facebook/accountkit/PhoneNumber;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v2, v4

    :cond_8
    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p1

    if-eqz p1, :cond_9

    iget-object v3, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$accessToken:Lcom/facebook/accountkit/AccessToken;

    invoke-virtual {v3, p1}, Lcom/facebook/accountkit/AccessToken;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    iget-object v3, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/LoginManager;->access$200(Lcom/facebook/accountkit/internal/LoginManager;)Lcom/facebook/accountkit/internal/AccessTokenManager;

    move-result-object v3

    invoke-virtual {v3, p1}, Lcom/facebook/accountkit/internal/AccessTokenManager;->refreshCurrentAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    :cond_9
    new-instance p1, Lcom/facebook/accountkit/Account;

    invoke-direct {p1, v0, v2, v1}, Lcom/facebook/accountkit/Account;-><init>(Ljava/lang/String;Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/AccountKitCallback;->onSuccess(Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$3;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method
