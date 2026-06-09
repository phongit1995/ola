.class public Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
.super Lcom/facebook/accountkit/ui/LoginFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/TitleFragmentFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "TitleFragment"
.end annotation


# static fields
.field private static final TITLE_KEY:Ljava/lang/String; = "title"

.field private static final TITLE_RESOURCE_ARGS_KEY:Ljava/lang/String; = "titleResourceArgs"

.field private static final TITLE_RESOURCE_ID_KEY:Ljava/lang/String; = "titleResourceId"


# instance fields
.field protected titleView:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/LoginFragment;-><init>()V

    return-void
.end method

.method private getTitle()Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "title"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getTitleResourceArgs()[Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "titleResourceArgs"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getTitleResourceId()I
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "titleResourceId"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private updateTitleView()V
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getTitle()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getTitleResourceId()I

    move-result v1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getTitleResourceArgs()[Ljava/lang/String;

    move-result-object v3

    if-lez v1, :cond_2

    if-eqz v3, :cond_2

    array-length v4, v3

    if-eqz v4, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getActivity()Landroid/app/Activity;

    move-result-object v4

    if-eqz v4, :cond_2

    check-cast v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v3}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :cond_1
    const/4 v1, 0x0

    :cond_2
    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v1, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_3
    if-lez v1, :cond_4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_title:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/LoginFragment;->onActivityCreated(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/LoginFragment;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/LoginFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/LoginFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/LoginFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_title:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->titleView:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->updateTitleView()V

    return-void
.end method

.method public setTitle(Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "title"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->updateTitleView()V

    return-void
.end method

.method public varargs setTitleResourceId(I[Ljava/lang/String;)V
    .locals 2
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "titleResourceId"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string p1, "titleResourceArgs"

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->updateTitleView()V

    return-void
.end method
