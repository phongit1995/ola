.class public final Lcom/facebook/accountkit/ui/AccountKitActivity;
.super Lcom/facebook/accountkit/ui/AccountKitActivityBase;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;,
        Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
    }
.end annotation


# static fields
.field private static final LOGIN_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;

.field private static final LOGIN_FLOW_MANAGER_KEY:Ljava/lang/String;

.field private static final PENDING_LOGIN_FLOW_STATE_KEY:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "AccountKitActivity"

.field private static final TRACKING_SMS_KEY:Ljava/lang/String;


# instance fields
.field private accessToken:Lcom/facebook/accountkit/AccessToken;

.field private authorizationCode:Ljava/lang/String;

.field private error:Lcom/facebook/accountkit/AccountKitError;

.field private finalAuthState:Ljava/lang/String;

.field private isActive:Z

.field private final loginFlowBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private loginTracker:Lcom/facebook/accountkit/Tracker;

.field private mCredentialsApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

.field private result:Lcom/facebook/accountkit/LoginResult;

.field private stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

.field private tokenRefreshIntervalInSeconds:J

.field private final viewState:Landroid/os/Bundle;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".loginFlowManager"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->LOGIN_FLOW_MANAGER_KEY:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".pendingLoginFlowState"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->PENDING_LOGIN_FLOW_STATE_KEY:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".trackingSms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->TRACKING_SMS_KEY:Ljava/lang/String;

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->getIntentFilter()Landroid/content/IntentFilter;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->LOGIN_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/LoginResult;->CANCELLED:Lcom/facebook/accountkit/LoginResult;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->result:Lcom/facebook/accountkit/LoginResult;

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/AccountKitActivity$1;-><init>(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowBroadcastReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/StateStackManager;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    return-object p0
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    return-object p0
.end method

.method private backPressed()V
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    instance-of v1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz v1, :cond_1

    move-object v1, v0

    check-cast v1, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->setRetry(Z)V

    :cond_1
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onContentControllerDismissed(Lcom/facebook/accountkit/ui/ContentController;)V

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/ContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/ui/LoginFlowState;->getBackState(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v2

    sget-object v3, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result v4

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    :goto_0
    invoke-direct {p0, v1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->resetFlowTo(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;)V

    return-void

    :pswitch_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void

    :pswitch_1
    check-cast v0, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginErrorContentController;->getReturnState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    goto :goto_0

    :pswitch_2
    invoke-direct {p0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->resetFlowTo(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;)V

    return-void

    :pswitch_3
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendCancelResult()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private logContentControllerDismissed(Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-nez v0, :cond_0

    return-void

    :cond_0
    instance-of v0, p1, Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIPhoneLogin()V

    return-void

    :cond_1
    instance-of v0, p1, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUISendingCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void

    :cond_2
    instance-of v0, p1, Lcom/facebook/accountkit/ui/SentCodeContentController;

    if-eqz v0, :cond_3

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUISentCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void

    :cond_3
    instance-of v0, p1, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz v0, :cond_4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIConfirmationCode()V

    return-void

    :cond_4
    instance-of v0, p1, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    if-eqz v0, :cond_5

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIVerifyingCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void

    :cond_5
    instance-of v0, p1, Lcom/facebook/accountkit/ui/VerifiedCodeContentController;

    if-eqz v0, :cond_6

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIVerifiedCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void

    :cond_6
    instance-of v0, p1, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    if-eqz v0, :cond_7

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIError(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void

    :cond_7
    instance-of v0, p1, Lcom/facebook/accountkit/ui/EmailLoginContentController;

    if-eqz v0, :cond_8

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIEmailLogin()V

    return-void

    :cond_8
    instance-of v0, p1, Lcom/facebook/accountkit/ui/EmailVerifyContentController;

    if-eqz v0, :cond_9

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIEmailVerify(Z)V

    return-void

    :cond_9
    instance-of v0, p1, Lcom/facebook/accountkit/ui/ResendContentController;

    if-eqz v0, :cond_a

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIResend(Z)V

    return-void

    :cond_a
    instance-of v0, p1, Lcom/facebook/accountkit/ui/ConfirmAccountVerifiedContentController;

    if-eqz v0, :cond_b

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIConfirmAccountVerified(Z)V

    return-void

    :cond_b
    instance-of v0, p1, Lcom/facebook/accountkit/ui/AccountVerifiedContentController;

    if-eqz v0, :cond_c

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIAccountVerified(Z)V

    return-void

    :cond_c
    new-instance v0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_FRAGMENT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, v1, v2, p1}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/String;)V

    throw v0
.end method

.method private onViewReadyWithState(Landroid/os/Bundle;Z)V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->LOGIN_FLOW_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setNewLoginFlowManagerAndHandler(Lcom/facebook/accountkit/ui/LoginFlowManager;)V

    if-eqz p2, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {p1, p0}, Lcom/facebook/accountkit/ui/StateStackManager;->updateContentController(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-nez p1, :cond_1

    return-void

    :cond_1
    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object p2

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result p2

    aget p1, p1, p2

    const/4 p2, 0x0

    packed-switch p1, :pswitch_data_0

    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object p2, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p1, p2, v0}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void

    :pswitch_0
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    goto :goto_0

    :pswitch_1
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    :goto_0
    invoke-virtual {p0, p1, p2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private resetFlowTo(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0, p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->setFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitActivity$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/AccountKitActivity$2;-><init>(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-eq p1, v1, :cond_0

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setNewLoginFlowManagerAndHandler(Lcom/facebook/accountkit/ui/LoginFlowManager;)V

    :cond_0
    invoke-virtual {p0, p2, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method private sendResult(ILcom/facebook/accountkit/AccountKitLoginResult;)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getCallingActivity()Landroid/content/ComponentName;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getPackageName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->startActivity(Landroid/content/Intent;)V

    :goto_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->finish()V

    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "account_kit_log_in_result"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    invoke-virtual {p0, p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setResult(ILandroid/content/Intent;)V

    goto :goto_0
.end method

.method private static urlIsRedirectUrl(Ljava/lang/String;)Z
    .locals 1
    .param p0    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getRedirectURL()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method


# virtual methods
.method getContentController()Lcom/facebook/accountkit/ui/ContentController;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    return-object v0
.end method

.method public getCurrentState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->mCredentialsApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    return-object v0
.end method

.method multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/StateStackManager;->multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onActivityResult(IILandroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentController;->onActivityResult(IILandroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onBackPressed()V

    return-void

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->backPressed()V

    return-void
.end method

.method public onBackPressed(Landroid/view/View;)V
    .locals 0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onBackPressed()V

    return-void
.end method

.method public onCancelPressed(Landroid/view/View;)V
    .locals 0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendCancelResult()V

    return-void
.end method

.method onContentControllerDismissed(Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 0

    if-eqz p1, :cond_0

    invoke-interface {p1, p0}, Lcom/facebook/accountkit/ui/ContentController;->onPause(Landroid/app/Activity;)V

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->logContentControllerDismissed(Lcom/facebook/accountkit/ui/ContentController;)V

    :cond_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->urlIsRedirectUrl(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getResponseType()Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    move-result-object v0

    if-nez v0, :cond_2

    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_RESPONSE_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p1, v0, v1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void

    :cond_2
    new-instance v0, Lcom/facebook/accountkit/ui/StateStackManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, p0, v1}, Lcom/facebook/accountkit/ui/StateStackManager;-><init>(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/AccountKit;->onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    if-eqz p1, :cond_3

    const/4 p1, 0x1

    goto :goto_0

    :cond_3
    const/4 p1, 0x0

    :goto_0
    invoke-direct {p0, v0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onViewReadyWithState(Landroid/os/Bundle;Z)V

    invoke-static {p0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowBroadcastReceiver:Landroid/content/BroadcastReceiver;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->LOGIN_FLOW_BROADCAST_RECEIVER_FILTER:Landroid/content/IntentFilter;

    invoke-virtual {p1, v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    new-instance p1, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    invoke-direct {p1, p0}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;-><init>(Landroid/content/Context;)V

    sget-object v0, Lcom/google/android/gms/auth/api/Auth;->CREDENTIALS_API:Lcom/google/android/gms/common/api/Api;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->addApi(Lcom/google/android/gms/common/api/Api;)Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->build()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->mCredentialsApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    return-void

    :cond_4
    :goto_1
    new-instance p1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p1, v0, v1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    invoke-static {p0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/support/v4/content/LocalBroadcastManager;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onDestroy()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/Tracker;->stopTracking()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->stopSmsTracker()V

    :cond_1
    invoke-static {p0}, Lcom/facebook/accountkit/AccountKit;->onActivityDestroy(Landroid/app/Activity;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->backPressed()V

    const/4 p1, 0x1

    return p1
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onNewIntent(Landroid/content/Intent;)V

    invoke-virtual {p1}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->urlIsRedirectUrl(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p1

    instance-of p1, p1, Lcom/facebook/accountkit/ui/EmailVerifyContentController;

    if-eqz p1, :cond_2

    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFYING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    :cond_2
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 2

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-eq v0, v1, :cond_0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p1

    return p1

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->onBackPressed()V

    const/4 p1, 0x1

    return p1
.end method

.method public onPause()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onPause()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p0}, Lcom/facebook/accountkit/ui/ContentController;->onPause(Landroid/app/Activity;)V

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->isActive:Z

    return-void
.end method

.method protected onResume()V
    .locals 4

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onResume()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p0}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->isActive:Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    if-nez v0, :cond_1

    return-void

    :cond_1
    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/facebook/accountkit/ui/ActivityHandler;->getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/Tracker;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/Tracker;->startTracking()V

    :goto_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-eq v0, v1, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->TRACKING_SMS_KEY:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_2
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    invoke-virtual {v0, p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->startSmsTrackerIfPossible(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    :cond_3
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->PENDING_LOGIN_FLOW_STATE_KEY:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity;->PENDING_LOGIN_FLOW_STATE_KEY:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/facebook/accountkit/ui/LoginFlowState;->valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    invoke-virtual {p0, v0, v3}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    invoke-static {p0, p1}, Lcom/facebook/accountkit/AccountKit;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity;->TRACKING_SMS_KEY:Ljava/lang/String;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->isSmsTracking()Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->pauseSmsTracker()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity;->LOGIN_FLOW_MANAGER_KEY:Ljava/lang/String;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginTracker:Lcom/facebook/accountkit/Tracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/Tracker;->pauseTracking()V

    :cond_1
    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onStart()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onStart()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->mCredentialsApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    invoke-virtual {v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->connect()V

    return-void
.end method

.method protected onStop()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/AccountKitActivityBase;->onStop()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->mCredentialsApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    invoke-virtual {v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->disconnect()V

    return-void
.end method

.method popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/LoginFlowState;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v0, p1, p2}, Lcom/facebook/accountkit/ui/StateStackManager;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method pushError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 8
    .param p1    # Lcom/facebook/accountkit/AccountKitError;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError;->getUserFacingMessage()Ljava/lang/String;

    move-result-object v0

    :goto_0
    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/ui/LoginFlowState;->getBackState(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v5

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->setFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    iget-object v2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    iget-object v4, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    invoke-virtual {v1, v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getErrorOnPushListener(Ljava/lang/String;)Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;

    move-result-object v7

    move-object v3, p0

    move-object v6, p1

    invoke-virtual/range {v2 .. v7}, Lcom/facebook/accountkit/ui/StateStackManager;->pushError(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/AccountKitError;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V
    .locals 3
    .param p2    # Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->isActive:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->setFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    if-nez p2, :cond_2

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result v2

    aget v0, v0, v2

    const/4 v2, 0x6

    if-eq v0, v2, :cond_1

    const/16 v2, 0xd

    if-eq v0, v2, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_1
    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    invoke-virtual {p2, p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getConfirmationCodePushListener(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;

    move-result-object p2

    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->stateStackManager:Lcom/facebook/accountkit/ui/StateStackManager;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0, p0, v2, p2}, Lcom/facebook/accountkit/ui/StateStackManager;->pushState(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    goto :goto_1

    :cond_3
    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->viewState:Landroid/os/Bundle;

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity;->PENDING_LOGIN_FLOW_STATE_KEY:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    sget-object p2, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/LoginFlowState;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_4

    iput-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    :cond_4
    return-void
.end method

.method sendCancelResult()V
    .locals 9

    new-instance v8, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const-wide/16 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x1

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Ljava/lang/String;JLcom/facebook/accountkit/AccountKitError;Z)V

    const/4 v0, 0x0

    invoke-direct {p0, v0, v8}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult(ILcom/facebook/accountkit/AccountKitLoginResult;)V

    return-void
.end method

.method sendResult()V
    .locals 10

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->result:Lcom/facebook/accountkit/LoginResult;

    sget-object v1, Lcom/facebook/accountkit/LoginResult;->SUCCESS:Lcom/facebook/accountkit/LoginResult;

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    new-instance v9, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->accessToken:Lcom/facebook/accountkit/AccessToken;

    iget-object v3, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->authorizationCode:Ljava/lang/String;

    iget-object v4, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->finalAuthState:Ljava/lang/String;

    iget-wide v5, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->tokenRefreshIntervalInSeconds:J

    iget-object v7, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->error:Lcom/facebook/accountkit/AccountKitError;

    const/4 v8, 0x0

    move-object v1, v9

    invoke-direct/range {v1 .. v8}, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Ljava/lang/String;JLcom/facebook/accountkit/AccountKitError;Z)V

    invoke-direct {p0, v0, v9}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult(ILcom/facebook/accountkit/AccountKitLoginResult;)V

    return-void
.end method

.method setAccessToken(Lcom/facebook/accountkit/AccessToken;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->accessToken:Lcom/facebook/accountkit/AccessToken;

    return-void
.end method

.method setAuthorizationCode(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->authorizationCode:Ljava/lang/String;

    return-void
.end method

.method setFinalAuthState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->finalAuthState:Ljava/lang/String;

    return-void
.end method

.method setLoginResult(Lcom/facebook/accountkit/LoginResult;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->result:Lcom/facebook/accountkit/LoginResult;

    return-void
.end method

.method setNewLoginFlowManagerAndHandler(Lcom/facebook/accountkit/ui/LoginFlowManager;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    if-nez v0, :cond_0

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    :goto_0
    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->cancel()V

    :cond_1
    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result v1

    aget p1, p1, v1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    new-instance p1, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p1, v1}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_1

    :pswitch_1
    new-instance p1, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {p1, v1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    :goto_1
    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->loginFlowManager:Lcom/facebook/accountkit/ui/LoginFlowManager;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/LoginFlowManager;->setFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method setTokenRefreshIntervalInSeconds(J)V
    .locals 0

    iput-wide p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity;->tokenRefreshIntervalInSeconds:J

    return-void
.end method
