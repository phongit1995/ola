.class public Landroid/support/transition/ChangeBounds;
.super Landroid/support/transition/Transition;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Landroid/support/transition/Transition;-><init>(Z)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/ChangeBoundsIcs;

    invoke-direct {v0, p0}, Landroid/support/transition/ChangeBoundsIcs;-><init>(Landroid/support/transition/TransitionInterface;)V

    :goto_0
    iput-object v0, p0, Landroid/support/transition/ChangeBounds;->mImpl:Landroid/support/transition/TransitionImpl;

    return-void

    :cond_0
    new-instance v0, Landroid/support/transition/ChangeBoundsKitKat;

    invoke-direct {v0, p0}, Landroid/support/transition/ChangeBoundsKitKat;-><init>(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    return-void
.end method


# virtual methods
.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/ChangeBounds;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->captureEndValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/ChangeBounds;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->captureStartValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 1
    .param p1    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/ChangeBounds;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2, p3}, Landroid/support/transition/TransitionImpl;->createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public setResizeClip(Z)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/ChangeBounds;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/ChangeBoundsInterface;

    invoke-interface {v0, p1}, Landroid/support/transition/ChangeBoundsInterface;->setResizeClip(Z)V

    return-void
.end method
