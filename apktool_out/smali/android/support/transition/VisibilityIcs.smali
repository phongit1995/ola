.class Landroid/support/transition/VisibilityIcs;
.super Landroid/support/transition/TransitionIcs;

# interfaces
.implements Landroid/support/transition/VisibilityImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/VisibilityIcs$VisibilityWrapper;
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionIcs;-><init>()V

    return-void
.end method


# virtual methods
.method public init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/VisibilityIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    if-nez p2, :cond_0

    new-instance p2, Landroid/support/transition/VisibilityIcs$VisibilityWrapper;

    check-cast p1, Landroid/support/transition/VisibilityInterface;

    invoke-direct {p2, p1}, Landroid/support/transition/VisibilityIcs$VisibilityWrapper;-><init>(Landroid/support/transition/VisibilityInterface;)V

    :goto_0
    iput-object p2, p0, Landroid/support/transition/VisibilityIcs;->mTransition:Landroid/support/transition/TransitionPort;

    return-void

    :cond_0
    check-cast p2, Landroid/support/transition/VisibilityPort;

    goto :goto_0

    return-void
.end method

.method public isVisible(Landroid/support/transition/TransitionValues;)Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/VisibilityIcs;->mTransition:Landroid/support/transition/TransitionPort;

    check-cast v0, Landroid/support/transition/VisibilityPort;

    invoke-virtual {v0, p1}, Landroid/support/transition/VisibilityPort;->isVisible(Landroid/support/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/VisibilityIcs;->mTransition:Landroid/support/transition/TransitionPort;

    move-object v1, v0

    check-cast v1, Landroid/support/transition/VisibilityPort;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/support/transition/VisibilityPort;->onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/VisibilityIcs;->mTransition:Landroid/support/transition/TransitionPort;

    move-object v1, v0

    check-cast v1, Landroid/support/transition/VisibilityPort;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/support/transition/VisibilityPort;->onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
