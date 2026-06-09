.class Landroid/support/transition/TransitionKitKat;
.super Landroid/support/transition/TransitionImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x13
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x13
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/TransitionKitKat$CompatListener;,
        Landroid/support/transition/TransitionKitKat$TransitionWrapper;
    }
.end annotation


# instance fields
.field private mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

.field mExternalTransition:Landroid/support/transition/TransitionInterface;

.field mTransition:Landroid/transition/Transition;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionImpl;-><init>()V

    return-void
.end method

.method static convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    new-instance v0, Landroid/transition/TransitionValues;

    invoke-direct {v0}, Landroid/transition/TransitionValues;-><init>()V

    invoke-static {p0, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    return-object v0
.end method

.method static convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    new-instance v0, Landroid/support/transition/TransitionValues;

    invoke-direct {v0}, Landroid/support/transition/TransitionValues;-><init>()V

    invoke-static {p0, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    return-object v0
.end method

.method static copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V
    .locals 1

    if-nez p0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    iput-object v0, p1, Landroid/transition/TransitionValues;->view:Landroid/view/View;

    iget-object v0, p0, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object p1, p1, Landroid/transition/TransitionValues;->values:Ljava/util/Map;

    iget-object p0, p0, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    invoke-interface {p1, p0}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    :cond_1
    return-void
.end method

.method static copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V
    .locals 1

    if-nez p0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Landroid/transition/TransitionValues;->view:Landroid/view/View;

    iput-object v0, p1, Landroid/support/transition/TransitionValues;->view:Landroid/view/View;

    iget-object v0, p0, Landroid/transition/TransitionValues;->values:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object p1, p1, Landroid/support/transition/TransitionValues;->values:Ljava/util/Map;

    iget-object p0, p0, Landroid/transition/TransitionValues;->values:Ljava/util/Map;

    invoke-interface {p1, p0}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    :cond_1
    return-void
.end method

.method static wrapCaptureEndValues(Landroid/support/transition/TransitionInterface;Landroid/transition/TransitionValues;)V
    .locals 1

    new-instance v0, Landroid/support/transition/TransitionValues;

    invoke-direct {v0}, Landroid/support/transition/TransitionValues;-><init>()V

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    invoke-interface {p0, v0}, Landroid/support/transition/TransitionInterface;->captureEndValues(Landroid/support/transition/TransitionValues;)V

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    return-void
.end method

.method static wrapCaptureStartValues(Landroid/support/transition/TransitionInterface;Landroid/transition/TransitionValues;)V
    .locals 1

    new-instance v0, Landroid/support/transition/TransitionValues;

    invoke-direct {v0}, Landroid/support/transition/TransitionValues;-><init>()V

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    invoke-interface {p0, v0}, Landroid/support/transition/TransitionInterface;->captureStartValues(Landroid/support/transition/TransitionValues;)V

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    return-void
.end method


# virtual methods
.method public addListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    if-nez v0, :cond_0

    new-instance v0, Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-direct {v0, p0}, Landroid/support/transition/TransitionKitKat$CompatListener;-><init>(Landroid/support/transition/TransitionKitKat;)V

    iput-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    iget-object v1, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-virtual {v0, v1}, Landroid/transition/Transition;->addListener(Landroid/transition/Transition$TransitionListener;)Landroid/transition/Transition;

    :cond_0
    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionKitKat$CompatListener;->addListener(Landroid/support/transition/TransitionInterfaceListener;)V

    return-object p0
.end method

.method public addTarget(I)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1}, Landroid/transition/Transition;->addTarget(I)Landroid/transition/Transition;

    return-object p0
.end method

.method public addTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1}, Landroid/transition/Transition;->addTarget(Landroid/view/View;)Landroid/transition/Transition;

    return-object p0
.end method

.method public captureEndValues(Landroid/support/transition/TransitionValues;)V
    .locals 2

    new-instance v0, Landroid/transition/TransitionValues;

    invoke-direct {v0}, Landroid/transition/TransitionValues;-><init>()V

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    iget-object v1, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v1, v0}, Landroid/transition/Transition;->captureEndValues(Landroid/transition/TransitionValues;)V

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/support/transition/TransitionValues;)V
    .locals 2

    new-instance v0, Landroid/transition/TransitionValues;

    invoke-direct {v0}, Landroid/transition/TransitionValues;-><init>()V

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    iget-object v1, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v1, v0}, Landroid/transition/Transition;->captureStartValues(Landroid/transition/TransitionValues;)V

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    return-void
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 2

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    new-instance v1, Landroid/transition/TransitionValues;

    invoke-direct {v1}, Landroid/transition/TransitionValues;-><init>()V

    invoke-static {p2, v1}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    if-eqz p3, :cond_1

    new-instance v0, Landroid/transition/TransitionValues;

    invoke-direct {v0}, Landroid/transition/TransitionValues;-><init>()V

    invoke-static {p3, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/support/transition/TransitionValues;Landroid/transition/TransitionValues;)V

    :cond_1
    iget-object p2, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {p2, p1, v1, v0}, Landroid/transition/Transition;->createAnimator(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;Landroid/transition/TransitionValues;)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public excludeChildren(IZ)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeChildren(IZ)Landroid/transition/Transition;

    return-object p0
