.class public final Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "StaticContentFragment"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object p3

    const-string v0, "layoutResourceId"

    sget v1, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_static_content:I

    invoke-virtual {p3, v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result p3

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "loginFlowState"

    sget-object v2, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {v2}, Lcom/facebook/accountkit/ui/LoginFlowState;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/LoginFlowState;->valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginFlowState;

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

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_icon_view:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ViewUtility;->useLegacy(Lcom/facebook/accountkit/ui/UIManager;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    sget v1, Lcom/facebook/accountkit/R$attr;->com_accountkit_icon_color:I

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/ViewUtility;->getColor(Landroid/content/Context;II)I

    move-result v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ViewUtility;->getPrimaryColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v0

    :goto_0
    instance-of v1, p1, Landroid/widget/ImageView;

    if-eqz v1, :cond_1

    check-cast p1, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-static {v1, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeColor(Landroid/content/Context;Landroid/widget/ImageView;I)V

    const-string v0, "loginFlowState"

    invoke-virtual {p2, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    instance-of p2, p2, Landroid/graphics/drawable/Animatable;

    if-eqz p2, :cond_2

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    check-cast p1, Landroid/graphics/drawable/Animatable;

    invoke-interface {p1}, Landroid/graphics/drawable/Animatable;->start()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;->getActivity()Landroid/app/Activity;

    move-result-object p2

    invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-static {p2, p1, v0}, Lcom/facebook/accountkit/ui/ViewUtility;->applyThemeColor(Landroid/content/Context;Landroid/graphics/drawable/Drawable;I)V

    :cond_2
    return-void
.end method
