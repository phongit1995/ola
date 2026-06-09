.class Landroid/support/transition/SceneKitKat;
.super Landroid/support/transition/SceneWrapper;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x13
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0x13
.end annotation


# static fields
.field private static sEnterAction:Ljava/lang/reflect/Field;

.field private static sSetCurrentScene:Ljava/lang/reflect/Method;


# instance fields
.field private mLayout:Landroid/view/View;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/support/transition/SceneWrapper;-><init>()V

    return-void
.end method

.method private invokeEnterAction()V
    .locals 2

    sget-object v0, Landroid/support/transition/SceneKitKat;->sEnterAction:Ljava/lang/reflect/Field;

    if-nez v0, :cond_0

    :try_start_0
    const-class v0, Landroid/transition/Scene;

    const-string v1, "mEnterAction"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Landroid/support/transition/SceneKitKat;->sEnterAction:Ljava/lang/reflect/Field;

    sget-object v0, Landroid/support/transition/SceneKitKat;->sEnterAction:Ljava/lang/reflect/Field;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    :cond_0
    :goto_0
    :try_start_1
    sget-object v0, Landroid/support/transition/SceneKitKat;->sEnterAction:Ljava/lang/reflect/Field;

    iget-object v1, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1

    :cond_1
    return-void

    :catch_1
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method private updateCurrentScene(Landroid/view/View;)V
    .locals 7

    sget-object v0, Landroid/support/transition/SceneKitKat;->sSetCurrentScene:Ljava/lang/reflect/Method;

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x1

    if-nez v0, :cond_0

    :try_start_0
    const-class v0, Landroid/transition/Scene;

    const-string v4, "setCurrentScene"

    new-array v5, v2, [Ljava/lang/Class;

    const-class v6, Landroid/view/View;

    aput-object v6, v5, v1

    const-class v6, Landroid/transition/Scene;

    aput-object v6, v5, v3

    invoke-virtual {v0, v4, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Landroid/support/transition/SceneKitKat;->sSetCurrentScene:Ljava/lang/reflect/Method;

    sget-object v0, Landroid/support/transition/SceneKitKat;->sSetCurrentScene:Ljava/lang/reflect/Method;

    invoke-virtual {v0, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    new-instance v0, Ljava/lang/RuntimeException;

    invoke-direct {v0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v0

    :cond_0
    :goto_0
    :try_start_1
    sget-object v0, Landroid/support/transition/SceneKitKat;->sSetCurrentScene:Ljava/lang/reflect/Method;

    const/4 v4, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p1, v2, v1

    iget-object p1, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    aput-object p1, v2, v3

    invoke-virtual {v0, v4, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    new-instance v0, Ljava/lang/RuntimeException;

    invoke-direct {v0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method


# virtual methods
.method public enter()V
    .locals 2

    iget-object v0, p0, Landroid/support/transition/SceneKitKat;->mLayout:Landroid/view/View;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/support/transition/SceneKitKat;->getSceneRoot()Landroid/view/ViewGroup;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    iget-object v1, p0, Landroid/support/transition/SceneKitKat;->mLayout:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    invoke-direct {p0}, Landroid/support/transition/SceneKitKat;->invokeEnterAction()V

    invoke-direct {p0, v0}, Landroid/support/transition/SceneKitKat;->updateCurrentScene(Landroid/view/View;)V

    return-void

    :cond_0
    iget-object v0, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    invoke-virtual {v0}, Landroid/transition/Scene;->enter()V

    return-void
.end method

.method public init(Landroid/view/ViewGroup;)V
    .locals 1

    new-instance v0, Landroid/transition/Scene;

    invoke-direct {v0, p1}, Landroid/transition/Scene;-><init>(Landroid/view/ViewGroup;)V

    iput-object v0, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    return-void
.end method

.method public init(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 1

    instance-of v0, p2, Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    new-instance v0, Landroid/transition/Scene;

    check-cast p2, Landroid/view/ViewGroup;

    invoke-direct {v0, p1, p2}, Landroid/transition/Scene;-><init>(Landroid/view/ViewGroup;Landroid/view/ViewGroup;)V

    iput-object v0, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    return-void

    :cond_0
    new-instance v0, Landroid/transition/Scene;

    invoke-direct {v0, p1}, Landroid/transition/Scene;-><init>(Landroid/view/ViewGroup;)V

    iput-object v0, p0, Landroid/support/transition/SceneKitKat;->mScene:Landroid/transition/Scene;

    iput-object p2, p0, Landroid/support/transition/SceneKitKat;->mLayout:Landroid/view/View;

    return-void
.end method
