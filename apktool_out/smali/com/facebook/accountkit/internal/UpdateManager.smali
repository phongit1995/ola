.class final Lcom/facebook/accountkit/internal/UpdateManager;
.super Ljava/lang/Object;


# static fields
.field private static final SAVED_UPDATE_MODEL:Ljava/lang/String; = "accountkitUpdateModel"


# instance fields
.field private volatile currentActivity:Landroid/app/Activity;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private volatile currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private volatile isActivityAvailable:Z

.field private final localBroadcastManager:Landroid/support/v4/content/LocalBroadcastManager;

.field private final logger:Lcom/facebook/accountkit/internal/InternalLogger;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/InternalLogger;Landroid/support/v4/content/LocalBroadcastManager;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->isActivityAvailable:Z

    iput-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/UpdateManager;->localBroadcastManager:Landroid/support/v4/content/LocalBroadcastManager;

    return-void
.end method

.method private continueWith(Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    new-instance v0, Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;-><init>(Lcom/facebook/accountkit/internal/UpdateManager;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/UpdateManager;->handle(Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    return-void
.end method

.method private getCurrentUpdateModel()Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getUpdateModel()Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v0

    return-object v0
.end method

.method private handle(Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/internal/UpdateManager$1;->$SwitchMap$com$facebook$accountkit$internal$UpdateStatus:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/UpdateStatus;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->onCancel()V

    return-void

    :pswitch_2
    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->onPending()V

    :pswitch_3
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_3
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method cancelExisting()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->onCancel()V

    :cond_0
    return-void
.end method

.method clearUpdate()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    return-void
.end method

.method continueWithCode(Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/internal/UpdateManager;->getCurrentUpdateModel()Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    :try_start_0
    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setConfirmationCode(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/internal/UpdateManager;->handle(Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    const-string v1, "ak_update_verify"

    invoke-virtual {p1, v1, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logUpdateModel(Ljava/lang/String;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V
    :try_end_0
    .catch Lcom/facebook/accountkit/AccountKitException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isDebuggable(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_2

    throw p1

    :cond_2
    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    const-string v1, "ak_confirmation_code_set"

    invoke-virtual {p1, v1, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logUpdateModel(Ljava/lang/String;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    return-void
.end method

.method getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->localBroadcastManager:Landroid/support/v4/content/LocalBroadcastManager;

    return-object v0
.end method

.method getLogger()Lcom/facebook/accountkit/internal/InternalLogger;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    return-object v0
.end method

.method isActivityAvailable()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->isActivityAvailable:Z

    return v0
.end method

.method onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->isActivityAvailable:Z

    iput-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentActivity:Landroid/app/Activity;

    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/internal/InternalLogger;->onActivityCreate(Landroid/os/Bundle;)V

    if-eqz p2, :cond_0

    const-string p1, "accountkitUpdateModel"

    invoke-virtual {p2, p1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    if-eqz p1, :cond_0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/UpdateManager;->continueWith(Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    :cond_0
    return-void
.end method

.method onActivityDestroy(Landroid/app/Activity;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentActivity:Landroid/app/Activity;

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->isActivityAvailable:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentActivity:Landroid/app/Activity;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method

.method onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentActivity:Landroid/app/Activity;

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/internal/InternalLogger;->saveInstanceState(Landroid/os/Bundle;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    if-eqz p1, :cond_1

    const-string p1, "accountkitUpdateModel"

    iget-object v0, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getUpdateModel()Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v0

    invoke-virtual {p2, p1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    :cond_1
    return-void
.end method

.method updatePhoneNumber(Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;
    .locals 2
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/UpdateManager;->cancelExisting()V

    new-instance v0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-direct {v0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;-><init>(Lcom/facebook/accountkit/PhoneNumber;)V

    new-instance p1, Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-direct {p1, p0, v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;-><init>(Lcom/facebook/accountkit/internal/UpdateManager;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->update(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/UpdateManager;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    const-string v1, "ak_update_start"

    invoke-virtual {p2, v1, v0}, Lcom/facebook/accountkit/internal/InternalLogger;->logUpdateModel(Ljava/lang/String;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/UpdateManager;->currentPhoneUpdateController:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    return-object v0
.end method
