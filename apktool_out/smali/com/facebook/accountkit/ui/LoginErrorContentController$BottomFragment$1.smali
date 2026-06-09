.class Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

.field final synthetic val$viewState:Landroid/os/Bundle;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;Landroid/os/Bundle;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment$1;->val$viewState:Landroid/os/Bundle;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->TRY_AGAIN:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIErrorInteraction(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ERROR_RESTART:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_RETURN_LOGIN_FLOW_STATE:Ljava/lang/String;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment$1;->val$viewState:Landroid/os/Bundle;

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginErrorContentController$BottomFragment;->access$100()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method
