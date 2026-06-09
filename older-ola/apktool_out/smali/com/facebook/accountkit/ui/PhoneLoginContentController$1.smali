.class Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/PhoneLoginContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneLoginContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNext(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v1, v1, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getAppSuppliedPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    iget-object v2, v2, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getDevicePhoneNumber()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/PhoneContentController;->getPhoneNumberSource(Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->name()Ljava/lang/String;

    move-result-object v1

    invoke-static {p2, v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIPhoneLoginInteraction(Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/PhoneNumber;)V

    new-instance p2, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {p2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object p2

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_PHONE_NUMBER:Ljava/lang/String;

    invoke-virtual {p2, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object p2

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    :cond_2
    return-void
.end method
