.class Lcom/mg/ola/a/a/c/e;
.super Lcom/mg/ola/a/a/c/c;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation


# instance fields
.field private final a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/ViewPropertyAnimator;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Lcom/mg/ola/a/a/c/c;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/e;->a:Ljava/lang/ref/WeakReference;

    return-void
.end method


# virtual methods
.method public a(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/e;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewPropertyAnimator;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/view/ViewPropertyAnimator;->translationX(F)Landroid/view/ViewPropertyAnimator;

    :cond_0
    return-object p0
.end method

.method public a(J)Lcom/mg/ola/a/a/c/c;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/e;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewPropertyAnimator;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    :cond_0
    return-object p0
.end method

.method public a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/c/e;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewPropertyAnimator;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Landroid/view/ViewPropertyAnimator;->setListener(Landroid/animation/Animator$AnimatorListener;)Landroid/view/ViewPropertyAnimator;

    return-object p0

    :cond_0
    new-instance v1, Lcom/mg/ola/a/a/c/e$1;

    invoke-direct {v1, p0, p1}, Lcom/mg/ola/a/a/c/e$1;-><init>(Lcom/mg/ola/a/a/c/e;Lcom/mg/ola/a/a/b/a$a;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setListener(Landroid/animation/Animator$AnimatorListener;)Landroid/view/ViewPropertyAnimator;

    :cond_1
    return-object p0
.end method

.method public b(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/e;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/ViewPropertyAnimator;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    :cond_0
    return-object p0
.end method
