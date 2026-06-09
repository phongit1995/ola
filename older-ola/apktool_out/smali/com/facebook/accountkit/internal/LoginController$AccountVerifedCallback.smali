.class Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/LoginController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "AccountVerifedCallback"
.end annotation


# instance fields
.field final loginManager:Lcom/facebook/accountkit/internal/LoginManager;

.field final synthetic this$0:Lcom/facebook/accountkit/internal/LoginController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/LoginController;Lcom/facebook/accountkit/internal/LoginManager;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/facebook/accountkit/internal/LoginController;->access$000()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Warning: Callback issues while activity not available."

    invoke-static {p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_2

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_2
    return-void

    :cond_3
    :try_start_1
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/internal/LoginController;->extractAccessTokenOrCodeIntoModel(Lorg/json/JSONObject;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    :try_start_3
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/internal/LoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_4

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_5

    :cond_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_5
    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginController;->broadcastLoginStateChange()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq v0, v1, :cond_6

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->this$0:Lcom/facebook/accountkit/internal/LoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/LoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne v0, v1, :cond_7

    :cond_6
    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginController$AccountVerifedCallback;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_7
    throw p1
.end method
