.class Landroid/support/transition/SceneStaticsApi21;
.super Landroid/support/transition/SceneStaticsImpl;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x15
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x15
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/SceneStaticsImpl;-><init>()V

    return-void
.end method


# virtual methods
.method public getSceneForLayout(Landroid/view/ViewGroup;ILandroid/content/Context;)Landroid/support/transition/SceneImpl;
    .locals 1

    new-instance v0, Landroid/support/transition/SceneApi21;

    invoke-direct {v0}, Landroid/support/transition/SceneApi21;-><init>()V

    invoke-static {p1, p2, p3}, Landroid/transition/Scene;->getSceneForLayout(Landroid/view/ViewGroup;ILandroid/content/Context;)Landroid/transition/Scene;

    move-result-object p1

    iput-object p1, v0, Landroid/support/transition/SceneApi21;->mScene:Landroid/transition/Scene;

    return-object v0
.end method
