.class Lit/sephiroth/android/library/widget/EnhancedListView$3;
.super Lcom/mg/ola/a/a/b/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/view/View;Landroid/view/View;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/View;

.field final synthetic b:I

.field final synthetic c:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/View;I)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->a:Landroid/view/View;

    iput p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->b:I

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/b;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 5

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->h(Lit/sephiroth/android/library/widget/EnhancedListView;)[Ljava/lang/Object;

    move-result-object p1

    monitor-enter p1

    :try_start_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->i(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->j(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->a:Landroid/view/View;

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->k(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_7

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->l(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/SortedSet;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/SortedSet;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->b(Lit/sephiroth/android/library/widget/EnhancedListView;)Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    move-result-object v3

    sget-object v4, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    if-ne v3, v4, :cond_2

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {v4}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->b()V

    goto :goto_2

    :cond_1
    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->clear()V

    :cond_2
    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->m(Lit/sephiroth/android/library/widget/EnhancedListView;)Lit/sephiroth/android/library/widget/EnhancedListView$b;

    move-result-object v3

    iget-object v4, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->a:I

    invoke-interface {v3, v4, v0}, Lit/sephiroth/android/library/widget/EnhancedListView$b;->a(Lit/sephiroth/android/library/widget/EnhancedListView;I)Lit/sephiroth/android/library/widget/EnhancedListView$f;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->f(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    goto :goto_1

    :cond_4
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->d(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->e(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070125

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimension(I)F

    const/4 p1, 0x2

    new-array p1, p1, [I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->a:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->getLocationInWindow([I)V

    aget p1, p1, v2

    int-to-float p1, p1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->c(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/widget/PopupWindow;

    move-result-object v0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v2}, Lit/sephiroth/android/library/widget/EnhancedListView;->n(Lit/sephiroth/android/library/widget/EnhancedListView;)F

    move-result v2

    const/high16 v3, 0x43c80000    # 400.0f

    mul-float v2, v2, v3

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v3}, Lit/sephiroth/android/library/widget/EnhancedListView;->getWidth()I

    move-result v3

    int-to-float v3, v3

    const v4, 0x3f666666    # 0.9f

    mul-float v3, v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v2

    float-to-int v2, v2

    invoke-virtual {v0, v2}, Landroid/widget/PopupWindow;->setWidth(I)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->c(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/widget/PopupWindow;

    move-result-object v0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    const/16 v3, 0x31

    float-to-int p1, p1

    invoke-virtual {v0, v2, v3, v1, p1}, Landroid/widget/PopupWindow;->showAtLocation(Landroid/view/View;III)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->o(Lit/sephiroth/android/library/widget/EnhancedListView;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->p(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/os/Handler;

    move-result-object p1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->p(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->g(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->q(Lit/sephiroth/android/library/widget/EnhancedListView;)J

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    :cond_5
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->l(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/SortedSet;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/SortedSet;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_3
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;

    iget-object v1, v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->b:Landroid/view/View;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v1, v2}, Lcom/mg/ola/a/a/c/b;->a(Landroid/view/View;F)V

    iget-object v1, v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->b:Landroid/view/View;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/mg/ola/a/a/c/b;->e(Landroid/view/View;F)V

    iget-object v1, v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->c:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    iget v2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->b:I

    iput v2, v1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, v0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->c:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_3

    :cond_6
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$3;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->l(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/SortedSet;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/SortedSet;->clear()V

    :cond_7
    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
