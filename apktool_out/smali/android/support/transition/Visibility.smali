.class public abstract Landroid/support/transition/Visibility;
.super Landroid/support/transition/Transition;

# interfaces
.implements Landroid/support/transition/VisibilityInterface;


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroid/support/transition/Visibility;-><init>(Z)V

    return-void
.end method

.method constructor <init>(Z)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Landroid/support/transition/Transition;-><init>(Z)V

    if-nez p1, :cond_1

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x13

    if-lt p1, v0, :cond_0

    new-instance p1, Landroid/support/transition/VisibilityKitKat;

    invoke-direct {p1}, Landroid/support/transition/VisibilityKitKat;-><init>()V

    :goto_0
    iput-object p1, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    goto :goto_1

    :cond_0
    new-instance p1, Landroid/support/transition/VisibilityIcs;

    invoke-direct {p1}, Landroid/support/transition/VisibilityIcs;-><init>()V

    goto :goto_0

    :goto_1
    iget-object p1, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {p1, p0}, Landroid/support/transition/TransitionImpl;->init(Landroid/support/transition/TransitionInterface;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->captureEndValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->captureStartValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public isVisible(Landroid/support/transition/TransitionValues;)Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/VisibilityImpl;

    invoke-interface {v0, p1}, Landroid/support/transition/VisibilityImpl;->isVisible(Landroid/support/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    move-object v1, v0

    check-cast v1, Landroid/support/transition/VisibilityImpl;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-interface/range {v1 .. v6}, Landroid/support/transition/VisibilityImpl;->onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/Visibility;->mImpl:Landroid/support/transition/TransitionImpl;

    move-object v1, v0

    check-cast v1, Landroid/support/transition/VisibilityImpl;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-interface/range {v1 .. v6}, Landroid/support/transition/VisibilityImpl;->onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
