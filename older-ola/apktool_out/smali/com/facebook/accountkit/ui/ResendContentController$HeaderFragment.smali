.class public final Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;
.super Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/ResendContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "HeaderFragment"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;-><init>()V

    return-void
.end method

.method public static varargs create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;
    .locals 3
    .param p0    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v0, Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;-><init>()V

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/ui/ViewStateFragment;->UI_MANAGER_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-virtual {v0, p1, p2}, Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;->setTitleResourceId(I[Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$HeaderFragment;->titleView:Landroid/widget/TextView;

    const/16 p2, 0x10

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setGravity(I)V

    return-void
.end method
