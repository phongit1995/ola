.class abstract Lcom/facebook/accountkit/ui/ContentFragment;
.super Lcom/facebook/accountkit/ui/LoginFragment;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/LoginFragment;-><init>()V

    return-void
.end method


# virtual methods
.method protected getCurrentState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-eqz v1, :cond_0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getCurrentState()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method protected getGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_0

    instance-of v1, v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    if-eqz v1, :cond_0

    check-cast v0, Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method abstract getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
.end method

.method abstract isKeyboardFragment()Z
.end method
