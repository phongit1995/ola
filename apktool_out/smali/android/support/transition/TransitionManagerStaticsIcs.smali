.class Landroid/support/transition/TransitionManagerStaticsIcs;
.super Landroid/support/transition/TransitionManagerStaticsImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionManagerStaticsImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public beginDelayedTransition(Landroid/view/ViewGroup;)V
    .locals 0

    invoke-static {p1}, Landroid/support/transition/TransitionManagerPort;->beginDelayedTransition(Landroid/view/ViewGroup;)V

    return-void
.end method

.method public beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/TransitionImpl;)V
    .locals 0

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    check-cast p2, Landroid/support/transition/TransitionIcs;

    iget-object p2, p2, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    :goto_0
    invoke-static {p1, p2}, Landroid/support/transition/TransitionManagerPort;->beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/TransitionPort;)V

    return-void
.end method

.method public go(Landroid/support/transition/SceneImpl;)V
    .locals 0

    check-cast p1, Landroid/support/transition/SceneIcs;

    iget-object p1, p1, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-static {p1}, Landroid/support/transition/TransitionManagerPort;->go(Landroid/support/transition/ScenePort;)V

    return-void
.end method

.method public go(Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V
    .locals 0

    check-cast p1, Landroid/support/transition/SceneIcs;

    iget-object p1, p1, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    check-cast p2, Landroid/support/transition/TransitionIcs;

    iget-object p2, p2, Landroid/support/transition/TransitionIcs;->mTransition:Landroid/support/transition/TransitionPort;

    :goto_0
    invoke-static {p1, p2}, Landroid/support/transition/TransitionManagerPort;->go(Landroid/support/transition/ScenePort;Landroid/support/transition/TransitionPort;)V

    return-void
.end method
