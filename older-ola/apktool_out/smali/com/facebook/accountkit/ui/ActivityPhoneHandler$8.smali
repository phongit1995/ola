.class Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;
.super Lcom/facebook/accountkit/ui/SmsTracker;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->startSmsTrackerIfPossible(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

.field final synthetic val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/SmsTracker;-><init>()V

    return-void
.end method


# virtual methods
.method protected confirmationCodeReceived(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/SendingCodeContentController;

    if-nez v1, :cond_1

    instance-of v1, v0, Lcom/facebook/accountkit/ui/SentCodeContentController;

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    instance-of v1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz v1, :cond_2

    check-cast v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;->setDetectedConfirmationCode(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->access$300(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;)Lcom/facebook/accountkit/PhoneLoginTracker;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/PhoneLoginTracker;->setCode(Ljava/lang/String;)V

    :cond_2
    :goto_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$8;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->access$400(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;)Lcom/facebook/accountkit/ui/SmsTracker;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/SmsTracker;->stopTracking()V

    return-void
.end method
