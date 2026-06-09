.class final Lcom/facebook/accountkit/ui/PhoneUpdateContentController;
.super Lcom/facebook/accountkit/ui/PhoneContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method


# virtual methods
.method public getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_update_title:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0
.end method

.method getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PhoneUpdateContentController$1;-><init>(Lcom/facebook/accountkit/ui/PhoneUpdateContentController;)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneUpdateContentController;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    return-object v0
.end method
