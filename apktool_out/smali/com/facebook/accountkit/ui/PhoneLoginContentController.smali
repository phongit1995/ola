.class final Lcom/facebook/accountkit/ui/PhoneLoginContentController;
.super Lcom/facebook/accountkit/ui/PhoneContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->initializeLogin()V

    return-void
.end method


# virtual methods
.method public getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_login_title:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0
.end method

.method getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PhoneLoginContentController$1;-><init>(Lcom/facebook/accountkit/ui/PhoneLoginContentController;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    return-object v0
.end method

.method setRetry()V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_login_retry_title:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->setRetry(Z)V

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneLoginContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;->updateText()V

    :cond_2
    return-void
.end method
