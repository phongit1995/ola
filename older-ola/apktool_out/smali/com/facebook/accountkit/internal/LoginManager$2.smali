.class Lcom/facebook/accountkit/internal/LoginManager$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/LoginManager;->logOut(Lcom/facebook/accountkit/AccountKitCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/LoginManager;

.field final synthetic val$callback:Lcom/facebook/accountkit/AccountKitCallback;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/AccountKitCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/LoginManager;->access$100(Lcom/facebook/accountkit/internal/LoginManager;)Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    const-string v1, "ak_log_out_error"

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/InternalLogger;->logEvent(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/AccountKitCallback;->onError(Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/LoginManager;->access$200(Lcom/facebook/accountkit/internal/LoginManager;)Lcom/facebook/accountkit/internal/AccessTokenManager;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/internal/AccessTokenManager;->setCurrentAccessToken(Lcom/facebook/accountkit/AccessToken;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/LoginManager;->access$100(Lcom/facebook/accountkit/internal/LoginManager;)Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string v1, "ak_log_out"

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/internal/InternalLogger;->logEvent(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$2;->val$callback:Lcom/facebook/accountkit/AccountKitCallback;

    invoke-interface {p1, v0}, Lcom/facebook/accountkit/AccountKitCallback;->onSuccess(Ljava/lang/Object;)V

    :cond_1
    return-void
.end method
