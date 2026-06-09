.class Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;
.super Landroid/support/design/internal/BottomNavigationAnimationHelperBase;


# static fields
.field private static final ACTIVE_ANIMATION_DURATION_MS:J = 0x73L


# instance fields
.field private final mSet:Landroid/support/transition/TransitionSet;


# direct methods
.method constructor <init>()V
    .locals 3

    invoke-direct {p0}, Landroid/support/design/internal/BottomNavigationAnimationHelperBase;-><init>()V

    new-instance v0, Landroid/support/transition/AutoTransition;

    invoke-direct {v0}, Landroid/support/transition/AutoTransition;-><init>()V

    iput-object v0, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/transition/TransitionSet;->setOrdering(I)Landroid/support/transition/TransitionSet;

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    const-wide/16 v1, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/support/transition/TransitionSet;->setDuration(J)Landroid/support/transition/Transition;

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    new-instance v1, Landroid/support/v4/view/animation/FastOutSlowInInterpolator;

    invoke-direct {v1}, Landroid/support/v4/view/animation/FastOutSlowInInterpolator;-><init>()V

    invoke-virtual {v0, v1}, Landroid/support/transition/TransitionSet;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/support/transition/Transition;

    new-instance v0, Landroid/support/design/internal/TextScale;

    invoke-direct {v0}, Landroid/support/design/internal/TextScale;-><init>()V

    iget-object v1, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    invoke-virtual {v1, v0}, Landroid/support/transition/TransitionSet;->addTransition(Landroid/support/transition/Transition;)Landroid/support/transition/TransitionSet;

    return-void
.end method


# virtual methods
.method beginDelayedTransition(Landroid/view/ViewGroup;)V
    .locals 1

    iget-object v0, p0, Landroid/support/design/internal/BottomNavigationAnimationHelperIcs;->mSet:Landroid/support/transition/TransitionSet;

    invoke-static {p1, v0}, Landroid/support/transition/TransitionManager;->beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V

    return-void
.end method
