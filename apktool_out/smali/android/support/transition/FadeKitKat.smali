.class Landroid/support/transition/FadeKitKat;
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


# direct methods
.method public constructor <init>(Landroid/support/transition/TransitionInterface;)V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionKitKat;-><init>()V

    new-instance v0, Landroid/transition/Fade;

    invoke-direct {v0}, Landroid/transition/Fade;-><init>()V

    invoke-virtual {p0, p1, v0}, Landroid/support/transition/FadeKitKat;->init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V

    return-void
.end method

.method public constructor <init>(Landroid/support/transition/TransitionInterface;I)V
    .locals 1

    invoke-direct {p0}, Landroid/support/transition/TransitionKitKat;-><init>()V

    new-instance v0, Landroid/transition/Fade;

    invoke-direct {v0, p2}, Landroid/transition/Fade;-><init>(I)V

    invoke-virtual {p0, p1, v0}, Landroid/support/transition/FadeKitKat;->init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public isVisible(Landroid/support/transition/TransitionValues;)Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/FadeKitKat;->mTransition:Landroid/transition/Transition;

    check-cast v0, Landroid/transition/Fade;

    invoke-static {p1}, Landroid/support/transition/FadeKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/transition/Fade;->isVisible(Landroid/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/FadeKitKat;->mTransition:Landroid/transition/Transition;

    move-object v1, v0

    check-cast v1, Landroid/transition/Fade;

    invoke-static {p2}, Landroid/support/transition/FadeKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v3

    invoke-static {p4}, Landroid/support/transition/FadeKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v5

    move-object v2, p1

    move v4, p3

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/transition/Fade;->onAppear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 7

    iget-object v0, p0, Landroid/support/transition/FadeKitKat;->mTransition:Landroid/transition/Transition;

    move-object v1, v0

    check-cast v1, Landroid/transition/Fade;

    invoke-static {p2}, Landroid/support/transition/FadeKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v3

    invoke-static {p4}, Landroid/support/transition/FadeKitKat;->convertToPlatform(Landroid/support/transition/TransitionValues;)Landroid/transition/TransitionValues;

    move-result-object v5

    move-object v2, p1

    move v4, p3

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Landroid/transition/Fade;->onDisappear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
