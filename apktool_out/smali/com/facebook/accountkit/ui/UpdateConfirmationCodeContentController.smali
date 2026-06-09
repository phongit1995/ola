.class final Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;
.super Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;,
        Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;
    }
.end annotation


# instance fields
.field private onCompleteListener:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method

.method private getOnCompleteListener()Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;-><init>(Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$1;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    return-object v0
.end method


# virtual methods
.method public getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_title:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    return-object v0
.end method

.method public setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setOnCompleteListener(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setRetryVisible(Z)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->updateNextButton()V

    return-void
.end method

.method public setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$TitleFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setOnCompleteListener(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;)V

    return-void
.end method

.method public setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    new-instance p1, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$1;

    invoke-direct {p1, p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$1;-><init>(Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->setOnConfirmationCodeChangedListener(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/UpdateConfirmationCodeContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->setOnCompleteListener(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;)V

    return-void
.end method
