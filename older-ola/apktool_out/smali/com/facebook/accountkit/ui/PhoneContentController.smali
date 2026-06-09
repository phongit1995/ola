.class abstract Lcom/facebook/accountkit/ui/PhoneContentController;
.super Lcom/facebook/accountkit/ui/ContentControllerBase;

# interfaces
.implements Lcom/facebook/accountkit/ui/ButtonContentController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;,
        Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;,
        Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;,
        Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;,
        Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;
    }
.end annotation


# static fields
.field private static final COUNTRY_PHONE_PREFIX:Ljava/lang/String; = "+"

.field private static final DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

.field private static final LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

.field private static final RESOLVE_HINT_REQUEST_CODE:I = 0x98


# instance fields
.field bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private buttonType:Lcom/facebook/accountkit/ui/ButtonType;

.field private centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

.field private footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

.field headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

.field textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget-object v0, Lcom/facebook/accountkit/ui/ButtonType;->NEXT:Lcom/facebook/accountkit/ui/ButtonType;

    sput-object v0, Lcom/facebook/accountkit/ui/PhoneContentController;->DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ContentControllerBase;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    sget-object p1, Lcom/facebook/accountkit/ui/PhoneContentController;->DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    return-void
.end method

.method static synthetic access$000()Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/PhoneContentController;->DEFAULT_BUTTON_TYPE:Lcom/facebook/accountkit/ui/ButtonType;

    return-object v0
.end method

.method static synthetic access$100()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/PhoneContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/facebook/accountkit/ui/PhoneContentController;)V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->updateNextButton()V

    return-void
.end method

.method static synthetic access$800(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->logPhoneNumberAutofill(Ljava/lang/String;)V

    return-void
.end method

.method static getPhoneNumberSource(Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;
    .locals 1
    .param p0    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    if-nez p0, :cond_0

    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->UNKNOWN:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0

    :cond_0
    invoke-static {p2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lcom/facebook/accountkit/PhoneNumber;->getRawPhoneNumber()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/facebook/accountkit/PhoneNumber;->getRawPhoneNumber()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/PhoneNumber;->getRawPhoneNumber()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0

    :cond_2
    if-eqz p1, :cond_3

    invoke-virtual {p1, p0}, Lcom/facebook/accountkit/PhoneNumber;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_3

    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->APP_SUPPLIED_PHONE_NUMBER:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0

    :cond_3
    if-nez p2, :cond_4

    if-nez p1, :cond_4

    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0

    :cond_4
    sget-object p0, Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;->DEVICE_PHONE_NUMBER_NOT_SUPPLIED:Lcom/facebook/accountkit/ui/PhoneContentController$PhoneNumberSource;

    return-object p0
.end method

.method private static logPhoneNumberAutofill(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "autofill_number_method"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string p0, "ak_phone_number_autofilled"

    invoke-static {p0, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logEvent(Ljava/lang/String;Landroid/os/Bundle;)V

    return-void
.end method

.method private updateNextButton()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->isPhoneNumberValid()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->setNextButtonEnabled(Z)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getButtonType()Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->setNextButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public bridge synthetic getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getBottomFragment()Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    move-result-object v0

    return-object v0
.end method

.method public getBottomFragment()Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    return-object v0
.end method

.method public getButtonType()Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    return-object v0
.end method

.method public getCenterFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    sget v2, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_phone_login_center:I

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-object v0
.end method

.method public getFocusView()Landroid/view/View;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$900(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Landroid/widget/EditText;

    move-result-object v0

    return-object v0
.end method

.method public getFooterFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-object v0
.end method

.method public getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/PhoneContentController;->LOGIN_FLOW_STATE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method abstract getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
.end method

.method public getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    return-object v0
.end method

.method public bridge synthetic getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getTopFragment()Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    move-result-object v0

    return-object v0
.end method

.method public getTopFragment()Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    return-object v0
.end method

.method public isTransient()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected logImpression()V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getInitialCountryCodeValue()Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    move-object v2, v1

    goto :goto_0

    :cond_1
    iget-object v2, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    :goto_0
    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    iget-object v1, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCodeSource:Ljava/lang/String;

    :goto_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->getRetry()Z

    move-result v0

    invoke-static {v2, v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIPhoneLoginShown(Ljava/lang/String;Ljava/lang/String;Z)V

    :cond_3
    return-void
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentControllerBase;->onActivityResult(IILandroid/content/Intent;)V

    const/16 v0, 0x98

    if-ne p1, v0, :cond_0

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    const-string p2, "com.google.android.gms.credentials.Credential"

    invoke-virtual {p3, p2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p2

    check-cast p2, Lcom/google/android/gms/auth/api/credentials/Credential;

    invoke-virtual {p2}, Lcom/google/android/gms/auth/api/credentials/Credential;->getId()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setRequestedPhoneNumber(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onResume(Landroid/app/Activity;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentControllerBase;->onResume(Landroid/app/Activity;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getFocusView()Landroid/view/View;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->showKeyboard(Landroid/view/View;)V

    return-void
.end method

.method public setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->setOnCompleteListener(Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->updateNextButton()V

    return-void
.end method

.method public setButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->buttonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->updateNextButton()V

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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->centerFragment:Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    return-void
.end method

.method public setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->footerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-void
.end method

.method public setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->headerFragment:Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    return-void
.end method

.method public setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PhoneContentController$1;-><init>(Lcom/facebook/accountkit/ui/PhoneContentController;)V

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;->setNextButtonTextProvider(Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;)V

    return-void
.end method

.method public setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    new-instance v0, Lcom/facebook/accountkit/ui/PhoneContentController$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PhoneContentController$2;-><init>(Lcom/facebook/accountkit/ui/PhoneContentController;)V

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setOnPhoneNumberChangedListener(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->getOnCompleteListener()Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setOnCompleteListener(Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getInitialPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getInitialPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$1100(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Lcom/facebook/accountkit/PhoneNumber;)V

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getDefaultCountryCode()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getDefaultCountryCode()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$1200(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;)V

    :cond_2
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getSmsBlacklist()[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getSmsBlacklist()[Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$1300(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;[Ljava/lang/String;)V

    :cond_3
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getSmsWhitelist()[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getSmsWhitelist()[Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$1400(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;[Ljava/lang/String;)V

    :cond_4
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->topFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->isReadPhoneStateEnabled()Z

    move-result v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setReadPhoneStateEnabled(Z)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController;->updateNextButton()V

    return-void
.end method
