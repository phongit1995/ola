.class public Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;
    }
.end annotation


# static fields
.field protected static final COOKIE_URL:Ljava/lang/String; = "https://m.facebook.com/policies/cookies/"

.field protected static final DATA_URL:Ljava/lang/String; = "https://m.facebook.com/about/privacy/"

.field private static final LOGIN_FLOW_STATE:Ljava/lang/String; = "login_flow_state"

.field private static final NEXT_BUTTON_TYPE:Ljava/lang/String; = "next_button_type"

.field private static final RETRY_BUTTON_VISIBLE:Ljava/lang/String; = "retry button visible"

.field private static final RETRY_KEY:Ljava/lang/String; = "retry"

.field protected static final TERMS_URL:Ljava/lang/String; = "https://m.facebook.com/terms"


# instance fields
.field private loginFlowState:Lcom/facebook/accountkit/ui/LoginFlowState;

.field private nextButton:Landroid/widget/Button;

.field private nextButtonEnabled:Z

.field private nextButtonType:Lcom/facebook/accountkit/ui/ButtonType;

.field private onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

.field private retryButton:Landroid/widget/TextView;

.field private retryButtonVisible:Z

.field private termsText:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonEnabled:Z

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButtonVisible:Z

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;)Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

    return-object p0
.end method

.method public static create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/ButtonType;)Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;
    .locals 3
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/facebook/accountkit/ui/LoginFlowState;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/facebook/accountkit/ui/ButtonType;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-virtual {v0, p1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setLoginFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    invoke-virtual {v0, p2}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->setNextButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V

    return-object v0
.end method

.method private getConfirmationCodeAgreementText(Ljava/lang/CharSequence;)Landroid/text/Spanned;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "StringFormatMatches"
        }
    .end annotation

    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_agreement:I

    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const-string p1, "https://m.facebook.com/terms"

    const/4 v2, 0x1

    aput-object p1, v1, v2

    const-string p1, "https://m.facebook.com/about/privacy/"

    const/4 v2, 0x2

    aput-object p1, v1, v2

    const-string p1, "https://m.facebook.com/policies/cookies/"

    const/4 v2, 0x3

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_confirmation_code_bottom:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/view/ViewGroup;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object p2

    sget-object p3, Lcom/facebook/accountkit/ui/SkinManager$Skin;->CONTEMPORARY:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-static {p2, p3}, Lcom/facebook/accountkit/ui/ViewUtility;->isSkin(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/SkinManager$Skin;)Z

    move-result p2

    if-eqz p2, :cond_0

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_next_button:I

    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p3

    check-cast p3, Landroid/view/ViewGroup;

    invoke-virtual {p3, p2}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    sget p3, Lcom/facebook/accountkit/R$id;->com_accountkit_space:I

    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    invoke-virtual {v0, p3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    :cond_0
    return-object p1
.end method

.method public getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->loginFlowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public getRetry()Z
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "retry"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method isKeyboardFragment()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public bridge synthetic onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onActivityCreated(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onStart()V
    .locals 2

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onStart()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->termsText:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    invoke-virtual {v1}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->updateTermsText(Landroid/widget/TextView;Ljava/lang/CharSequence;)V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    invoke-static {}, Lcom/facebook/accountkit/ui/ButtonType;->values()[Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object v0

    const-string v1, "next_button_type"

    invoke-virtual {p2, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginFlowState;->values()[Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    const-string v1, "login_flow_state"

    invoke-virtual {p2, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->loginFlowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v0, "retry button visible"

    const/4 v1, 0x1

    invoke-virtual {p2, v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p2

    iput-boolean p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButtonVisible:Z

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_next_button:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_retry_button:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonEnabled:Z

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    new-instance v0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$1;-><init>(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;)V

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ButtonType;->getValue()I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setText(I)V

    :cond_0
    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    if-eqz p2, :cond_2

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButtonVisible:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    const/16 v0, 0x8

    :goto_0
    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    new-instance v0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$2;-><init>(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;)V

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_2
    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_agreement:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->termsText:Landroid/widget/TextView;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->termsText:Landroid/widget/TextView;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->termsText:Landroid/widget/TextView;

    new-instance p2, Lcom/facebook/accountkit/ui/CustomLinkMovement;

    new-instance v0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$3;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$3;-><init>(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;)V

    invoke-direct {p2, v0}, Lcom/facebook/accountkit/ui/CustomLinkMovement;-><init>(Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;)V

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    :cond_3
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->termsText:Landroid/widget/TextView;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    invoke-virtual {p2}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->updateTermsText(Landroid/widget/TextView;Ljava/lang/CharSequence;)V

    return-void
.end method

.method protected setLoginFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/LoginFlowState;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->loginFlowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "login_flow_state"

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result p1

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method public setNextButtonEnabled(Z)V
    .locals 1

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonEnabled:Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    :cond_0
    return-void
.end method

.method public setNextButtonType(Lcom/facebook/accountkit/ui/ButtonType;)V
    .locals 3

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "next_button_type"

    iget-object v2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButtonType:Lcom/facebook/accountkit/ui/ButtonType;

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/ButtonType;->ordinal()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->nextButton:Landroid/widget/Button;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/ButtonType;->getValue()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(I)V

    :cond_0
    return-void
.end method

.method public setOnCompleteListener(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

    return-void
.end method

.method public setRetry(Z)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "retry"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public setRetryVisible(Z)V
    .locals 3

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButtonVisible:Z

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "retry button visible"

    iget-boolean v2, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButtonVisible:Z

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->retryButton:Landroid/widget/TextView;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method protected updateTermsText(Landroid/widget/TextView;Ljava/lang/CharSequence;)V
    .locals 10

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPrivacyPolicy()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getTermsOfService()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x6

    const/4 v3, 0x5

    const/4 v4, 0x4

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    const/4 v8, 0x0

    if-nez v1, :cond_2

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_agreement_app_privacy_policy_and_terms:I

    const/4 v9, 0x7

    new-array v9, v9, [Ljava/lang/Object;

    aput-object p2, v9, v8

    const-string p2, "https://m.facebook.com/terms"

    aput-object p2, v9, v7

    const-string p2, "https://m.facebook.com/about/privacy/"

    aput-object p2, v9, v6

    const-string p2, "https://m.facebook.com/policies/cookies/"

    aput-object p2, v9, v5

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPrivacyPolicy()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v9, v4

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getTermsOfService()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v9, v3

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationName()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v9, v2

    invoke-virtual {p0, v1, v9}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-static {p2}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object p2

    goto :goto_1

    :cond_2
    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_agreement_app_privacy_policy:I

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p2, v2, v8

    const-string p2, "https://m.facebook.com/terms"

    aput-object p2, v2, v7

    const-string p2, "https://m.facebook.com/about/privacy/"

    aput-object p2, v2, v6

    const-string p2, "https://m.facebook.com/policies/cookies/"

    aput-object p2, v2, v5

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getPrivacyPolicy()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v2, v4

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationName()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_3
    invoke-direct {p0, p2}, Lcom/facebook/accountkit/ui/PrivacyPolicyFragment;->getConfirmationCodeAgreementText(Ljava/lang/CharSequence;)Landroid/text/Spanned;

    move-result-object p2

    :goto_1
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
