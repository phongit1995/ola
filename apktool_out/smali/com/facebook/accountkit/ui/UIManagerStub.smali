.class interface abstract Lcom/facebook/accountkit/ui/UIManagerStub;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# virtual methods
.method public abstract getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract onError(Lcom/facebook/accountkit/AccountKitError;)V
.end method
