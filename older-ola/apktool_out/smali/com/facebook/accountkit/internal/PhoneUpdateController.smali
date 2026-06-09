.class final Lcom/facebook/accountkit/internal/PhoneUpdateController;
.super Ljava/lang/Object;


# static fields
.field private static final GRAPH_PATH_CONFIRM_UPDATE:Ljava/lang/String; = "confirm_update"

.field private static final GRAPH_PATH_START_UPDATE:Ljava/lang/String; = "start_update"

.field private static final PARAMETER_CONFIRMATION_CODE:Ljava/lang/String; = "confirmation_code"

.field private static final PARAMETER_CREDENTIALS_TYPE:Ljava/lang/String; = "credentials_type"

.field private static final PARAMETER_EXTRAS_TYPE:Ljava/lang/String; = "extras"

.field private static final PARAMETER_PHONE:Ljava/lang/String; = "phone_number"

.field private static final PARAMETER_STATE:Ljava/lang/String; = "state"

.field private static final PARAMETER_UPDATE_REQUEST_CODE:Ljava/lang/String; = "update_request_code"


# instance fields
.field private final updateManagerRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/facebook/accountkit/internal/UpdateManager;",
            ">;"
        }
    .end annotation
.end field

.field private final updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/UpdateManager;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateManagerRef:Ljava/lang/ref/WeakReference;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/UpdateManager;
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getUpdateManager()Lcom/facebook/accountkit/internal/UpdateManager;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method static synthetic access$200(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->setError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    return-void
.end method

.method static synthetic access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    return-object p0
.end method

.method private buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;
    .locals 6

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    const-string v0, "credentials_type"

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getCredentialsType()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v0, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "update_request_code"

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getUpdateRequestCode()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v0, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3, p2}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    new-instance p2, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v1

    sget-object v5, Lcom/facebook/accountkit/internal/HttpMethod;->POST:Lcom/facebook/accountkit/internal/HttpMethod;

    const/4 v4, 0x0

    move-object v0, p2

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Landroid/os/Bundle;ZLcom/facebook/accountkit/internal/HttpMethod;)V

    return-object p2
.end method

.method private getCredentialsType()Ljava/lang/String;
    .locals 1

    const-string v0, "phone_number"

    return-object v0
.end method

.method private getUpdateManager()Lcom/facebook/accountkit/internal/UpdateManager;
    .locals 3
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateManagerRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/internal/UpdateManager;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->isActivityAvailable()Z

    move-result v2

    if-nez v2, :cond_1

    return-object v1

    :cond_1
    return-object v0
.end method

.method private setError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-direct {v0, p1, p2}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method private setError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    sget-object v0, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    return-void
.end method


# virtual methods
.method getUpdateModel()Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    return-object v0
.end method

.method public onCancel()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/UpdateStatus;->CANCELLED:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getUpdateManager()Lcom/facebook/accountkit/internal/UpdateManager;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->clearUpdate()V

    :cond_0
    return-void
.end method

.method public onError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    sget-object v0, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->getUpdateManager()Lcom/facebook/accountkit/internal/UpdateManager;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/UpdateManager;->clearUpdate()V

    :cond_0
    return-void
.end method

.method onPending()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getConfirmationCode()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;-><init>(Lcom/facebook/accountkit/internal/PhoneUpdateController;)V

    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    const-string v2, "confirmation_code"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getConfirmationCode()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "phone_number"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "confirm_update"

    invoke-direct {p0, v2, v1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method

.method update(Ljava/lang/String;)V
    .locals 4

    new-instance v0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;-><init>(Lcom/facebook/accountkit/internal/PhoneUpdateController;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Landroid/os/Bundle;

    invoke-direct {v2}, Landroid/os/Bundle;-><init>()V

    const-string v3, "phone_number"

    invoke-static {v2, v3, v1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "state"

    invoke-static {v2, v1, p1}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "extras"

    const-string v3, "terms_of_service,privacy_policy"

    invoke-static {v2, v1, v3}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController;->updateModel:Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setInitialUpdateState(Ljava/lang/String;)V

    const-string p1, "start_update"

    invoke-direct {p0, p1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object p1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method
