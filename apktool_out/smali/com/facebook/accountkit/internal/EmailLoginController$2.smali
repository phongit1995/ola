.class Lcom/facebook/accountkit/internal/EmailLoginController$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/EmailLoginController;->createPolling(Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Ljava/lang/Runnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

.field final synthetic val$callback:Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;

.field final synthetic val$loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

.field final synthetic val$requestInstanceToken:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/EmailLoginController;Lcom/facebook/accountkit/internal/EmailLoginModelImpl;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$callback:Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;

    iput-object p4, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$requestInstanceToken:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private checkLoginManager()Z
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$requestInstanceToken:Ljava/lang/String;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getRequestInstanceToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isLoginInProgress()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method public run()V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->assertUIThread()V

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/EmailLoginController$2;->checkLoginManager()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "email"

    iget-object v2, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$loginModel:Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->getEmail()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->this$0:Lcom/facebook/accountkit/internal/EmailLoginController;

    const-string v2, "poll_login"

    invoke-virtual {v1, v2, v0}, Lcom/facebook/accountkit/internal/EmailLoginController;->buildGraphRequest(Ljava/lang/String;Landroid/os/Bundle;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->cancelCurrentAsyncTask()Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    new-instance v1, Lcom/facebook/accountkit/internal/EmailLoginController$2$1;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/internal/EmailLoginController$2$1;-><init>(Lcom/facebook/accountkit/internal/EmailLoginController$2;)V

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->executeAsync(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    return-void
.end method
