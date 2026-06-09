.class Landroid/support/transition/FadeIcs;
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


# direct methods
.method public constructor <init>(Landroid/support/transition/TransitionInterface;)V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionIcs;-><init>()V

    new-instance v0, Landroid/support/transition/FadePort;

    invoke-direct {v0}, Landroid/support/transition/FadePort;-><init>()V

    invoke-virtual {p0, p1, v0}, Landroid/support/transition/FadeIcs;->init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V

    return-void
.end method

.method public constructor <init>(Landroid/support/transition/TransitionInterface;I)V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionIcs;-><init>()V

    new-instance v0, Landroid/support/transition/FadePort;

    invoke-direct {v0, p2}, Landroid/support/transition/FadePort;-><init>(I)V

    invoke-virtual {p0, p1, v0}, Landroid/support/transition/FadeIcs;->init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public isVisible(Landroid/support/transition/TransitionValues;)Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/FadeIcs;->mTransition:Landroid/support/transition/TransitionPort;

    check-cast v0, Landroid/support/transition/FadePort;

    invoke-virtual {v0, p1}, Landroid/support/transition/FadePort;->isVisible(Landroid/support/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/FadeIcs;->mTransition:Landroid/support/transition/TransitionPort;

    move-object v1, v0

    check-cast v1, Landroid/support/transition/FadePort;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/support/transition/FadePort;->onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 6

    iget-object p4, p0, Landroid/support/transition/FadeIcs;->mTransition:Landroid/support/transition/TransitionPort;

    move-object v0, p4

    check-cast v0, Landroid/support/transition/FadePort;

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Landroid/support/transition/FadePort;->onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
