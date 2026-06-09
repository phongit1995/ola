.class Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;
.super Lcom/facebook/accountkit/PhoneLoginTracker;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/PhoneLoginTracker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

.field final synthetic val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {p0}, Lcom/facebook/accountkit/PhoneLoginTracker;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;)V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->finishActivity()V

    return-void
.end method

.method private finishActivity()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->sendResult()V

    return-void
.end method


# virtual methods
.method protected onAccountVerified(Lcom/facebook/accountkit/PhoneLoginModel;)V
    .locals 2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p1

    instance-of p1, p1, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method protected onCancel(Lcom/facebook/accountkit/PhoneLoginModel;)V
    .locals 1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setNewLoginFlowManagerAndHandler(Lcom/facebook/accountkit/ui/LoginFlowManager;)V

    return-void
.end method

.method protected onError(Lcom/facebook/accountkit/AccountKitException;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitException;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method protected onStarted(Lcom/facebook/accountkit/PhoneLoginModel;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    if-nez v1, :cond_0

    instance-of v0, v0, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {p1}, Lcom/facebook/accountkit/PhoneLoginModel;->getNotificationChannel()Lcom/facebook/accountkit/ui/NotificationChannel;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->SMS:Lcom/facebook/accountkit/ui/NotificationChannel;

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->startSmsTrackerIfPossible(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    :cond_1
    if-eqz v1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENT_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1$1;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1$1;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;)V

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method protected onSuccess(Lcom/facebook/accountkit/PhoneLoginModel;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-nez v1, :cond_0

    instance-of v0, v0, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-interface {p1}, Lcom/facebook/accountkit/PhoneLoginModel;->getCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setAuthorizationCode(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-interface {p1}, Lcom/facebook/accountkit/PhoneLoginModel;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v1, Lcom/facebook/accountkit/LoginResult;->SUCCESS:Lcom/facebook/accountkit/LoginResult;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setLoginResult(Lcom/facebook/accountkit/LoginResult;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-interface {p1}, Lcom/facebook/accountkit/PhoneLoginModel;->getFinalAuthState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setFinalAuthState(Ljava/lang/String;)V

    invoke-interface {p1}, Lcom/facebook/accountkit/PhoneLoginModel;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccessToken;->getTokenRefreshIntervalSeconds()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->setTokenRefreshIntervalInSeconds(J)V

    :cond_1
    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1$2;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;)V

    const-wide/16 v1, 0x7d0

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
