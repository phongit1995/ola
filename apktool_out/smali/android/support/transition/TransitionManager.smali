.class public Landroid/support/transition/TransitionManager;
.super Ljava/lang/Object;


# static fields
.field private static sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;


# instance fields
.field private mImpl:Landroid/support/transition/TransitionManagerImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/TransitionManagerStaticsIcs;

    invoke-direct {v0}, Landroid/support/transition/TransitionManagerStaticsIcs;-><init>()V

    :goto_0
    sput-object v0, Landroid/support/transition/TransitionManager;->sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;

    return-void

    :cond_0
    new-instance v0, Landroid/support/transition/TransitionManagerStaticsKitKat;

    invoke-direct {v0}, Landroid/support/transition/TransitionManagerStaticsKitKat;-><init>()V

    goto :goto_0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-ge v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/TransitionManagerIcs;

    invoke-direct {v0}, Landroid/support/transition/TransitionManagerIcs;-><init>()V

    :goto_0
    iput-object v0, p0, Landroid/support/transition/TransitionManager;->mImpl:Landroid/support/transition/TransitionManagerImpl;

    return-void

    :cond_0
    new-instance v0, Landroid/support/transition/TransitionManagerKitKat;

    invoke-direct {v0}, Landroid/support/transition/TransitionManagerKitKat;-><init>()V

    goto :goto_0

    return-void
.end method

.method public static beginDelayedTransition(Landroid/view/ViewGroup;)V
    .locals 1
    .param p0    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    sget-object v0, Landroid/support/transition/TransitionManager;->sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;

    invoke-virtual {v0, p0}, Landroid/support/transition/TransitionManagerStaticsImpl;->beginDelayedTransition(Landroid/view/ViewGroup;)V

    return-void
.end method

.method public static beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/Transition;)V
    .locals 1
    .param p0    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    sget-object v0, Landroid/support/transition/TransitionManager;->sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    iget-object p1, p1, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    :goto_0
    invoke-virtual {v0, p0, p1}, Landroid/support/transition/TransitionManagerStaticsImpl;->beginDelayedTransition(Landroid/view/ViewGroup;Landroid/support/transition/TransitionImpl;)V

    return-void
.end method

.method public static go(Landroid/support/transition/Scene;)V
    .locals 1
    .param p0    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    sget-object v0, Landroid/support/transition/TransitionManager;->sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;

    iget-object p0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p0}, Landroid/support/transition/TransitionManagerStaticsImpl;->go(Landroid/support/transition/SceneImpl;)V

    return-void
.end method

.method public static go(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 1
    .param p0    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    sget-object v0, Landroid/support/transition/TransitionManager;->sImpl:Landroid/support/transition/TransitionManagerStaticsImpl;

    iget-object p0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    iget-object p1, p1, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    :goto_0
    invoke-virtual {v0, p0, p1}, Landroid/support/transition/TransitionManagerStaticsImpl;->go(Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V

    return-void
.end method


# virtual methods
.method public setTransition(Landroid/support/transition/Scene;Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 1
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/TransitionManager;->mImpl:Landroid/support/transition/TransitionManagerImpl;

    iget-object p1, p1, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    iget-object p2, p2, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    if-nez p3, :cond_0

    const/4 p3, 0x0

    goto :goto_0

    :cond_0
    iget-object p3, p3, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    :goto_0
    invoke-virtual {v0, p1, p2, p3}, Landroid/support/transition/TransitionManagerImpl;->setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V

    return-void
.end method

.method public setTransition(Landroid/support/transition/Scene;Landroid/support/transition/Transition;)V
    .locals 1
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/transition/Transition;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/TransitionManager;->mImpl:Landroid/support/transition/TransitionManagerImpl;

    iget-object p1, p1, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    iget-object p2, p2, Landroid/support/transition/Transition;->mImpl:Landroid/support/transition/TransitionImpl;

    :goto_0
    invoke-virtual {v0, p1, p2}, Landroid/support/transition/TransitionManagerImpl;->setTransition(Landroid/support/transition/SceneImpl;Landroid/support/transition/TransitionImpl;)V

    return-void
.end method

.method public transitionTo(Landroid/support/transition/Scene;)V
    .locals 1
    .param p1    # Landroid/support/transition/Scene;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/TransitionManager;->mImpl:Landroid/support/transition/TransitionManagerImpl;

    iget-object p1, p1, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/TransitionManagerImpl;->transitionTo(Landroid/support/transition/SceneImpl;)V

    return-void
.end method
