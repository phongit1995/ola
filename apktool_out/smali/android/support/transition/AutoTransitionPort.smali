.class Landroid/support/transition/AutoTransitionPort;
.super Landroid/support/transition/TransitionSetPort;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Landroid/support/transition/TransitionSetPort;-><init>()V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/support/transition/AutoTransitionPort;->setOrdering(I)Landroid/support/transition/TransitionSetPort;

    new-instance v1, Landroid/support/transition/FadePort;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Landroid/support/transition/FadePort;-><init>(I)V

    invoke-virtual {p0, v1}, Landroid/support/transition/AutoTransitionPort;->addTransition(Landroid/support/transition/TransitionPort;)Landroid/support/transition/TransitionSetPort;

    move-result-object v1

    new-instance v2, Landroid/support/transition/ChangeBoundsPort;

    invoke-direct {v2}, Landroid/support/transition/ChangeBoundsPort;-><init>()V

    invoke-virtual {v1, v2}, Landroid/support/transition/TransitionSetPort;->addTransition(Landroid/support/transition/TransitionPort;)Landroid/support/transition/TransitionSetPort;

    move-result-object v1

    new-instance v2, Landroid/support/transition/FadePort;

    invoke-direct {v2, v0}, Landroid/support/transition/FadePort;-><init>(I)V

    invoke-virtual {v1, v2}, Landroid/support/transition/TransitionSetPort;->addTransition(Landroid/support/transition/TransitionPort;)Landroid/support/transition/TransitionSetPort;

    return-void
.end method
