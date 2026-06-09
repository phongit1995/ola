.class final Landroid/support/transition/ScenePort;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# instance fields
.field private mContext:Landroid/content/Context;

.field mEnterAction:Ljava/lang/Runnable;

.field mExitAction:Ljava/lang/Runnable;

.field private mLayout:Landroid/view/View;

.field private mLayoutId:I

.field private mSceneRoot:Landroid/view/ViewGroup;


# direct methods
.method public constructor <init>(Landroid/view/ViewGroup;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    iput-object p1, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    return-void
.end method

.method private constructor <init>(Landroid/view/ViewGroup;ILandroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    iput-object p3, p0, Landroid/support/transition/ScenePort;->mContext:Landroid/content/Context;

    iput-object p1, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    iput p2, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    return-void
.end method

.method public constructor <init>(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    iput-object p1, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    iput-object p2, p0, Landroid/support/transition/ScenePort;->mLayout:Landroid/view/View;

    return-void
.end method

.method static getCurrentScene(Landroid/view/View;)Landroid/support/transition/ScenePort;
    .locals 1

    sget v0, Landroid/support/transition/R$id;->transition_current_scene:I

    invoke-virtual {p0, v0}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/support/transition/ScenePort;

    return-object p0
.end method

.method public static getSceneForLayout(Landroid/view/ViewGroup;ILandroid/content/Context;)Landroid/support/transition/ScenePort;
    .locals 1

    new-instance v0, Landroid/support/transition/ScenePort;

    invoke-direct {v0, p0, p1, p2}, Landroid/support/transition/ScenePort;-><init>(Landroid/view/ViewGroup;ILandroid/content/Context;)V

    return-object v0
.end method

.method static setCurrentScene(Landroid/view/View;Landroid/support/transition/ScenePort;)V
    .locals 1

    sget v0, Landroid/support/transition/R$id;->transition_current_scene:I

    invoke-virtual {p0, v0, p1}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    iget v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    if-gtz v0, :cond_0

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mLayout:Landroid/view/View;

    if-eqz v0, :cond_2

    :cond_0
    invoke-virtual {p0}, Landroid/support/transition/ScenePort;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    iget v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    if-lez v0, :cond_1

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget v1, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    iget-object v2, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    iget-object v1, p0, Landroid/support/transition/ScenePort;->mLayout:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    :cond_2
    :goto_0
    iget-object v0, p0, Landroid/support/transition/ScenePort;->mEnterAction:Ljava/lang/Runnable;

    if-eqz v0, :cond_3

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mEnterAction:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_3
    iget-object v0, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    invoke-static {v0, p0}, Landroid/support/transition/ScenePort;->setCurrentScene(Landroid/view/View;Landroid/support/transition/ScenePort;)V

    return-void
.end method

.method public exit()V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    invoke-static {v0}, Landroid/support/transition/ScenePort;->getCurrentScene(Landroid/view/View;)Landroid/support/transition/ScenePort;

    move-result-object v0

    if-ne v0, p0, :cond_0

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mExitAction:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mExitAction:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method public getSceneRoot()Landroid/view/ViewGroup;
    .locals 1

    iget-object v0, p0, Landroid/support/transition/ScenePort;->mSceneRoot:Landroid/view/ViewGroup;

    return-object v0
.end method

.method isCreatedFromLayoutResource()Z
    .locals 1

    iget v0, p0, Landroid/support/transition/ScenePort;->mLayoutId:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public setEnterAction(Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/ScenePort;->mEnterAction:Ljava/lang/Runnable;

    return-void
.end method

.method public setExitAction(Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/ScenePort;->mExitAction:Ljava/lang/Runnable;

    return-void
.end method
