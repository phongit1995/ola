.class public abstract Landroid/support/transition/Transition;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/transition/TransitionInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/Transition$TransitionListener;
    }
.end annotation


# instance fields
.field mImpl:Landroid/support/transition/TransitionImpl;


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroid/support/transition/Transition;-><init>(Z)V

    return-void
.end method

.method constructor <init>(Z)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-nez p1, :cond_2

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x17

    if-lt p1, v0, :cond_0

    new-instance p1, Landroid/support/transition/TransitionApi23;

    invoke-direct {p1}, Landroid/support/transition/TransitionApi23;-><init>()V

    :goto_0
    iput-object p1, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    goto :goto_1

    :cond_0
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x13

    if-lt p1, v0, :cond_1

    new-instance p1, Landroid/support/transition/TransitionKitKat;

    invoke-direct {p1}, Landroid/support/transition/TransitionKitKat;-><init>()V

    goto :goto_0

    :cond_1
    new-instance p1, Landroid/support/transition/TransitionIcs;

    invoke-direct {p1}, Landroid/support/transition/TransitionIcs;-><init>()V

    goto :goto_0

    :goto_1
    iget-object p1, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {p1, p0}, Landroid/support/transition/TransitionImpl;->init(Landroid/support/transition/TransitionInterface;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public addListener(Landroid/support/transition/Transition$TransitionListener;)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/support/transition/Transition$TransitionListener;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->addListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public addTarget(I)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->addTarget(I)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public addTarget(Landroid/view/View;)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->addTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public abstract captureEndValues(Landroid/support/transition/TransitionValues;)V
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
.end method

.method public abstract captureStartValues(Landroid/support/transition/TransitionValues;)V
    .param p1    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 0
    .param p1    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Landroid/support/transition/TransitionValues;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public excludeChildren(IZ)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeChildren(IZ)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public excludeChildren(Landroid/view/View;Z)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeChildren(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public excludeChildren(Ljava/lang/Class;Z)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Ljava/lang/Class;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeChildren(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public excludeTarget(IZ)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeTarget(IZ)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public excludeTarget(Landroid/view/View;Z)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeTarget(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public excludeTarget(Ljava/lang/Class;Z)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Ljava/lang/Class;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->excludeTarget(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public getDuration()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getDuration()J

    move-result-wide v0

    return-wide v0
.end method

.method public getInterpolator()Landroid/animation/TimeInterpolator;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getInterpolator()Landroid/animation/TimeInterpolator;

    move-result-object v0

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStartDelay()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getStartDelay()J

    move-result-wide v0

    return-wide v0
.end method

.method public getTargetIds()Ljava/util/List;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getTargetIds()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTargets()Ljava/util/List;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getTargets()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionProperties()[Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Landroid/support/transition/TransitionImpl;->getTransitionProperties()[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionValues(Landroid/view/View;Z)Landroid/support/transition/TransitionValues;
    .locals 1
    .param p1    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->getTransitionValues(Landroid/view/View;Z)Landroid/support/transition/TransitionValues;

    move-result-object p1

    return-object p1
.end method

.method public removeListener(Landroid/support/transition/Transition$TransitionListener;)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/support/transition/Transition$TransitionListener;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->removeListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public removeTarget(I)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # I
        .annotation build Landroid/support/annotation/IdRes;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->removeTarget(I)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public removeTarget(Landroid/view/View;)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->removeTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public setDuration(J)Landroid/support/transition/Transition;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->setDuration(J)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/Transition;
    .locals 1
    .param p1    # Landroid/animation/TimeInterpolator;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionImpl;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public setStartDelay(J)Landroid/support/transition/Transition;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionImpl;->setStartDelay(J)Landroid/support/transition/TransitionImpl;

    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
