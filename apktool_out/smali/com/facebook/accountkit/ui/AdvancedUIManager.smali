.class public interface abstract Lcom/facebook/accountkit/ui/AdvancedUIManager;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/UIManagerStub;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/AdvancedUIManager$AdvancedUIManagerListener;
    }
.end annotation


# virtual methods
.method public abstract getActionBarFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract setAdvancedUIManagerListener(Lcom/facebook/accountkit/ui/AdvancedUIManager$AdvancedUIManagerListener;)V
.end method
