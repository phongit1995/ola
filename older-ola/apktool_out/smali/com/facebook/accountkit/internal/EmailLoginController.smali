.class final Lcom/facebook/accountkit/internal/EmailLoginController;
.super Lcom/facebook/accountkit/internal/LoginController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/facebook/accountkit/internal/LoginController<",
        "Lcom/facebook/accountkit/internal/EmailLoginModelImpl;",
        ">;"
    }
.end annotation


# static fields
.field private static final PARAMETER_EMAIL:Ljava/lang/String; = "email"

.field private static final SECONDS_TO_MILLIS:I = 0x3e8

.field private static final TAG:Ljava/lang/String; = "com.facebook.accountkit.internal.EmailLoginController"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/internal/AccessTokenManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/facebook/accountkit/internal/LoginController;-><init>(Lcom/facebook/accountkit/internal/AccessTokenManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/EmailLoginController;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/internal/EmailLoginController;->createPolling(Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;

    move-result-object p0

    return-object p0
.end method

.method private createPolling(Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getRequestInstanceToken()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/internal/EmailLoginController$2;

    invoke-direct {v1, p0, p1, p2, v0}, Lcom/facebook/accountkit/internal/EmailLoginController$2;-><init>(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method protected getCredentialsType()Ljava/lang/String;
    .locals 1

    const-string v0, "email"

    return-object v0
.end method

.method protected getLoginStateChangedIntentName()Ljava/lang/String;
    .locals 1

    const-string v0, "com.facebook.accountkit.sdk.ACTION_EMAIL_LOGIN_STATE_CHANGED"

    return-object v0
.end method

.method public logIn(Ljava/lang/String;)V
    .locals 5
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/internal/EmailLoginController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/internal/EmailLoginController$1;-><init>(Lcom/facebook/accountkit/internal/EmailLoginController;)V

    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    const-string v2, "email"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getEmail()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "redirect_uri"

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getRedirectURL()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "state"

    invoke-static {v1, v2, p1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "response_type"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fields"

    const-string v3, "terms_of_service,privacy_policy"

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/LoginManager;->isSeamlessLoginRunning()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/LoginManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v2

    const-string v3, "ak_fetch_seamless_login_token"

    const-string v4, "not_completed"

    invoke-virtual {v2, v3, v4}, Lcom/facebook/accountkit/internal/InternalLogger;->logFetchEvent(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v3, "fb_user_token"

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/LoginManager;->getSeamlessLoginToken()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v3, v2}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    :goto_0
    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2, p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setInitialAuthState(Ljava/lang/String;)V

    const-string p1, "start_login"

    invoke-virtual {p0, p1, v1}, Lcom/facebook/accountkit/internal/EmailLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object p1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method

.method public onAccountVerified()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Validate;->loginModelInProgress(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/LoginManager;->onSeamlessLoginPending(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    new-instance v1, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;

    invoke-direct {v1, p0, v0}, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;-><init>(Lcom/facebook/accountkit/internal/LoginController;Lcom/facebook/accountkit/internal/LoginManager;)V

    new-instance v2, Landroid/os/Bundle;

    invoke-direct {v2}, Landroid/os/Bundle;-><init>()V

    const-string v3, "fb_user_token"

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getSeamlessLoginTokenRegardlessTimeOut()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v3, v0}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "email"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getEmail()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "response_type"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "state"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getInitialAuthState()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "instant_verification_login"

    invoke-virtual {p0, v0, v2}, Lcom/facebook/accountkit/internal/EmailLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method

.method public onCancel()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->CANCELLED:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/EmailLoginController;->broadcastLoginStateChange()V

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    return-void
.end method

.method public onPending()V
    .locals 4

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    new-instance v0, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-direct {v0, p0, v1}, Lcom/facebook/accountkit/internal/EmailLoginController$LoginModelCodeCallback;-><init>(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-direct {p0, v1, v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->createPolling(Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getInterval()I

    move-result v2

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
