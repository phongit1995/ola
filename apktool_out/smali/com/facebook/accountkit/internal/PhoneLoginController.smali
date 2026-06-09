.class final Lcom/facebook/accountkit/internal/PhoneLoginController;
.super Lcom/facebook/accountkit/internal/LoginController;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/facebook/accountkit/internal/LoginController<",
        "Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;",
        ">;"
    }
.end annotation


# static fields
.field private static final PARAMETER_CONFIRMATION_CODE:Ljava/lang/String; = "confirmation_code"

.field private static final PARAMETER_PHONE:Ljava/lang/String; = "phone_number"

.field private static final PARAMETER_USER_TOKEN:Ljava/lang/String; = "fb_user_token"

.field private static final TAG:Ljava/lang/String; = "com.facebook.accountkit.internal.PhoneLoginController"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/internal/AccessTokenManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/facebook/accountkit/internal/LoginController;-><init>(Lcom/facebook/accountkit/internal/AccessTokenManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method private static createSmsToken(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-static {p0}, Lcom/facebook/accountkit/internal/Utility;->hasGooglePlayServices(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/facebook/accountkit/internal/PackageUtils;->computePackageHash(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/16 v2, 0xb

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0}, Lcom/google/android/gms/auth/api/phone/SmsRetriever;->getClient(Landroid/content/Context;)Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;

    move-result-object p0

    invoke-virtual {p0}, Lcom/google/android/gms/auth/api/phone/SmsRetrieverClient;->startSmsRetriever()Lcom/google/android/gms/tasks/Task;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method protected getCredentialsType()Ljava/lang/String;
    .locals 1

    const-string v0, "phone_number"

    return-object v0
.end method

.method protected getLoginStateChangedIntentName()Ljava/lang/String;
    .locals 1

    const-string v0, "com.facebook.accountkit.sdk.ACTION_PHONE_LOGIN_STATE_CHANGED"

    return-object v0
.end method

.method public logIn(Ljava/lang/String;)V
    .locals 5
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/internal/PhoneLoginController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/internal/PhoneLoginController$1;-><init>(Lcom/facebook/accountkit/internal/PhoneLoginController;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Landroid/os/Bundle;

    invoke-direct {v2}, Landroid/os/Bundle;-><init>()V

    const-string v3, "phone_number"

    invoke-static {v2, v3, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "state"

    invoke-static {v2, v1, p1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "response_type"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v1, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "fields"

    const-string v3, "terms_of_service,privacy_policy"

    invoke-static {v2, v1, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/internal/PhoneLoginController$3;->$SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getNotificationChannel()Lcom/facebook/accountkit/ui/NotificationChannel;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/ui/NotificationChannel;->ordinal()I

    move-result v3

    aget v1, v1, v3

    packed-switch v1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    const-string v1, "notif_medium"

    const-string v3, "voice"

    goto :goto_0

    :pswitch_1
    const-string v1, "notif_medium"

    const-string v3, "facebook"

    :goto_0
    invoke-static {v2, v1, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->createSmsToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v3, "sms_token"

    invoke-static {v2, v3, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginManager;->isSeamlessLoginRunning()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v1

    const-string v3, "ak_fetch_seamless_login_token"

    const-string v4, "not_completed"

    invoke-virtual {v1, v3, v4}, Lcom/facebook/accountkit/internal/InternalLogger;->logFetchEvent(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    :cond_1
    const-string v3, "fb_user_token"

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginManager;->getSeamlessLoginToken()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v3, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    :goto_2
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setInitialAuthState(Ljava/lang/String;)V

    const-string p1, "start_login"

    invoke-virtual {p0, p1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object p1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onAccountVerified()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Validate;->loginModelInProgress(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/LoginManager;->onSeamlessLoginPending(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    new-instance v1, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;

    invoke-direct {v1, p0, v0}, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;-><init>(Lcom/facebook/accountkit/internal/LoginController;Lcom/facebook/accountkit/internal/LoginManager;)V

    new-instance v2, Landroid/os/Bundle;

    invoke-direct {v2}, Landroid/os/Bundle;-><init>()V

    const-string v3, "fb_user_token"

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getSeamlessLoginTokenRegardlessTimeOut()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v3, v0}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "phone_number"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "response_type"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "state"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getInitialAuthState()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "instant_verification_login"

    invoke-virtual {p0, v0, v2}, Lcom/facebook/accountkit/internal/PhoneLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method

.method public onCancel()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v0, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->CANCELLED:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    return-void
.end method

.method public onPending()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v0, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getConfirmationCode()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Validate;->loginModelInProgress(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginVerify(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    new-instance v1, Lcom/facebook/accountkit/internal/PhoneLoginController$2;

    invoke-direct {v1, p0, v0}, Lcom/facebook/accountkit/internal/PhoneLoginController$2;-><init>(Lcom/facebook/accountkit/internal/PhoneLoginController;Lcom/facebook/accountkit/internal/LoginManager;)V

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v2, "confirmation_code"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getConfirmationCode()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "phone_number"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v3, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "confirm_login"

    invoke-virtual {p0, v2, v0}, Lcom/facebook/accountkit/internal/PhoneLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method
