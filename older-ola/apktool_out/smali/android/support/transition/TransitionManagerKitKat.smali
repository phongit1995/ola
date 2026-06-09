.class Landroid/support/transition/TransitionManagerKitKat;
.super Landroid/support/transition/TransitionManagerImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x13
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x13
.end annotation


# instance fields
.field private final mTransitionManager:Landroid/transition/TransitionManager;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionManagerImpl;-><init>()V

    new-instance v0, Landroid/transition/TransitionManager;

    invoke-direct {v0}, Landroid/transition/TransitionManager;-><init>()V

    iput-object v0, p0, Landroid/support/transition/TransitionManagerKitKat;->mTransitionManager:Landroid/transition/TransitionManager;

    return-void
.end method


# virtual methods
.method public setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerKitKat;->mTransitionManager:Landroid/transition/TransitionManager;

    check-cast p1, Landroid/support/transition/SceneWrapper;

    iget-object p1, p1, Landroid/support/transition/SceneWrapper;->mScene:Landroid/transition/Scene;

    check-cast p2, Landroid/support/transition/SceneWrapper;

    iget-object p2, p2, Landroid/support/transition/SceneWrapper;->mScene:Landroid/transition/Scene;

    if-nez p3, :cond_0

    const/4 p3, 0x0

    goto :goto_0

    :cond_0
    check-cast p3, Landroid/support/transition/TransitionKitKat;

    iget-object p3, p3, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    :goto_0
    invoke-virtual {v0, p1, p2, p3}, Landroid/transition/TransitionManager;->setTransition(Landroid/transition/Scene;Landroid/transition/Scene;Landroid/transition/Transition;)V

    return-void
.end method

.method public setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerKitKat;->mTransitionManager:Landroid/transition/TransitionManager;

    check-cast p1, Landroid/support/transition/SceneWrapper;

    iget-object p1, p1, Landroid/support/transition/SceneWrapper;->mScene:Landroid/transition/Scene;

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    check-cast p2, Landroid/support/transition/TransitionKitKat;

    iget-object p2, p2, Landroid/support/transition/TransitionKitKat;->mTransition:Landroid/transition/Transition;

    :goto_0
    invoke-virtual {v0, p1, p2}, Landroid/transition/TransitionManager;->setTransition(Landroid/transition/Scene;Landroid/transition/Transition;)V

    return-void
.end method

.method public transitionTo(Landroid/support/transition/SceneImpl;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionManagerKitKat;->mTransitionManager:Landroid/transition/TransitionManager;

    check-cast p1, Landroid/support/transition/SceneWrapper;

    iget-object p1, p1, Landroid/support/transition/SceneWrapper;->mScene:Landroid/transition/Scene;

    invoke-virtual {v0, p1}, Landroid/transition/TransitionManager;->transitionTo(Landroid/transition/Scene;)V

    return-void
.end method
