.class public Landroid/support/transition/Scene;
.super Ljava/lang/Object;


# static fields
.field private static sImpl:Landroid/support/transition/SceneStaticsImpl;


# instance fields
.field mImpl:Landroid/support/transition/SceneImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/SceneStaticsApi21;

    invoke-direct {v0}, Landroid/support/transition/SceneStaticsApi21;-><init>()V

    :goto_0
    sput-object v0, Landroid/support/transition/Scene;->sImpl:Landroid/support/transition/SceneStaticsImpl;

    return-void

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_1

    new-instance v0, Landroid/support/transition/SceneStaticsKitKat;

    invoke-direct {v0}, Landroid/support/transition/SceneStaticsKitKat;-><init>()V

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/support/transition/SceneStaticsIcs;

    invoke-direct {v0}, Landroid/support/transition/SceneStaticsIcs;-><init>()V

    goto :goto_0

    return-void
.end method

.method private constructor <init>(Landroid/support/transition/SceneImpl;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    return-void
.end method

.method public constructor <init>(Landroid/view/ViewGroup;)V
    .locals 1
    .param p1    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-direct {p0}, Landroid/support/transition/Scene;->createSceneImpl()Landroid/support/transition/SceneImpl;

    move-result-object v0

    iput-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/SceneImpl;->init(Landroid/view/ViewGroup;)V

    return-void
.end method

.method public constructor <init>(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 1
    .param p1    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-direct {p0}, Landroid/support/transition/Scene;->createSceneImpl()Landroid/support/transition/SceneImpl;

    move-result-object v0

    iput-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p1, p2}, Landroid/support/transition/SceneImpl;->init(Landroid/view/ViewGroup;Landroid/view/View;)V

    return-void
.end method

.method private createSceneImpl()Landroid/support/transition/SceneImpl;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    new-instance v0, Landroid/support/transition/SceneApi21;

    invoke-direct {v0}, Landroid/support/transition/SceneApi21;-><init>()V

    return-object v0

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x13

    if-lt v0, v1, :cond_1

    new-instance v0, Landroid/support/transition/SceneKitKat;

    invoke-direct {v0}, Landroid/support/transition/SceneKitKat;-><init>()V

    return-object v0

    :cond_1
    new-instance v0, Landroid/support/transition/SceneIcs;

    invoke-direct {v0}, Landroid/support/transition/SceneIcs;-><init>()V

    return-object v0
.end method

.method public static getSceneForLayout(Landroid/view/ViewGroup;ILandroid/content/Context;)Landroid/support/transition/Scene;
    .locals 3
    .param p0    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # I
        .annotation build Landroid/support/annotation/LayoutRes;
        .end annotation
    .end param
    .param p2    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    sget v0, Landroid/support/transition/R$id;->transition_scene_layoutid_cache:I

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/SparseArray;

    if-nez v0, :cond_0

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    sget v1, Landroid/support/transition/R$id;->transition_scene_layoutid_cache:I

    invoke-virtual {p0, v1, v0}, Landroid/view/ViewGroup;->setTag(ILjava/lang/Object;)V

    :cond_0
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/transition/Scene;

    if-eqz v1, :cond_1

    return-object v1

    :cond_1
    new-instance v1, Landroid/support/transition/Scene;

    sget-object v2, Landroid/support/transition/Scene;->sImpl:Landroid/support/transition/SceneStaticsImpl;

    invoke-virtual {v2, p0, p1, p2}, Landroid/support/transition/SceneStaticsImpl;->getSceneForLayout(Landroid/view/ViewGroup;ILandroid/content/Context;)Landroid/support/transition/SceneImpl;

    move-result-object p0

    invoke-direct {v1, p0}, Landroid/support/transition/Scene;-><init>(Landroid/support/transition/SceneImpl;)V

    invoke-virtual {v0, p1, v1}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    return-object v1
.end method


# virtual methods
.method public enter()V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0}, Landroid/support/transition/SceneImpl;->enter()V

    return-void
.end method

.method public exit()V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0}, Landroid/support/transition/SceneImpl;->exit()V

    return-void
.end method

.method public getSceneRoot()Landroid/view/ViewGroup;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0}, Landroid/support/transition/SceneImpl;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    return-object v0
.end method

.method public setEnterAction(Ljava/lang/Runnable;)V
    .locals 1
    .param p1    # Ljava/lang/Runnable;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/SceneImpl;->setEnterAction(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setExitAction(Ljava/lang/Runnable;)V
    .locals 1
    .param p1    # Ljava/lang/Runnable;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Landroid/support/transition/Scene;->mImpl:Landroid/support/transition/SceneImpl;

    invoke-virtual {v0, p1}, Landroid/support/transition/SceneImpl;->setExitAction(Ljava/lang/Runnable;)V

    return-void
.end method
