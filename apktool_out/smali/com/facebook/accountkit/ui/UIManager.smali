.class public interface abstract Lcom/facebook/accountkit/ui/UIManager;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/UIManagerStub;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;
    }
.end annotation


# virtual methods
.method public abstract getThemeId()I
    .annotation build Landroid/support/annotation/StyleRes;
    .end annotation
.end method

.method public abstract setThemeId(I)V
    .param p1    # I
        .annotation build Landroid/support/annotation/StyleRes;
        .end annotation
    .end param
.end method

.method public abstract setUIManagerListener(Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;)V
.end method
