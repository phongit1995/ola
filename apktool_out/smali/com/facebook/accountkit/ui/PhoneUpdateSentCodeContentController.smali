.class final Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;
.super Lcom/facebook/accountkit/ui/SentCodeContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/SentCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method


# virtual methods
.method protected logImpression()V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUISentCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void
.end method

.method public onResume(Landroid/app/Activity;)V
    .locals 3

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/SentCodeContentController;->onResume(Landroid/app/Activity;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;->cancelTransition()V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;->delayedTransitionHandler:Landroid/os/Handler;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController$1;

    invoke-direct {v0, p0, p1}, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController$1;-><init>(Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;->delayedTransitionRunnable:Ljava/lang/Runnable;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;->delayedTransitionHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateSentCodeContentController;->delayedTransitionRunnable:Ljava/lang/Runnable;

    const-wide/16 v1, 0x7d0

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
