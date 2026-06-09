.class Landroid/support/transition/TransitionSetPort$TransitionSetListener;
.super Landroid/support/transition/TransitionPort$TransitionListenerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/transition/TransitionSetPort;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "TransitionSetListener"
.end annotation


# instance fields
.field mTransitionSet:Landroid/support/transition/TransitionSetPort;


# direct methods
.method constructor <init>(Landroid/support/transition/TransitionSetPort;)V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/TransitionPort$TransitionListenerAdapter;-><init>()V

    iput-object p1, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    return-void
.end method


# virtual methods
.method public onTransitionEnd(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object v0, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    iget v1, v0, Landroid/support/transition/TransitionSetPort;->mCurrentListeners:I

    add-int/lit8 v1, v1, -0x1

    iput v1, v0, Landroid/support/transition/TransitionSetPort;->mCurrentListeners:I

    iget-object v0, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    iget v0, v0, Landroid/support/transition/TransitionSetPort;->mCurrentListeners:I

    if-nez v0, :cond_0

    iget-object v0, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    const/4 v1, 0x0

    iput-boolean v1, v0, Landroid/support/transition/TransitionSetPort;->mStarted:Z

    iget-object v0, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    invoke-virtual {v0}, Landroid/support/transition/TransitionSetPort;->end()V

    :cond_0
    invoke-virtual {p1, p0}, Landroid/support/transition/TransitionPort;->removeListener(Landroid/support/transition/TransitionPort$TransitionListener;)Landroid/support/transition/TransitionPort;

    return-void
.end method

.method public onTransitionStart(Landroid/support/transition/TransitionPort;)V
    .locals 1

    iget-object p1, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    iget-boolean p1, p1, Landroid/support/transition/TransitionSetPort;->mStarted:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    invoke-virtual {p1}, Landroid/support/transition/TransitionSetPort;->start()V

    iget-object p1, p0, Landroid/support/transition/TransitionSetPort$TransitionSetListener;->mTransitionSet:Landroid/support/transition/TransitionSetPort;

    const/4 v0, 0x1

    iput-boolean v0, p1, Landroid/support/transition/TransitionSetPort;->mStarted:Z

    :cond_0
    return-void
.end method
