.class Lcom/facebook/accountkit/internal/PhoneUpdateController$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/PhoneUpdateController;->onPending()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/PhoneUpdateController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$000(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/UpdateManager;

    move-result-object v0

    if-eqz v0, :cond_4

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v1, Landroid/content/Intent;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1

    iget-object v2, p1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->isConfirmationCodeRetryable(Lcom/facebook/accountkit/internal/InternalAccountKitError;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setError(Lcom/facebook/accountkit/AccountKitError;)V

    sget-object p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->RETRY_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    iget-object v3, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v3, Lcom/facebook/accountkit/AccountKitError;

    invoke-static {v2, v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$100(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError;)V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->clearUpdate()V

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_ERROR_MESSAGE:Ljava/lang/String;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError;->getUserFacingMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    sget-object v2, Lcom/facebook/accountkit/AccountKitError$Type;->UPDATE_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {p1, v2, v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$200(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    sget-object p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_0

    :cond_3
    const-string v2, "state"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setFinalUpdateState(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->SUCCESS:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    sget-object p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ACCOUNT_UPDATE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    sget-object p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_UPDATE_STATE:Ljava/lang/String;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getFinalUpdateState()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->clearUpdate()V

    :goto_1
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string v2, "ak_update_complete"

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$2;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v3

    invoke-virtual {p1, v2, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logUpdateModel(Ljava/lang/String;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;)V

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    :cond_4
    return-void
.end method
