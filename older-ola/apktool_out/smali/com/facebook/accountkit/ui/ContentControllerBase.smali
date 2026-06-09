.class public abstract Lcom/facebook/accountkit/ui/ContentControllerBase;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/ContentController;


# instance fields
.field protected final configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ContentControllerBase;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    return-void
.end method


# virtual methods
.method public isTransient()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method protected abstract logImpression()V
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    return-void
.end method

.method public onPause(Landroid/app/Activity;)V
    .locals 0

    invoke-static {p1}, Lcom/facebook/accountkit/ui/ViewUtility;->hideKeyboard(Landroid/app/Activity;)V

    return-void
.end method

.method public onResume(Landroid/app/Activity;)V
    .locals 0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ContentControllerBase;->logImpression()V

    return-void
.end method
