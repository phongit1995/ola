.class public Lcom/facebook/accountkit/ui/AccountKitSpinner;
.super Landroid/support/v7/widget/AppCompatSpinner;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;
    }
.end annotation


# instance fields
.field private listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private openStarted:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/support/v7/widget/AppCompatSpinner;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/support/v7/widget/AppCompatSpinner;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/support/v7/widget/AppCompatSpinner;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    return-void
.end method

.method private performClosedEvent()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;->onSpinnerClosed()V

    :cond_0
    return-void
.end method


# virtual methods
.method public onWindowFocusChanged(Z)V
    .locals 1

    invoke-super {p0, p1}, Landroid/support/v7/widget/AppCompatSpinner;->onWindowFocusChanged(Z)V

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->performClosedEvent()V

    :cond_0
    return-void
.end method

.method public performClick()Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->openStarted:Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;

    invoke-interface {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;->onSpinnerOpened()V

    :cond_0
    invoke-super {p0}, Landroid/support/v7/widget/AppCompatSpinner;->performClick()Z

    move-result v0

    return v0
.end method

.method setOnSpinnerEventsListener(Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitSpinner;->listener:Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;

    return-void
.end method
