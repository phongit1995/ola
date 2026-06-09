.class public final Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;
.super Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TitleFragment"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;-><init>()V

    return-void
.end method

.method public static varargs create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;
    .locals 3
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-virtual {v0, p1, p2}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method setPhoneNumberView()V
    .locals 5

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->isAdded()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    if-eqz v0, :cond_1

    new-instance v0, Landroid/text/SpannableString;

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_enter_code_sent_to:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v4}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    new-instance v1, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment$1;-><init>(Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;)V

    invoke-virtual {v0}, Landroid/text/SpannableString;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v3}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v3, v2

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    :cond_1
    return-void
.end method
