.class interface abstract Lcom/facebook/accountkit/ui/ContentController;
.super Ljava/lang/Object;


# virtual methods
.method public abstract getBottomFragment()Lcom/facebook/accountkit/ui/ContentFragment;
.end method

.method public abstract getCenterFragment()Lcom/facebook/accountkit/ui/ContentFragment;
.end method

.method public abstract getFocusView()Landroid/view/View;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getFooterFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
.end method

.method public abstract getHeaderFragment()Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
.end method

.method public abstract getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
.end method

.method public abstract getTextFragment()Lcom/facebook/accountkit/ui/ContentFragment;
.end method

.method public abstract getTopFragment()Lcom/facebook/accountkit/ui/ContentFragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract isTransient()Z
.end method

.method public abstract onActivityResult(IILandroid/content/Intent;)V
.end method

.method public abstract onPause(Landroid/app/Activity;)V
.end method

.method public abstract onResume(Landroid/app/Activity;)V
.end method

.method public abstract setBottomFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method

.method public abstract setCenterFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method

.method public abstract setFooterFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method

.method public abstract setHeaderFragment(Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method

.method public abstract setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method

.method public abstract setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
    .param p1    # Lcom/facebook/accountkit/ui/ContentFragment;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
.end method
