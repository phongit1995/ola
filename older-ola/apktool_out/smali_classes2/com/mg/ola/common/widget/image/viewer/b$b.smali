.class Lcom/mg/ola/common/widget/image/viewer/b$b;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/image/viewer/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/image/viewer/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/image/viewer/b$b;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;)V

    return-void
.end method


# virtual methods
.method public onDoubleTap(Landroid/view/MotionEvent;)Z
    .locals 4

    const/4 v0, 0x1

    :try_start_0
    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->k(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    cmpg-float v3, v1, v3

    if-gez v3, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->k(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    invoke-virtual {v1, v3, v2, p1, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(FFFZ)V

    :goto_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;Z)Z

    return v0

    :cond_0
    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->k(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    cmpl-float v3, v1, v3

    if-ltz v3, :cond_1

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    cmpg-float v1, v1, v3

    if-gez v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    invoke-virtual {v1, v3, v2, p1, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(FFFZ)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->l(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    invoke-virtual {v1, v3, v2, p1, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(FFFZ)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;Z)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return v0
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 3

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object p1

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/widget/ImageView;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    new-instance v0, Lcom/mg/ola/common/widget/image/viewer/b$d;

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/mg/ola/common/widget/image/viewer/b$d;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;Landroid/content/Context;)V

    invoke-static {p2, v0}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$d;)Lcom/mg/ola/common/widget/image/viewer/b$d;

    iget-object p2, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p2}, Lcom/mg/ola/common/widget/image/viewer/b;->d(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$d;

    move-result-object p2

    invoke-virtual {p1}, Landroid/widget/ImageView;->getWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/widget/ImageView;->getHeight()I

    move-result v1

    neg-float p3, p3

    float-to-int p3, p3

    neg-float p4, p4

    float-to-int p4, p4

    invoke-virtual {p2, v0, v1, p3, p4}, Lcom/mg/ola/common/widget/image/viewer/b$d;->a(IIII)V

    iget-object p2, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p2}, Lcom/mg/ola/common/widget/image/viewer/b;->d(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$d;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->post(Ljava/lang/Runnable;)Z

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->e(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/view/View$OnLongClickListener;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->e(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/view/View$OnLongClickListener;

    move-result-object p1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->f(Lcom/mg/ola/common/widget/image/viewer/b;)Ljava/lang/ref/WeakReference;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-interface {p1, v0}, Landroid/view/View$OnLongClickListener;->onLongClick(Landroid/view/View;)Z

    :cond_0
    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 2

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object p1

    const/4 p2, 0x1

    if-eqz p1, :cond_2

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/widget/ImageView;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;

    move-result-object v0

    neg-float v1, p3

    neg-float p4, p4

    invoke-virtual {v0, v1, p4}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p4}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Lcom/mg/ola/common/widget/image/viewer/b;)V

    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p4}, Lcom/mg/ola/common/widget/image/viewer/b;->g(Lcom/mg/ola/common/widget/image/viewer/b;)Z

    move-result p4

    if-eqz p4, :cond_2

    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p4}, Lcom/mg/ola/common/widget/image/viewer/b;->h(Lcom/mg/ola/common/widget/image/viewer/b;)I

    move-result p4

    const/4 v0, 0x2

    if-eq p4, v0, :cond_1

    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p4}, Lcom/mg/ola/common/widget/image/viewer/b;->h(Lcom/mg/ola/common/widget/image/viewer/b;)I

    move-result p4

    if-nez p4, :cond_0

    const/high16 p4, -0x40800000    # -1.0f

    cmpg-float p4, p3, p4

    if-lez p4, :cond_1

    :cond_0
    iget-object p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p4}, Lcom/mg/ola/common/widget/image/viewer/b;->h(Lcom/mg/ola/common/widget/image/viewer/b;)I

    move-result p4

    if-ne p4, p2, :cond_2

    const/high16 p4, 0x3f800000    # 1.0f

    cmpl-float p3, p3, p4

    if-ltz p3, :cond_2

    :cond_1
    invoke-virtual {p1}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    const/4 p3, 0x0

    invoke-interface {p1, p3}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_2
    return p2
.end method

.method public final onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->i(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$f;

    move-result-object v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b()Landroid/graphics/RectF;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    invoke-virtual {v1, v3, v4}, Landroid/graphics/RectF;->contains(FF)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->i(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$f;

    move-result-object p1

    invoke-interface {p1, v0, v3, v4}, Lcom/mg/ola/common/widget/image/viewer/b$f;->a(Landroid/view/View;FF)V

    return v2

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->j(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$g;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$b;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->j(Lcom/mg/ola/common/widget/image/viewer/b;)Lcom/mg/ola/common/widget/image/viewer/b$g;

    move-result-object v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-interface {v1, v0, v3, p1}, Lcom/mg/ola/common/widget/image/viewer/b$g;->b(Landroid/view/View;FF)V

    return v2

    :cond_1
    const/4 p1, 0x0

    return p1
.end method
