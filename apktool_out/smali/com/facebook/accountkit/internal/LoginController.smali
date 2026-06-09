.class abstract Lcom/facebook/accountkit/internal/LoginController;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E:",
        "Lcom/facebook/accountkit/internal/LoginModelImpl;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# static fields
.field static final GRAPH_PATH_LOGIN_REQUEST_CONFIRM:Ljava/lang/String; = "confirm_login"

.field static final GRAPH_PATH_LOGIN_REQUEST_STATUS:Ljava/lang/String; = "poll_login"

.field static final GRAPH_PATH_LOGIN_START:Ljava/lang/String; = "start_login"

.field static final GRAPH_PATH_SEAMLESS_REQUEST_CONFIRM:Ljava/lang/String; = "instant_verification_login"

.field static final PARAMETER_ARGUMENT_FACEBOOK:Ljava/lang/String; = "facebook"

.field static final PARAMETER_ARGUMENT_VOICE:Ljava/lang/String; = "voice"

.field private static final PARAMETER_CREDENTIALS_TYPE:Ljava/lang/String; = "credentials_type"

.field static final PARAMETER_FB_USER_TOKEN:Ljava/lang/String; = "fb_user_token"

.field static final PARAMETER_FIELDS_TYPE:Ljava/lang/String; = "fields"

.field private static final PARAMETER_LOGGING_REF:Ljava/lang/String; = "logging_ref"

.field private static final PARAMETER_LOGIN_REQUEST_CODE:Ljava/lang/String; = "login_request_code"

.field static final PARAMETER_REDIRECT_URI:Ljava/lang/String; = "redirect_uri"

.field static final PARAMETER_RESPONSE_TYPE:Ljava/lang/String; = "response_type"

.field static final PARAMETER_STATE:Ljava/lang/String; = "state"

.field private static final TAG:Ljava/lang/String; = "com.facebook.accountkit.internal.LoginController"


# instance fields
.field final accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

.field private final loginManagerRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/facebook/accountkit/internal/LoginManager;",
            ">;"
        }
    .end annotation
.end field

.field protected final loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TE;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/internal/AccessTokenManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/LoginModelImpl;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/internal/AccessTokenManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/facebook/accountkit/internal/LoginManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/facebook/accountkit/internal/LoginModelImpl;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/facebook/accountkit/internal/AccessTokenManager;",
            "Lcom/facebook/accountkit/internal/LoginManager;",
            "TE;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginController;->accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginManagerRef:Ljava/lang/ref/WeakReference;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginController;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method private isLoginRequestPath(Ljava/lang/String;)Z
    .locals 1

    const-string v0, "start_login"

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "poll_login"

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "confirm_login"

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method broadcastLoginStateChange()V
    .locals 4

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getLoginStateChangedIntentName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "com.facebook.accountkit.sdk.EXTRA_LOGIN_MODEL"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "com.facebook.accountkit.sdk.EXTRA_LOGIN_STATUS"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "com.facebook.accountkit.sdk.EXTRA_LOGIN_ERROR"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method

.method buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;
    .locals 6

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    const-string v0, "credentials_type"

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getCredentialsType()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v0, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "login_request_code"

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getLoginRequestCode()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v0, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "logging_ref"

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/InternalLogger;->getLoggingRef()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v3, v0, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3, p2}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    new-instance p2, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    const/4 v1, 0x0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/LoginController;->isLoginRequestPath(Ljava/lang/String;)Z

    move-result v4

    sget-object v5, Lcom/facebook/accountkit/internal/HttpMethod;->POST:Lcom/facebook/accountkit/internal/HttpMethod;

    move-object v0, p2

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Landroid/os/Bundle;ZLcom/facebook/accountkit/internal/HttpMethod;)V

    return-object p2
.end method

.method extractAccessTokenOrCodeIntoModel(Lorg/json/JSONObject;)V
    .locals 8

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "token"

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "access_token"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v0, "id"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v0, "token_refresh_interval_sec"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5

    new-instance v0, Lcom/facebook/accountkit/AccessToken;

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationId()Ljava/lang/String;

    move-result-object v4

    new-instance v7, Ljava/util/Date;

    invoke-direct {v7}, Ljava/util/Date;-><init>()V

    move-object v1, v0

    invoke-direct/range {v1 .. v7}, Lcom/facebook/accountkit/AccessToken;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/util/Date;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginController;->accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

    invoke-virtual {v1, v0}, Lcom/facebook/accountkit/internal/AccessTokenManager;->setCurrentAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    const-string v1, "state"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setFinalAuthState(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    return-void

    :cond_0
    const-string v0, "code"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v1, v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setCode(Ljava/lang/String;)V

    const-string v0, "state"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setFinalAuthState(Ljava/lang/String;)V

    goto :goto_0

    return-void
.end method

.method protected abstract getCredentialsType()Ljava/lang/String;
.end method

.method getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginManagerRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/internal/LoginManager;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result v2

    if-nez v2, :cond_1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginController;->TAG:Ljava/lang/String;

    const-string v2, "Warning: Callback issues while activity not available."

    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-object v1

    :cond_1
    return-object v0
.end method

.method public getLoginModel()Lcom/facebook/accountkit/internal/LoginModelImpl;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    return-object v0
.end method

.method protected abstract getLoginStateChangedIntentName()Ljava/lang/String;
.end method

.method public abstract logIn(Ljava/lang/String;)V
.end method

.method public abstract onAccountVerified()V
.end method

.method public abstract onCancel()V
.end method

.method protected onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {v0, p1, p2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/internal/LoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method public onError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/LoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->cancel(Lcom/facebook/accountkit/LoginModel;)V

    return-void
.end method

.method public abstract onPending()V
.end method
