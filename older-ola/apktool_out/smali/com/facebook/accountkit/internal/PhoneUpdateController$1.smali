.class Lcom/facebook/accountkit/internal/PhoneUpdateController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/PhoneUpdateController;->update(Ljava/lang/String;)V
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

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 10

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$000(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/UpdateManager;

    move-result-object v0

    if-eqz v0, :cond_d

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createErrorFromServerError(Lcom/facebook/accountkit/internal/AccountKitRequestError;)Landroid/util/Pair;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    iget-object v2, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Lcom/facebook/accountkit/AccountKitError;

    invoke-static {v1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$100(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    new-instance v1, Landroid/content/Intent;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v2

    sget-object v3, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v2, v3, :cond_1

    sget-object p1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v2

    sget-object v3, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v2, v3, :cond_2

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    if-eqz p1, :cond_2

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_ERROR_MESSAGE:Ljava/lang/String;

    iget-object p1, p1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccountKitError;->getUserFacingMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_2
    :goto_0
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void

    :catchall_0
    move-exception v1

    move-object v9, v1

    move-object v1, p1

    move-object p1, v9

    goto/16 :goto_6

    :cond_3
    :try_start_2
    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getResponseObject()Lorg/json/JSONObject;

    move-result-object p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    sget-object v2, Lcom/facebook/accountkit/AccountKitError$Type;->UPDATE_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {p1, v2, v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$200(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    new-instance p1, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {p1, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v1, v2, :cond_4

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    :goto_1
    invoke-virtual {p1, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_2

    :cond_4
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v1, v2, :cond_5

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    goto :goto_1

    :cond_5
    :goto_2
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void

    :cond_6
    :try_start_3
    const-string v2, "privacy_policy"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v3

    const-string v4, "privacy_policy"

    invoke-virtual {v3, v4, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V

    :cond_7
    const-string v2, "terms_of_service"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_8

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v3

    const-string v4, "terms_of_service"

    invoke-virtual {v3, v4, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->putField(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :cond_8
    :try_start_4
    const-string v2, "update_request_code"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "expires_in_sec"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    iget-object v5, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v5}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v5

    invoke-virtual {v5, v3, v4}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setExpiresInSeconds(J)V

    const-string v3, "min_resend_interval_sec"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sget-object v7, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v7, v3, v4}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v3

    const/4 v7, 0x0

    add-long v7, v5, v3

    invoke-virtual {p1, v7, v8}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setResendTime(J)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    sget-object v3, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p1, v3}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V

    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object p1

    invoke-virtual {p1, v2}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->setUpdateRequestCode(Ljava/lang/String;)V
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_3

    :catch_0
    :try_start_5
    iget-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    sget-object v2, Lcom/facebook/accountkit/AccountKitError$Type;->UPDATE_INVALIDATED:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {p1, v2, v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$200(Lcom/facebook/accountkit/internal/PhoneUpdateController;Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :goto_3
    new-instance p1, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {p1, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v1, v2, :cond_9

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    :goto_4
    invoke-virtual {p1, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_5

    :cond_9
    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v1, v2, :cond_a

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    goto :goto_4

    :cond_a
    :goto_5
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void

    :catchall_1
    move-exception p1

    :goto_6
    new-instance v2, Landroid/content/Intent;

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v3

    sget-object v4, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v3, v4, :cond_b

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v2, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_7

    :cond_b
    iget-object v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateController$1;->this$0:Lcom/facebook/accountkit/internal/PhoneUpdateController;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateController;->access$300(Lcom/facebook/accountkit/internal/PhoneUpdateController;)Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v3

    sget-object v4, Lcom/facebook/accountkit/internal/UpdateStatus;->ERROR:Lcom/facebook/accountkit/internal/UpdateStatus;

    if-ne v3, v4, :cond_c

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v4, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    if-eqz v1, :cond_c

    sget-object v3, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;->EXTRA_ERROR_MESSAGE:Ljava/lang/String;

    iget-object v1, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v1, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v1}, Lcom/facebook/accountkit/AccountKitError;->getUserFacingMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_c
    :goto_7
    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateManager;->getLocalBroadcastManager()Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    throw p1

    :cond_d
    return-void
.end method
