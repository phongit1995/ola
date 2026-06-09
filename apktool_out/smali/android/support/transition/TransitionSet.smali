.class public Landroid/support/transition/TransitionSet;
.super Landroid/support/transition/Transition;


# static fields
.field public static final ORDERING_SEQUENTIAL:I = 0x1

.field public static final ORDERING_TOGETHER:I


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Landroid/support/transition/Transition;-><init>(Z)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/TransitionSetIcs;

    invoke-direct {v0, p0}, Landroid/support/transition/TransitionSetIcs;-><init>(Landroid/support/transition/TransitionInterface;)V

    :goto_0
    iput-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    return-void

    :cond_0
    new-instance v0, Landroid/support/transition/TransitionSetKitKat;

    invoke-direct {v0, p0}, Landroid/support/transition/TransitionSetKitKat;-><init>(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    return-void
.end method


# virtual methods
.method public addTransition(Landroid/support/transition/Transition;)Landroid/support/transition/TransitionSet;
    .locals 1
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/TransitionSetImpl;

    iget-object p1, p1, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-interface {v0, p1}, Landroid/support/transition/TransitionSetImpl;->addTransition(Landroid/support/transition/TransitionImpl;)Landroid/support/transition/TransitionSetImpl;

    return-object p0
.end method

.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->captureEndValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 1
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

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

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2, p3}, Landroid/support/transition/TransitionImpl;->createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public getOrdering()I
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/TransitionSetImpl;

    invoke-interface {v0}, Landroid/support/transition/TransitionSetImpl;->getOrdering()I

    move-result v0

    return v0
.end method

.method public removeTransition(Landroid/support/transition/Transition;)Landroid/support/transition/TransitionSet;
    .locals 1
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/TransitionSetImpl;

    iget-object p1, p1, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-interface {v0, p1}, Landroid/support/transition/TransitionSetImpl;->removeTransition(Landroid/support/transition/TransitionImpl;)Landroid/support/transition/TransitionSetImpl;

    return-object p0
.end method

.method public setOrdering(I)Landroid/support/transition/TransitionSet;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/TransitionSet;->mImpl:Landroid/support/transition/TransitionImpl;

    check-cast v0, Landroid/support/transition/TransitionSetImpl;

    invoke-interface {v0, p1}, Landroid/support/transition/TransitionSetImpl;->setOrdering(I)Landroid/support/transition/TransitionSetImpl;

    return-object p0
.end method
