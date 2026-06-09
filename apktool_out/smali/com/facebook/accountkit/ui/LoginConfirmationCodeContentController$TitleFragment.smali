.class public final Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;
.super Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TitleFragment"
.end annotation


# instance fields
.field private notificationChannel:Lcom/facebook/accountkit/ui/NotificationChannel;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;-><init>()V

    return-void
.end method

.method public static varargs create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;
    .locals 3
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-virtual {v0, p1, p2}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method setNotificationChannel(Lcom/facebook/accountkit/ui/NotificationChannel;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->notificationChannel:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V

    return-void
.end method

.method setPhoneNumberView()V
    .locals 5

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->isAdded()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->notificationChannel:Lcom/facebook/accountkit/ui/NotificationChannel;

    if-nez v0, :cond_1

    return-void

    :cond_1
    sget-object v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$2;->$SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->notificationChannel:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/NotificationChannel;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    if-nez v0, :cond_2

    return-void

    :pswitch_0
    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_voice_call_code_entry_title:I

    goto :goto_0

    :pswitch_1
    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_facebook_code_entry_title:I

    :goto_0
    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    return-void

    :cond_2
    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->retry:Z

    if-eqz v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_verify_confirmation_code_title:I

    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v1}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_3
    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_enter_code_sent_to:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v1

    invoke-virtual {p0, v0, v2}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, v0}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    new-instance v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment$1;-><init>(Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;)V

    invoke-virtual {v1}, Landroid/text/SpannableString;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v3, v2

    const/16 v4, 0x21

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
