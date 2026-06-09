.class Lcom/facebook/accountkit/internal/PhoneLoginController$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/PhoneLoginController;->onPending()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

.field final synthetic val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/PhoneLoginController;Lcom/facebook/accountkit/internal/LoginManager;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->isActivityAvailable()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/facebook/accountkit/internal/PhoneLoginController;->access$000()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Warning: Callback issues while activity not available."

    invoke-static {p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    if-nez p1, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v1

    if-eqz v1, :cond_6

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v1, p1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isConfirmationCodeRetryable(Lcom/facebook/accountkit/internal/InternalAccountKitError;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v2, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_2
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne v1, v2, :cond_3

    if-eqz p1, :cond_3

    iget-object p1, p1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->isConfirmationCodeRetryable(Lcom/facebook/accountkit/internal/InternalAccountKitError;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    sget-object v1, Lcom/facebook/accountkit/internal/LoginStatus;->PENDING:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    :cond_3
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_4

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_5

    :cond_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_5
    return-void

    :catchall_0
    move-exception v1

    goto/16 :goto_1

    :cond_6
    :try_start_2
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_9

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_7

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_8

    :cond_7
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_8
    return-void

    :cond_9
    :try_start_3
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->extractAccessTokenOrCodeIntoModel(Lorg/json/JSONObject;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catch_0
    :try_start_4
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->LOGIN_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginController;->onError(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_a

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_b

    :cond_a
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_b
    return-void

    :catchall_1
    move-exception v1

    move-object p1, v0

    :goto_1
    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v2, v2, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast v2, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v2

    sget-object v3, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne v2, v3, :cond_c

    if-eqz p1, :cond_c

    iget-object p1, p1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->isConfirmationCodeRetryable(Lcom/facebook/accountkit/internal/InternalAccountKitError;)Z

    move-result p1

    if-eqz p1, :cond_c

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->PENDING:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setStatus(Lcom/facebook/accountkit/internal/LoginStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    :cond_c
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginController;->broadcastLoginStateChange()V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/LoginManager;->onLoginComplete(Lcom/facebook/accountkit/internal/LoginModelImpl;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    if-eq p1, v0, :cond_d

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneLoginController;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneLoginController;->loginModel:Lcom/facebook/accountkit/internal/LoginModelImpl;

    check-cast p1, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/PhoneLoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    if-ne p1, v0, :cond_e

    :cond_d
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneLoginController$2;->val$loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/LoginManager;->clearLogIn()V

    :cond_e
    throw v1
.end method
