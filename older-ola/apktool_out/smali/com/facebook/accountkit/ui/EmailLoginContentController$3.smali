.class Lcom/facebook/accountkit/ui/EmailLoginContentController$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/EmailLoginContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNext(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getEmail()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Landroid/util/Patterns;->EMAIL_ADDRESS:Ljava/util/regex/Pattern;

    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->matches()Z

    move-result v1

    if-nez v1, :cond_4

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$1000(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$1000(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p2

    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_email_invalid:I

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    :cond_2
    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object p2

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$1100(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/support/design/widget/TextInputLayout;

    move-result-object p2

    if-eqz p2, :cond_3

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object p2

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$1100(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/support/design/widget/TextInputLayout;

    move-result-object p2

    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_email_invalid:I

    invoke-virtual {p1, v0}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/support/design/widget/TextInputLayout;->setError(Ljava/lang/CharSequence;)V

    :cond_3
    return-void

    :cond_4
    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$1100(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/support/design/widget/TextInputLayout;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$1100(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/support/design/widget/TextInputLayout;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/support/design/widget/TextInputLayout;->setError(Ljava/lang/CharSequence;)V

    :cond_5
    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getAppSuppliedEmail()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->getEmailAppSuppliedSource(Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/ui/EmailLoginContentController$EmailSourceAppSupplied;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$EmailSourceAppSupplied;->name()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v2}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getSelectedEmail()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v3}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$900(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    move-result-object v3

    invoke-virtual {v3}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/facebook/accountkit/internal/Utility;->getDeviceEmailsIfAvailable(Landroid/content/Context;)Ljava/util/List;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->getEmailSourceSelected(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)Lcom/facebook/accountkit/ui/EmailLoginContentController$EmailSourceSelected;

    move-result-object v2

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$EmailSourceSelected;->name()Ljava/lang/String;

    move-result-object v2

    invoke-static {p2, v1, v2, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIEmailLoginInteraction(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance p2, Landroid/content/Intent;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {p2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->EMAIL_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object p2

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EMAIL:Ljava/lang/String;

    invoke-virtual {p2, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    invoke-static {p1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method
