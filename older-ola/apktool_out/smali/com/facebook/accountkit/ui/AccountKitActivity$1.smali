.class Lcom/facebook/accountkit/ui/AccountKitActivity$1;
.super Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/AccountKitActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->EXTRA_EVENT:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$000(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/StateStackManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/StateStackManager;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$3;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ordinal()I

    move-result p1

    aget p1, v1, p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    instance-of p1, v0, Lcom/facebook/accountkit/ui/ResendContentController;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p2, v0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onResendVoiceCallNotification(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;)V

    return-void

    :pswitch_1
    instance-of p1, v0, Lcom/facebook/accountkit/ui/ResendContentController;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p2, v0, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onResendFacebookNotification(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;)V

    return-void

    :pswitch_2
    instance-of p1, v0, Lcom/facebook/accountkit/ui/ResendContentController;

    if-nez p1, :cond_1

    instance-of p1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz p1, :cond_2

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onResend(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void

    :pswitch_3
    instance-of p1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onConfirmationCodeRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void

    :pswitch_4
    instance-of p1, v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;

    if-eqz p1, :cond_2

    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->EXTRA_CONFIRMATION_CODE:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0, v1, p2, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onConfirmationCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Ljava/lang/String;)V

    return-void

    :pswitch_5
    instance-of p1, v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;

    if-eqz p1, :cond_2

    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->EXTRA_PHONE_NUMBER:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/PhoneNumber;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0, v1, p2, p1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onPhoneLoginComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Lcom/facebook/accountkit/PhoneNumber;)V

    return-void

    :pswitch_6
    instance-of p1, v0, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    if-eqz p1, :cond_2

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginFlowState;->values()[Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->EXTRA_RETURN_LOGIN_FLOW_STATE:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p2

    aget-object p1, p1, p2

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p2, p1}, Lcom/facebook/accountkit/ui/ActivityErrorHandler;->onErrorRestart(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowState;)V

    return-void

    :pswitch_7
    instance-of p1, v0, Lcom/facebook/accountkit/ui/EmailVerifyContentController;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->onEmailVerifyRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void

    :pswitch_8
    instance-of p1, v0, Lcom/facebook/accountkit/ui/EmailLoginContentController;

    if-eqz p1, :cond_2

    sget-object p1, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->EXTRA_EMAIL:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0, v1, p2, p1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->onEmailLoginComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/EmailLoginFlowManager;Ljava/lang/String;)V

    return-void

    :pswitch_9
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object v0

    invoke-virtual {p1, p2, v0}, Lcom/facebook/accountkit/ui/ActivityHandler;->onConfirmSeamlessLogin(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/LoginFlowManager;)V

    return-void

    :pswitch_a
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/ActivityHandler;->onAccountVerifiedComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void

    :pswitch_b
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/AccountKitActivity;->access$100(Lcom/facebook/accountkit/ui/AccountKitActivity;)Lcom/facebook/accountkit/ui/LoginFlowManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowManager;->getActivityHandler()Lcom/facebook/accountkit/ui/ActivityHandler;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$1;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/ActivityHandler;->onSentCodeComplete(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    :cond_2
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
