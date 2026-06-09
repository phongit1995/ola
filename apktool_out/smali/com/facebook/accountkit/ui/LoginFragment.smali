.class abstract Lcom/facebook/accountkit/ui/LoginFragment;
.super Lcom/facebook/accountkit/ui/ViewStateFragment;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ViewStateFragment;-><init>()V

    return-void
.end method


# virtual methods
.method protected abstract createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ViewStateFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-virtual {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/LoginFragment;->createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v0

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginFragment;->getActivity()Landroid/app/Activity;

    move-result-object p1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object p2

    invoke-static {p1, p2, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeAttributes(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;Landroid/view/View;)V

    return-object v0
.end method
