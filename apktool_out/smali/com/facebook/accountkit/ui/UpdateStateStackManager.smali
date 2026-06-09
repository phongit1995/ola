.class final Lcom/facebook/accountkit/ui/UpdateStateStackManager;
.super Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;


# static fields
.field private static final COMPLETION_UI_DURATION_MS:I = 0x7d0


# instance fields
.field private final activityRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;",
            ">;"
        }
    .end annotation
.end field

.field private final configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

.field private contentController:Lcom/facebook/accountkit/ui/ContentController;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private final contentControllerMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/facebook/accountkit/ui/UpdateFlowState;",
            "Lcom/facebook/accountkit/ui/ContentController;",
            ">;"
        }
    .end annotation
.end field

.field private updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentControllerMap:Ljava/util/Map;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/UpdateStateStackManager;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->finishActivity(Ljava/lang/String;)V

    return-void
.end method

.method private ensureContentController(Lcom/facebook/accountkit/ui/UpdateFlowState;)Lcom/facebook/accountkit/ui/ContentController;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentControllerMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ContentController;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$2;->$SwitchMap$com$facebook$accountkit$ui$UpdateFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/UpdateFlowState;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-object v1

    :pswitch_0
    new-instance v0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/UpdateErrorContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_1
    new-instance v0, Lcom/facebook/accountkit/ui/VerifiedCodeContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/VerifiedCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_2
    new-instance v0, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/VerifyingCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_3
    new-instance v0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_4
    new-instance v0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_5
    new-instance v0, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/SendingCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    goto :goto_0

    :pswitch_6
    new-instance v0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    :goto_0
    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentControllerMap:Ljava/util/Map;

    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    :pswitch_7
    return-object v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private finishActivity(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->setFinalUpdateState(Ljava/lang/String;)V

    sget-object p1, Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;->SUCCESS:Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->setUpdateResult(Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;)V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendResult()V

    return-void
.end method

.method private pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;Ljava/lang/String;)V

    return-void
.end method

.method private pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, v2}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->ensureContentController(Lcom/facebook/accountkit/ui/UpdateFlowState;)Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v2

    iput-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    if-ne v1, v2, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v2

    if-eqz v1, :cond_2

    invoke-interface {v1, v0}, Lcom/facebook/accountkit/ui/ContentController;->onPause(Landroid/app/Activity;)V

    invoke-interface {v1}, Lcom/facebook/accountkit/ui/ContentController;->isTransient()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Landroid/app/FragmentManager;->popBackStack()V

    :cond_2
    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->updateUI(Lcom/facebook/accountkit/ui/UpdateFlowState;Lcom/facebook/accountkit/ui/ContentController;)V

    sget-object v0, Lcom/facebook/accountkit/ui/UpdateFlowState;->PHONE_NUMBER_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    if-eq p1, v0, :cond_3

    sget-object v0, Lcom/facebook/accountkit/ui/UpdateFlowState;->CODE_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    if-ne p1, v0, :cond_4

    :cond_3
    if-eqz p2, :cond_4

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    check-cast p1, Lcom/facebook/accountkit/ui/UpdateErrorContentController;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->setErrorMessage(Ljava/lang/String;)V

    :cond_4
    return-void
.end method


# virtual methods
.method getContentController()Lcom/facebook/accountkit/ui/ContentController;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    return-object v0
.end method

.method public getUpdateFlowState()Lcom/facebook/accountkit/ui/UpdateFlowState;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    return-object v0
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->EXTRA_EVENT:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    sget-object v0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->EXTRA_ERROR_MESSAGE:Ljava/lang/String;

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/UpdateStateStackManager$2;->$SwitchMap$com$facebook$accountkit$UpdateFlowBroadcastReceiver$Event:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ordinal()I

    move-result p1

    aget p1, v1, p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->popState()V

    return-void

    :pswitch_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->popState()V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    check-cast p1, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->setRetry(Z)V

    return-void

    :pswitch_2
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->CODE_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    goto :goto_0

    :pswitch_3
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->PHONE_NUMBER_INPUT_ERROR:Lcom/facebook/accountkit/ui/UpdateFlowState;

    :goto_0
    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;Ljava/lang/String;)V

    return-void

    :pswitch_4
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V

    sget-object p1, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->EXTRA_UPDATE_STATE:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance p2, Landroid/os/Handler;

    invoke-direct {p2}, Landroid/os/Handler;-><init>()V

    new-instance v0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;-><init>(Lcom/facebook/accountkit/ui/UpdateStateStackManager;Ljava/lang/String;)V

    const-wide/16 v1, 0x7d0

    invoke-virtual {p2, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :pswitch_5
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->VERIFYING_CODE:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V

    sget-object p1, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->EXTRA_CONFIRMATION_CODE:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccountKitController;->continueUpdateWithCode(Ljava/lang/String;)V

    return-void

    :pswitch_6
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/UpdateFlowState;

    goto :goto_1

    :pswitch_7
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateFlowState;->SENT_CODE:Lcom/facebook/accountkit/ui/UpdateFlowState;

    :goto_1
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V

    return-void

    :pswitch_8
    sget-object p1, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->EXTRA_PHONE_NUMBER:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/PhoneNumber;

    sget-object p2, Lcom/facebook/accountkit/ui/UpdateFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->pushState(Lcom/facebook/accountkit/ui/UpdateFlowState;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getInitialAuthState()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/facebook/accountkit/internal/AccountKitController;->updatePhoneNumber(Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/PhoneUpdateModel;

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method popState()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->activityRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/UpdateFlowState;->getBackState(Lcom/facebook/accountkit/ui/UpdateFlowState;)Lcom/facebook/accountkit/ui/UpdateFlowState;

    move-result-object v2

    iput-object v2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    iget-object v3, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->updateFlowState:Lcom/facebook/accountkit/ui/UpdateFlowState;

    invoke-direct {p0, v3}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->ensureContentController(Lcom/facebook/accountkit/ui/UpdateFlowState;)Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v3

    iput-object v3, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    sget-object v3, Lcom/facebook/accountkit/ui/UpdateStateStackManager$2;->$SwitchMap$com$facebook$accountkit$ui$UpdateFlowState:[I

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/UpdateFlowState;->ordinal()I

    move-result v2

    aget v2, v3, v2

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->cancelUpdate()V

    goto :goto_0

    :pswitch_1
    sget-object v2, Lcom/facebook/accountkit/ui/UpdateFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/UpdateFlowState;

    if-ne v1, v2, :cond_1

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendResult()V

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->sendCancelResult()V

    :goto_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/FragmentManager;->popBackStack()V

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->contentController:Lcom/facebook/accountkit/ui/ContentController;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitUpdateActivity;->ensureNextButton(Lcom/facebook/accountkit/ui/ContentController;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