.end method

.method public excludeChildren(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeChildren(Landroid/view/View;Z)Landroid/transition/Transition;

    return-object p0
.end method

.method public excludeChildren(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeChildren(Ljava/lang/Class;Z)Landroid/transition/Transition;

    return-object p0
.end method

.method public excludeTarget(IZ)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeTarget(IZ)Landroid/transition/Transition;

    return-object p0
.end method

.method public excludeTarget(Landroid/view/View;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeTarget(Landroid/view/View;Z)Landroid/transition/Transition;

    return-object p0
.end method

.method public excludeTarget(Ljava/lang/Class;Z)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->excludeTarget(Ljava/lang/Class;Z)Landroid/transition/Transition;

    return-object p0
.end method

.method public getDuration()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getDuration()J

    move-result-wide v0

    return-wide v0
.end method

.method public getInterpolator()Landroid/animation/TimeInterpolator;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getInterpolator()Landroid/animation/TimeInterpolator;

    move-result-object v0

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStartDelay()J
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getStartDelay()J

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

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getTargetIds()Ljava/util/List;

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

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getTargets()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionProperties()[Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->getTransitionProperties()[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTransitionValues(Landroid/view/View;Z)Landroid/support/transition/TransitionValues;
    .locals 2

    new-instance v0, Landroid/support/transition/TransitionValues;

    invoke-direct {v0}, Landroid/support/transition/TransitionValues;-><init>()V

    iget-object v1, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v1, p1, p2}, Landroid/transition/Transition;->getTransitionValues(Landroid/view/View;Z)Landroid/transition/TransitionValues;

    move-result-object p1

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    return-object v0
.end method

.method public init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/TransitionKitKat;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    if-nez p2, :cond_0

    new-instance p2, Landroid/support/transition/TransitionKitKat$TransitionWrapper;

    invoke-direct {p2, p1}, Landroid/support/transition/TransitionKitKat$TransitionWrapper;-><init>(Landroid/support/transition/TransitionInterface;)V

    :goto_0
    iput-object p2, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    return-void

    :cond_0
    check-cast p2, Landroid/transition/Transition;

    goto :goto_0

    return-void
.end method

.method public removeListener(Landroid/support/transition/TransitionInterfaceListener;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    if-nez v0, :cond_0

    return-object p0

    :cond_0
    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionKitKat$CompatListener;->removeListener(Landroid/support/transition/TransitionInterfaceListener;)V

    iget-object p1, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-virtual {p1}, Landroid/support/transition/TransitionKitKat$CompatListener;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    invoke-virtual {p1, v0}, Landroid/transition/Transition;->removeListener(Landroid/transition/Transition$TransitionListener;)Landroid/transition/Transition;

    const/4 p1, 0x0

    iput-object p1, p0, Landroid/support/transition/TransitionKitKat;->mCompatListener:Landroid/support/transition/TransitionKitKat$CompatListener;

    :cond_1
    return-object p0
.end method

.method public removeTarget(I)Landroid/support/transition/TransitionImpl;
    .locals 1

    if-lez p1, :cond_0

    invoke-virtual {p0}, Landroid/support/transition/TransitionKitKat;->getTargetIds()Ljava/util/List;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-object p0
.end method

.method public removeTarget(Landroid/view/View;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1}, Landroid/transition/Transition;->removeTarget(Landroid/view/View;)Landroid/transition/Transition;

    return-object p0
.end method

.method public setDuration(J)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->setDuration(J)Landroid/transition/Transition;

    return-object p0
.end method

.method public setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1}, Landroid/transition/Transition;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/transition/Transition;

    return-object p0
.end method

.method public setStartDelay(J)Landroid/support/transition/TransitionImpl;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0, p1, p2}, Landroid/transition/Transition;->setStartDelay(J)Landroid/transition/Transition;

    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    invoke-virtual {v0}, Landroid/transition/Transition;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
