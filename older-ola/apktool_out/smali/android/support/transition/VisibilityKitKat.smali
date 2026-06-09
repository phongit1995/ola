.class Landroid/support/transition/VisibilityKitKat;
.super Landroid/support/transition/TransitionKitKat;

# interfaces
.implements Landroid/support/transition/VisibilityImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x13
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x13
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionKitKat;-><init>()V

    return-void
.end method


# virtual methods
.method public init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/VisibilityKitKat;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    if-nez p2, :cond_0

    new-instance p2, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;

    check-cast p1, Landroid/support/transition/VisibilityInterface;

    invoke-direct {p2, p1}, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;-><init>(Landroid/support/transition/VisibilityInterface;)V

    :goto_0
    iput-object p2, p0, Landroid/support/transition/VisibilityKitKat;->mTransition:Landroid/transition/Transition;

    return-void

    :cond_0
    check-cast p2, Landroid/transition/Visibility;

    goto :goto_0

    return-void
.end method

.method public isVisible(Landroid/support/transition/TransitionValues;)Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat;->mTransition:Landroid/transition/Transition;

    check-cast v0, Landroid/transition/Visibility;

    invoke-static {p1}, Landroid/support/transition/VisibilityKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/transition/Visibility;->isVisible(Landroid/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat;->mTransition:Landroid/transition/Transition;

    move-object v1, v0

    check-cast v1, Landroid/transition/Visibility;

    invoke-static {p2}, Landroid/support/transition/VisibilityKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v3

    invoke-static {p4}, Landroid/support/transition/VisibilityKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v5

    move-object v2, p1

    move v4, p3

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/transition/Visibility;->onAppear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat;->mTransition:Landroid/transition/Transition;

    move-object v1, v0

    check-cast v1, Landroid/transition/Visibility;

    invoke-static {p2}, Landroid/support/transition/VisibilityKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v3

    invoke-static {p4}, Landroid/support/transition/VisibilityKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v5

    move-object v2, p1

    move v4, p3

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/transition/Visibility;->onDisappear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
