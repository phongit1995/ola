.class final Lcom/facebook/accountkit/ui/TitleFragmentFactory;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 3
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    return-object v0
.end method

.method public static varargs create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
    .locals 0
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-static {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    return-object p0
.end method
