.class Landroid/support/transition/TransitionIcs;
.super Landroid/support/transition/TransitionImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/TransitionIcs$CompatListener;,
        Landroid/support/transition/TransitionIcs$TransitionWrapper;
    }
.end annotation


# instance fields
.field private mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

.field mExternalTransition:Landroid/support/transition/TransitionInterface;

.field mTransition:Landroid/support/transition/TransitionPort;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public addListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    if-nez v0, :cond_0

    new-instance v0, Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-direct {v0, p0}, Landroid/support/transition/TransitionIcs$CompatListener;-><init>(Landroid/support/transition/TransitionIcs;)V

    iput-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-virtual {v0, v1}, Landroid/support/transition/TransitionPort;->addListener(Landroid/support/transition/TransitionPort$TransitionListener;)Landroid/support/transition/TransitionPort;

    :cond_0
    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionIcs$CompatListener;->addListener(Landroid/support/transition/TransitionInterfaceListener;)V

    return-object p0
.end method

.method public addTarget(I)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->addTarget(I)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public addTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->addTarget(Landroid/view/View;)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->captureEndValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->captureStartValues(Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2, p3}, Landroid/support/transition/TransitionPort;->createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public excludeChildren(IZ)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeChildren(IZ)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public excludeChildren(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeChildren(Landroid/view/View;Z)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public excludeChildren(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeChildren(Ljava/lang/Class;Z)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public excludeTarget(IZ)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeTarget(IZ)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public excludeTarget(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeTarget(Landroid/view/View;Z)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public excludeTarget(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->excludeTarget(Ljava/lang/Class;Z)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public getDuration()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getDuration()J

    move-result-wide v0

    return-wide v0
.end method

.method public getInterpolator()Landroid/animation/TimeInterpolator;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getInterpolator()Landroid/animation/TimeInterpolator;

    move-result-object v0

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStartDelay()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getStartDelay()J

    move-result-wide v0

    return-wide v0
.end method

.method public getTargetIds()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getTargetIds()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTargets()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getTargets()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionProperties()[Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->getTransitionProperties()[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionValues(Landroid/view/View;Z)Landroid/support/transition/TransitionValues;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->getTransitionValues(Landroid/view/View;Z)Landroid/support/transition/TransitionValues;

    move-result-object p1

    return-object p1
.end method

.method public init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    if-nez p2, :cond_0

    new-instance p2, Landroid/support/transition/TransitionIcs$TransitionWrapper;

    invoke-direct {p2, p1}, Landroid/support/transition/TransitionIcs$TransitionWrapper;-><init>(Landroid/support/transition/TransitionInterface;)V

    :goto_0
    iput-object p2, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    return-void

    :cond_0
    check-cast p2, Landroid/support/transition/TransitionPort;

    goto :goto_0

    return-void
.end method

.method public removeListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    if-nez v0, :cond_0

    return-object p0

    :cond_0
    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionIcs$CompatListener;->removeListener(Landroid/support/transition/TransitionInterfaceListener;)V

    iget-object p1, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-virtual {p1}, Landroid/support/transition/TransitionIcs$CompatListener;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    invoke-virtual {p1, v0}, Landroid/support/transition/TransitionPort;->removeListener(Landroid/support/transition/TransitionPort$TransitionListener;)Landroid/support/transition/TransitionPort;

    const/4 p1, 0x0

    iput-object p1, p0, Landroid/support/transition/TransitionIcs;->mCompatListener:Landroid/support/transition/TransitionIcs$CompatListener;

    :cond_1
    return-object p0
.end method

.method public removeTarget(I)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->removeTarget(I)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public removeTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->removeTarget(Landroid/view/View;)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public setDuration(J)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->setDuration(J)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionPort;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public setStartDelay(J)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionPort;->setStartDelay(J)Landroid/support/transition/TransitionPort;

    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionPort;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
