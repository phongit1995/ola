.class Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;
.implements Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnCompleteListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;


# direct methods
.method private constructor <init>(Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;->this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;-><init>(Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;)V

    return-void
.end method


# virtual methods
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

.method public onNext(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;->this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;->this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;->this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getConfirmationCode()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$OnCompleteListener;->this$0:Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    iget-object v1, v1, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getDetectedConfirmationCode()Ljava/lang/String;

    move-result-object v1

    invoke-static {p2, v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIConfirmationCodeInteraction(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance p2, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {p2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object p2

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_CONFIRMATION_CODE:Ljava/lang/String;

    invoke-virtual {p2, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    :cond_1
    return-void
.end method

.method public onRetry(Landroid/content/Context;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method
