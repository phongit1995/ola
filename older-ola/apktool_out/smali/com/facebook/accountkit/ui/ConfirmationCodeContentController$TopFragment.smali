.class public final Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TopFragment"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;
    }
.end annotation


# static fields
.field private static final DETECTED_CONFIRMATION_CODE_KEY:Ljava/lang/String; = "detectedConfirmationCode"

.field private static final TEXT_UPDATED_KEY:Ljava/lang/String; = "textUpdated"


# instance fields
.field private confirmationCodeViews:[Landroid/widget/EditText;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

.field private onConfirmationCodeChangedListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

    return-object p0
.end method

.method static synthetic access$200(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/view/View;)Landroid/widget/EditText;
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->focusOnPrevious(Landroid/view/View;)Landroid/widget/EditText;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)[Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic access$500(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Z
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getTextUpdated()Z

    move-result p0

    return p0
.end method

.method static synthetic access$600(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->setTextUpdated(Z)V

    return-void
.end method

.method static synthetic access$700(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/view/View;)Landroid/widget/EditText;
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->focusOnNext(Landroid/view/View;)Landroid/widget/EditText;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$800(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onConfirmationCodeChangedListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;

    return-object p0
.end method

.method private clearCodeWhenRestart()V
    .locals 6

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "is_error_restart"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v1, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    const-string v5, ""

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "is_error_restart"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    :cond_2
    return-void
.end method

.method private focusOnNext(Landroid/view/View;)Landroid/widget/EditText;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getConfirmationCodeViewIndex(Landroid/view/View;)I

    move-result p1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v0, v0

    const/4 v2, 0x1

    sub-int/2addr v0, v2

    if-ge p1, v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    add-int/2addr p1, v2

    aget-object p1, v0, p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    return-object p1

    :cond_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v0, v0

    sub-int/2addr v0, v2

    aget-object p1, p1, v0

    invoke-virtual {p1, v2}, Landroid/widget/EditText;->setSelection(I)V

    return-object v1
.end method

.method private focusOnPrevious(Landroid/view/View;)Landroid/widget/EditText;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getConfirmationCodeViewIndex(Landroid/view/View;)I

    move-result p1

    if-lez p1, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    add-int/lit8 p1, p1, -0x1

    aget-object p1, v0, p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    return-object p1

    :cond_1
    return-object v1
.end method

.method private getConfirmationCodeViewIndex(Landroid/view/View;)I
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v0, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    aget-object v3, v3, v2

    if-ne v3, p1, :cond_1

    return v2

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return v1
.end method

.method private getTextUpdated()Z
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "textUpdated"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private setTextUpdated(Z)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "textUpdated"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method private updateDetectedConfirmationCode()V
    .locals 7

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getDetectedConfirmationCode()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v2, v2

    if-eq v1, v2, :cond_2

    return-void

    :cond_2
    iget-object v2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v3, v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v3, :cond_4

    aget-object v6, v2, v5

    invoke-virtual {v6}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v6

    invoke-interface {v6}, Landroid/text/Editable;->length()I

    move-result v6

    if-eqz v6, :cond_3

    return-void

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_4
    :goto_1
    if-ge v4, v1, :cond_5

    iget-object v2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    aget-object v2, v2, v4

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_5
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v1, v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    aget-object v0, v0, v1

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setSelection(I)V

    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_confirmation_code_top:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public getConfirmationCode()Ljava/lang/String;
    .locals 5
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-object v4, v1, v3

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDetectedConfirmationCode()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "detectedConfirmationCode"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getFocusView()Landroid/view/View;
    .locals 6
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v2, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v0, v3

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v5

    invoke-interface {v5}, Landroid/text/Editable;->length()I

    move-result v5

    if-nez v5, :cond_1

    return-object v4

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    return-object v1
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->access$000()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0
.end method

.method public isConfirmationCodeValid()Z
    .locals 6

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v2, v0

    const/4 v3, 0x0

    :goto_0
    const/4 v4, 0x1

    if-ge v3, v2, :cond_2

    aget-object v5, v0, v3

    invoke-virtual {v5}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v5

    invoke-interface {v5}, Landroid/text/Editable;->length()I

    move-result v5

    if-eq v5, v4, :cond_1

    return v1

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    return v4
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

.method public onResume()V
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onResume()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->clearCodeWhenRestart()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getFocusView()Landroid/view/View;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ViewUtility;->showKeyboard(Landroid/view/View;)V

    return-void
.end method

.method public onRetry()V
    .locals 6

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    const-string v5, ""

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v0, v0

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    aget-object v0, v0, v2

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    :cond_2
    return-void
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 6

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object p2

    instance-of v0, p2, Lcom/facebook/accountkit/ui/BaseUIManager;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    check-cast p2, Lcom/facebook/accountkit/ui/BaseUIManager;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/BaseUIManager;->getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object p2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-ne p2, v0, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    const-string p2, "is_error_restart"

    invoke-virtual {p1, p2, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-ne p2, v0, :cond_1

    return-void

    :cond_1
    const/4 p2, 0x6

    new-array p2, p2, [Landroid/widget/EditText;

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_1:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    const/4 v2, 0x0

    aput-object v0, p2, v2

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_2:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    aput-object v0, p2, v1

    const/4 v0, 0x2

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_3:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    aput-object v1, p2, v0

    const/4 v0, 0x3

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_4:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    aput-object v1, p2, v0

    const/4 v0, 0x4

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_5:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    aput-object v1, p2, v0

    const/4 v0, 0x5

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_confirmation_code_6:I

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    aput-object p1, p2, v0

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length p2, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p2, :cond_3

    aget-object v1, p1, v0

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-interface {v3}, Landroid/text/Editable;->length()I

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v1}, Landroid/widget/EditText;->clearFocus()V

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    new-instance p1, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$1;

    invoke-direct {p1, p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$1;-><init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)V

    new-instance p2, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$2;

    invoke-direct {p2, p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$2;-><init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->confirmationCodeViews:[Landroid/widget/EditText;

    array-length v1, v0

    :goto_1
    if-ge v2, v1, :cond_5

    aget-object v3, v0, v2

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setRawInputType(I)V

    invoke-virtual {v3, p1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    instance-of v4, v3, Lcom/facebook/accountkit/ui/NotifyingEditText;

    if-eqz v4, :cond_4

    move-object v4, v3

    check-cast v4, Lcom/facebook/accountkit/ui/NotifyingEditText;

    invoke-virtual {v4, p2}, Lcom/facebook/accountkit/ui/NotifyingEditText;->setOnSoftKeyListener(Landroid/view/View$OnKeyListener;)V

    new-instance v5, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;

    invoke-direct {v5, p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;-><init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)V

    invoke-virtual {v4, v5}, Lcom/facebook/accountkit/ui/NotifyingEditText;->setPasteListener(Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;)V

    :cond_4
    new-instance v4, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;

    invoke-direct {v4, p0, v3}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$4;-><init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/widget/EditText;)V

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_5
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->updateDetectedConfirmationCode()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getFocusView()Landroid/view/View;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->showKeyboard(Landroid/view/View;)V

    return-void
.end method

.method public setDetectedConfirmationCode(Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "detectedConfirmationCode"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->updateDetectedConfirmationCode()V

    return-void
.end method

.method public setOnCompleteListener(Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PrivacyPolicyFragment$OnCompleteListener;

    return-void
.end method

.method public setOnConfirmationCodeChangedListener(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onConfirmationCodeChangedListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$OnConfirmationCodeChangedListener;

    return-void
.end method
