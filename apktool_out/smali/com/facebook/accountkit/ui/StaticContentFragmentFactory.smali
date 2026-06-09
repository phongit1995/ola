.class final Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;
    }
.end annotation


# static fields
.field private static final LAYOUT_RESOURCE_ID_KEY:Ljava/lang/String; = "layoutResourceId"

.field private static final LOGIN_FLOW_STATE_KEY:Ljava/lang/String; = "loginFlowState"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;
    .locals 3
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    const-string p0, "loginFlowState"

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->name()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p0, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method static create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;
    .locals 1
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object p0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "layoutResourceId"

    invoke-virtual {p1, v0, p2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-object p0
.end method
