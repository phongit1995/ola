.class Landroid/support/transition/SceneIcs;
.super Landroid/support/transition/SceneImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# instance fields
.field mScene:Landroid/support/transition/ScenePort;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/SceneImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0}, Landroid/support/transition/ScenePort;->enter()V

    return-void
.end method

.method public exit()V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0}, Landroid/support/transition/ScenePort;->exit()V

    return-void
.end method

.method public getSceneRoot()Landroid/view/ViewGroup;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0}, Landroid/support/transition/ScenePort;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    return-object v0
.end method

.method public init(Landroid/view/ViewGroup;)V
    .locals 1

    new-instance v0, Landroid/support/transition/ScenePort;

    invoke-direct {v0, p1}, Landroid/support/transition/ScenePort;-><init>(Landroid/view/ViewGroup;)V

    iput-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    return-void
.end method

.method public init(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 1

    new-instance v0, Landroid/support/transition/ScenePort;

    invoke-direct {v0, p1, p2}, Landroid/support/transition/ScenePort;-><init>(Landroid/view/ViewGroup;Landroid/view/View;)V

    iput-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    return-void
.end method

.method public setEnterAction(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0, p1}, Landroid/support/transition/ScenePort;->setEnterAction(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setExitAction(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/SceneIcs;->mScene:Landroid/support/transition/ScenePort;

    invoke-virtual {v0, p1}, Landroid/support/transition/ScenePort;->setExitAction(Ljava/lang/Runnable;)V

    return-void
.end method
