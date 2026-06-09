.class Lcom/facebook/accountkit/ui/ResendContentController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ResendContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ResendContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ResendContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$1;->this$0:Lcom/facebook/accountkit/ui/ResendContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConfirmationCodeCallback(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_VOICE_CALL_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method

.method public onEdit(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method

.method public onFacebookNotification(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_FACEBOOK_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method

.method public onResend(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method
