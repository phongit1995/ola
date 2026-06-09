.class final Lcom/facebook/accountkit/ui/UpdateErrorContentController;
.super Lcom/facebook/accountkit/ui/ErrorContentController;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;
    }
.end annotation


# instance fields
.field private bottomFragment:Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/ErrorContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method


# virtual methods
.method public getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;-><init>()V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    return-object v0
.end method

.method public setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    instance-of v0, p1, Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    if-nez v0, :cond_0

    return-void

    :cond_0
    check-cast p1, Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->bottomFragment:Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/UpdateErrorContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p1

    sget-object v0, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateErrorContentController;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    return-void
.end method
