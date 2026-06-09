.class final Lcom/facebook/accountkit/ui/SendingCodeContentController;
.super Lcom/facebook/accountkit/ui/ContentControllerBase;


# instance fields
.field private bottomFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field private centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field private footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

.field private headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

.field private textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field private topFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ContentControllerBase;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method


# virtual methods
.method public getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getCenterFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    sget v2, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_sending_code_center:I

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getFocusView()Landroid/view/View;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    const/4 v0, 0x0

    return-object v0
.end method

.method public getFooterFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0
.end method

.method public getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    sget-object v0, Lcom/facebook/accountkit/ui/SendingCodeContentController$1;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    new-instance v0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_STATE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw v0

    :pswitch_0
    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_loading_title:I

    goto :goto_0

    :pswitch_1
    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_email_loading_title:I

    :goto_0
    iget-object v1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/SendingCodeContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method protected logImpression()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getLoginType()Lcom/facebook/accountkit/ui/LoginType;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUISendingCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void
.end method

.method public setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method public setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method public setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-void
.end method

.method public setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-void
.end method

.method public setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method public setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SendingCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method
