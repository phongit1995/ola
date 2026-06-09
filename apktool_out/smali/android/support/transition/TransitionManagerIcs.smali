.class Landroid/support/transition/TransitionManagerIcs;
.super Landroid/support/transition/TransitionManagerImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# instance fields
.field private final mTransitionManager:Landroid/support/transition/TransitionManagerPort;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionManagerImpl;-><init>()V

    new-instance v0, Landroid/support/transition/TransitionManagerPort;

    invoke-direct {v0}, Landroid/support/transition/TransitionManagerPort;-><init>()V

    iput-object v0, p0, Landroid/support/transition/TransitionManagerIcs;->mTransitionManager:Landroid/support/transition/TransitionManagerPort;

    return-void
.end method


# virtual methods
.method public setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerIcs;->mTransitionManager:Landroid/support/transition/TransitionManagerPort;

    check-cast p1, Landroid/support/transition/SceneIcs;

    iget-object p1, p1, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    check-cast p2, Landroid/support/transition/SceneIcs;

    iget-object p2, p2, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    if-nez p3, :cond_0

    const/4 p3, 0x0

    goto :goto_0

    :cond_0
    check-cast p3, Landroid/support/transition/TransitionIcs;

    iget-object p3, p3, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    :goto_0
    invoke-virtual {v0, p1, p2, p3}, Landroid/support/transition/TransitionManagerPort;->setTransition(Landroid/support/transition/ScenePort;Landroid/support/transition/ScenePort;Landroid/support/transition/TransitionPort;)V

    return-void
.end method

.method public setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerIcs;->mTransitionManager:Landroid/support/transition/TransitionManagerPort;

    check-cast p1, Landroid/support/transition/SceneIcs;

    iget-object p1, p1, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    check-cast p2, Landroid/support/transition/TransitionIcs;

    iget-object p2, p2, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    :goto_0
    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionManagerPort;->setTransition(Landroid/support/transition/ScenePort;Landroid/support/transition/TransitionPort;)V

    return-void
.end method

.method public transitionTo(Landroid/support/transition/SceneImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerIcs;->mTransitionManager:Landroid/support/transition/TransitionManagerPort;

    check-cast p1, Landroid/support/transition/SceneIcs;

    iget-object p1, p1, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionManagerPort;->transitionTo(Landroid/support/transition/ScenePort;)V

    return-void
.end method
