.class public final Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TopFragment"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;
    }
.end annotation


# static fields
.field private static final APP_SUPPLIED_EMAIL_KEY:Ljava/lang/String; = "appSuppliedEmail"

.field private static final SELECTED_EMAIL_KEY:Ljava/lang/String; = "selectedEmail"


# instance fields
.field private emailView:Landroid/widget/AutoCompleteTextView;

.field private emailViewLayout:Landroid/support/design/widget/TextInputLayout;

.field private onCompleteListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;

.field private onEmailChangedListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method

.method static synthetic access$1100(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/support/design/widget/TextInputLayout;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailViewLayout:Landroid/support/design/widget/TextInputLayout;

    return-object p0
.end method

.method static synthetic access$300(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->onEmailChangedListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;

    return-object p0
.end method

.method static synthetic access$400(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;

    return-object p0
.end method

.method static synthetic access$500(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/widget/AutoCompleteTextView;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    return-object p0
.end method

.method private fillEmail()V
    .locals 8

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->getDeviceEmailsIfAvailable(Landroid/content/Context;)Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    new-instance v3, Landroid/widget/ArrayAdapter;

    const v4, 0x109000a

    invoke-direct {v3, v0, v4, v1}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    invoke-virtual {v2, v3}, Landroid/widget/AutoCompleteTextView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    new-instance v1, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;-><init>(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)V

    invoke-virtual {v0, v1}, Landroid/widget/AutoCompleteTextView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getAppSuppliedEmail()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    invoke-virtual {v1, v0}, Landroid/widget/AutoCompleteTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/AutoCompleteTextView;->setSelection(I)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->hasGooglePlayServices(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getCurrentState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v1

    invoke-static {}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$100()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v2

    if-ne v1, v2, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getEmail()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    new-instance v1, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;

    invoke-direct {v1}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;->setEmailAddressIdentifierSupported(Z)Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;->build()Lcom/google/android/gms/auth/api/credentials/HintRequest;

    move-result-object v1

    sget-object v2, Lcom/google/android/gms/auth/api/Auth;->CredentialsApi:Lcom/google/android/gms/auth/api/credentials/CredentialsApi;

    invoke-interface {v2, v0, v1}, Lcom/google/android/gms/auth/api/credentials/CredentialsApi;->getHintPickerIntent(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/auth/api/credentials/HintRequest;)Landroid/app/PendingIntent;

    move-result-object v0

    :try_start_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-virtual {v0}, Landroid/app/PendingIntent;->getIntentSender()Landroid/content/IntentSender;

    move-result-object v2

    const/16 v3, 0x98

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v1 .. v7}, Landroid/app/Activity;->startIntentSenderForResult(Landroid/content/IntentSender;ILandroid/content/Intent;III)V
    :try_end_0
    .catch Landroid/content/IntentSender$SendIntentException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    sget-object v1, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->TAG:Ljava/lang/String;

    const-string v2, "Failed to send intent"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_2
    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_email_login_top:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public getAppSuppliedEmail()Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "appSuppliedEmail"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEmail()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    invoke-virtual {v0}, Landroid/widget/AutoCompleteTextView;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$100()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0
.end method

.method public getSelectedEmail()Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "selectedEmail"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method isKeyboardFragment()Z
    .locals 1

    const/4 v0, 0x0

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
    .locals 0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onStart()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->fillEmail()V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_email:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/AutoCompleteTextView;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_email_layout:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/support/design/widget/TextInputLayout;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailViewLayout:Landroid/support/design/widget/TextInputLayout;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    new-instance p2, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;

    invoke-direct {p2, p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;-><init>(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)V

    invoke-virtual {p1, p2}, Landroid/widget/AutoCompleteTextView;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    new-instance p2, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;

    invoke-direct {p2, p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;-><init>(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)V

    invoke-virtual {p1, p2}, Landroid/widget/AutoCompleteTextView;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    const/16 p2, 0x21

    invoke-virtual {p1, p2}, Landroid/widget/AutoCompleteTextView;->setInputType(I)V

    :cond_0
    return-void
.end method

.method public setAppSuppliedEmail(Ljava/lang/String;)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "appSuppliedEmail"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setOnCompleteListener(Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;

    return-void
.end method

.method public setOnEmailChangedListener(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->onEmailChangedListener:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;

    return-void
.end method

.method public setRequestedHintEmail(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    invoke-virtual {v0, p1}, Landroid/widget/AutoCompleteTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->emailView:Landroid/widget/AutoCompleteTextView;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/AutoCompleteTextView;->setSelection(I)V

    return-void
.end method

.method public setSelectedEmail(Ljava/lang/String;)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "selectedEmail"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
