.class abstract Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;
.super Lcom/facebook/accountkit/ui/ContentControllerBase;

# interfaces
.implements Lcom/facebook/accountkit/ui/ButtonContentController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;,
        Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;
    }
.end annotation


# static fields
.field private static final DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

.field private static final ERROR_RESTART_KEY:Ljava/lang/String; = "is_error_restart"

.field private static final LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

.field private static final NUMERIC_REGEX:Ljava/lang/String; = "[0-9]+"


# instance fields
.field bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private buttonType:Lcom/facebook/accountkit/ui/ButtonType;

.field private centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

.field headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    sput-object v0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget-object v0, Lcom/facebook/accountkit/ui/ButtonType;->CONTINUE:Lcom/facebook/accountkit/ui/ButtonType;

    sput-object v0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ContentControllerBase;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    sget-object p1, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    return-void
.end method

.method static synthetic access$000()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method static synthetic access$300(Landroid/content/Context;)[C
    .locals 0

    invoke-static {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getConfirmationCodeToPaste(Landroid/content/Context;)[C

    move-result-object p0

    return-object p0
.end method

.method private static getConfirmationCodeToPaste(Landroid/content/Context;)[C
    .locals 2

    invoke-static {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getCurrentPasteText(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    const-string v0, "[0-9]+"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static getCurrentPasteText(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    const-string v1, "clipboard"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/content/ClipboardManager;

    invoke-virtual {p0}, Landroid/content/ClipboardManager;->hasPrimaryClip()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object p0

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object p0

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    return-object v0
.end method


# virtual methods
.method public getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getButtonType()Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/ButtonType;)Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    return-object v0
.end method

.method public getButtonType()Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    return-object v0
.end method

.method public getCenterFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    sget v2, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_confirmation_code_center:I

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getFocusView()Landroid/view/View;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getFocusView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getFooterFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0
.end method

.method public getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    return-object v0
.end method

.method public isTransient()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected logImpression()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getRetry()Z

    move-result v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIConfirmationCodeShown(Z)V

    :cond_1
    return-void
.end method

.method public setButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->updateNextButton()V

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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method setDetectedConfirmationCode(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->setDetectedConfirmationCode(Ljava/lang/String;)V

    return-void
.end method

.method public setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-void
.end method

.method setPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 1
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V

    :cond_0
    return-void
.end method

.method setRetry(Z)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->headerFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setRetry(Z)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setRetry(Z)V

    :cond_1
    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onRetry()V

    :cond_2
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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->textFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method updateNextButton()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->topFragment:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->isConfirmationCodeValid()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setNextButtonEnabled(Z)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->getButtonType()Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setNextButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V

    :cond_1
    return-void
.end method
