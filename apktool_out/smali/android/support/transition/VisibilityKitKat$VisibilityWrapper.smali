.class Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;
.super Landroid/transition/Visibility;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/transition/VisibilityKitKat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "VisibilityWrapper"
.end annotation


# instance fields
.field private final mVisibility:Landroid/support/transition/VisibilityInterface;


# direct methods
.method constructor <init>(Landroid/support/transition/VisibilityInterface;)V
    .locals 0

    invoke-direct {p0}, Landroid/transition/Visibility;-><init>()V

    iput-object p1, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    return-void
.end method


# virtual methods
.method public captureEndValues(Landroid/transition/TransitionValues;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->wrapCaptureEndValues(Landroid/support/transition/TransitionInterface;Landroid/transition/TransitionValues;)V

    return-void
.end method

.method public captureStartValues(Landroid/transition/TransitionValues;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-static {v0, p1}, Landroid/support/transition/TransitionKitKat;->wrapCaptureStartValues(Landroid/support/transition/TransitionInterface;Landroid/transition/TransitionValues;)V

    return-void
.end method

.method public createAnimator(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;Landroid/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-static {p2}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object p2

    invoke-static {p3}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object p3

    invoke-interface {v0, p1, p2, p3}, Landroid/support/transition/VisibilityInterface;->createAnimator(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;Landroid/support/transition/TransitionValues;)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public isVisible(Landroid/transition/TransitionValues;)Z
    .locals 1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    new-instance v0, Landroid/support/transition/TransitionValues;

    invoke-direct {v0}, Landroid/support/transition/TransitionValues;-><init>()V

    invoke-static {p1, v0}, Landroid/support/transition/TransitionKitKat;->copyValues(Landroid/transition/TransitionValues;Landroid/support/transition/TransitionValues;)V

    iget-object p1, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-interface {p1, v0}, Landroid/support/transition/VisibilityInterface;->isVisible(Landroid/support/transition/TransitionValues;)Z

    move-result p1

    return p1
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 6

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-static {p2}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object v2

    invoke-static {p4}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object v4

    move-object v1, p1

    move v3, p3

    move v5, p5

    invoke-interface/range {v0 .. v5}, Landroid/support/transition/VisibilityInterface;->onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/transition/TransitionValues;ILandroid/transition/TransitionValues;I)Landroid/animation/Animator;
    .locals 6

    iget-object v0, p0, Landroid/support/transition/VisibilityKitKat$VisibilityWrapper;->mVisibility:Landroid/support/transition/VisibilityInterface;

    invoke-static {p2}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object v2

    invoke-static {p4}, Landroid/support/transition/TransitionKitKat;->convertToSupport(Landroid/transition/TransitionValues;)Landroid/support/transition/TransitionValues;

    move-result-object v4

    move-object v1, p1

    move v3, p3

    move v5, p5

    invoke-interface/range {v0 .. v5}, Landroid/support/transition/VisibilityInterface;->onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;

    move-result-object p1

    return-object p1
.end method
