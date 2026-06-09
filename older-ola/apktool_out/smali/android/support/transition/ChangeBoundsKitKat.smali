.class Landroid/support/transition/ChangeBoundsKitKat;
.super Landroid/support/transition/TransitionKitKat;

# interfaces
.implements Landroid/support/transition/ChangeBoundsInterface;


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

    new-instance v0, Landroid/transition/ChangeBounds;

    invoke-direct {v0}, Landroid/transition/ChangeBounds;-><init>()V

    invoke-virtual {p0, p1, v0}, Landroid/support/transition/ChangeBoundsKitKat;->init(Landroid/support/transition/TransitionInterface;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public setResizeClip(Z)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/ChangeBoundsKitKat;->mTransition:Landroid/transition/Transition;

    check-cast v0, Landroid/transition/ChangeBounds;

    invoke-virtual {v0, p1}, Landroid/transition/ChangeBounds;->setResizeClip(Z)V

    return-void
.end method
