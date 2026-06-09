.class final Lcom/facebook/accountkit/ui/ActivityPhoneHandler;
.super Lcom/facebook/accountkit/ui/ActivityHandler;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/ActivityPhoneHandler;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$9;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$9;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityHandler;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/AccountKitConfiguration;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityHandler;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->popToPhoneNumberInput(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method

.method static synthetic access$200(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->resendSetRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method

.method static synthetic access$300(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;)Lcom/facebook/accountkit/PhoneLoginTracker;
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getPhoneTracker()Lcom/facebook/accountkit/PhoneLoginTracker;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;)Lcom/facebook/accountkit/ui/SmsTracker;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    return-object p0
.end method

.method private getPhoneTracker()Lcom/facebook/accountkit/PhoneLoginTracker;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->tracker:Lcom/facebook/accountkit/Tracker;

    check-cast v0, Lcom/facebook/accountkit/PhoneLoginTracker;

    return-object v0
.end method

.method private getResendOnPushListener()Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v1

    :goto_0
    if-nez v2, :cond_1

    return-object v1

    :cond_1
    new-instance v1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;

    invoke-direct {v1, p0, v2, v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Ljava/lang/String;Lcom/facebook/accountkit/PhoneLoginModel;)V

    return-object v1
.end method

.method private popToPhoneNumberInput(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/ResendContentController;

    if-eqz v1, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$3;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$3;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void

    :cond_0
    instance-of v0, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$4;

    invoke-direct {v1, p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$4;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    :cond_1
    return-void
.end method

.method private resendSetRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    if-nez v1, :cond_0

    return-void

    :cond_0
    move-object v1, v0

    check-cast v1, Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->setRetry()V

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    return-void
.end method


# virtual methods
.method getConfirmationCodePushListener(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$7;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$7;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-object v0
.end method

.method public getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/PhoneLoginTracker;
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getPhoneTracker()Lcom/facebook/accountkit/PhoneLoginTracker;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$1;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->tracker:Lcom/facebook/accountkit/Tracker;

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getPhoneTracker()Lcom/facebook/accountkit/PhoneLoginTracker;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/Tracker;
    .locals 0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getLoginTracker(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/PhoneLoginTracker;

    move-result-object p1

    return-object p1
.end method

.method getSmsTracker()Lcom/facebook/accountkit/ui/SmsTracker;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    return-object v0
.end method

.method isSmsTracking()Z
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/SmsTracker;->isTracking()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public onAccountVerifiedComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method onConfirmationCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFYING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    invoke-virtual {p2, p3}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->setConfirmationCode(Ljava/lang/String;)V

    return-void
.end method

.method onConfirmationCodeRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getResendOnPushListener()Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method onPhoneLoginComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->SMS:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p2, v0}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->setNotificationChannel(Lcom/facebook/accountkit/ui/NotificationChannel;)V

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    sget-object p1, Lcom/facebook/accountkit/ui/NotificationChannel;->SMS:Lcom/facebook/accountkit/ui/NotificationChannel;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getResponseType()Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getInitialAuthState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, p3, p1, v0, v1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->logInWithPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/ui/NotificationChannel;Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;Ljava/lang/String;)V

    return-void
.end method

.method onResend(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->cancelLogin()V

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->popToPhoneNumberInput(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method

.method onResendFacebookNotification(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p2, v1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->setNotificationChannel(Lcom/facebook/accountkit/ui/NotificationChannel;)V

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;

    invoke-direct {v1, p0, p1, p2, v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Lcom/facebook/accountkit/PhoneNumber;)V

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method onResendVoiceCallNotification(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p2, v1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->setNotificationChannel(Lcom/facebook/accountkit/ui/NotificationChannel;)V

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$6;

    invoke-direct {v1, p0, p1, p2, v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$6;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Lcom/facebook/accountkit/PhoneNumber;)V

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->multiPopBackStack(Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method

.method public onSentCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->pushState(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;)V

    return-void
.end method

.method pauseSmsTracker()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/SmsTracker;->pauseTracking()V

    :cond_0
    return-void
.end method

.method startSmsTrackerIfPossible(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/SmsTracker;->canTrackSms(Landroid/content/Context;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    if-nez v0, :cond_1

    new-instance v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SmsTracker;->startTracking()V

    return-void
.end method

.method stopSmsTracker()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->smsTracker:Lcom/facebook/accountkit/ui/SmsTracker;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/SmsTracker;->stopTracking()V

    :cond_0
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ActivityHandler;->writeToParcel(Landroid/os/Parcel;I)V

    return-void
.end method
