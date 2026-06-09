.class final Lcom/facebook/accountkit/ui/ActivityEmailHandler;
.super Lcom/facebook/accountkit/ui/ActivityHandler;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/ActivityEmailHandler;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$3;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/ActivityEmailHandler$3;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityHandler;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/AccountKitConfiguration;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityHandler;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/ui/ActivityEmailHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->emailVerifySetRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method

.method private emailVerifySetRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object p1

    instance-of v0, p1, Lcom/facebook/accountkit/ui/EmailLoginContentController;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->setRetry()V

    return-void
.end method

.method private getEmailTracker()Lcom/facebook/accountkit/EmailLoginTracker;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->tracker:Lcom/facebook/accountkit/Tracker;

    check-cast v0, Lcom/facebook/accountkit/EmailLoginTracker;

    return-object v0
.end method


# virtual methods
.method public getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/EmailLoginTracker;
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->getEmailTracker()Lcom/facebook/accountkit/EmailLoginTracker;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$1;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler$1;-><init>(Lcom/facebook/accountkit/ui/ActivityEmailHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->tracker:Lcom/facebook/accountkit/Tracker;

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->getEmailTracker()Lcom/facebook/accountkit/EmailLoginTracker;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/Tracker;
    .locals 0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/EmailLoginTracker;

    move-result-object p1

    return-object p1
.end method

.method public onAccountVerifiedComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method public onEmailLoginComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/EmailLoginFlowManager;Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    invoke-virtual {p2, p3}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->setEmail(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getResponseType()Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    move-result-object p1

    iget-object p3, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p3}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getInitialAuthState()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p1, p3}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->logInWithEmail(Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;Ljava/lang/String;)V

    return-void
.end method

.method public onEmailVerifyRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->cancelLogin()V

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v1, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;

    invoke-direct {v1, p0, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;-><init>(Lcom/facebook/accountkit/ui/ActivityEmailHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method public onSentCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v0, v0, Lcom/facebook/accountkit/ui/SentCodeContentController;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_VERIFY:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ActivityHandler;->writeToParcel(Landroid/os/Parcel;I)V

    return-void
.end method
