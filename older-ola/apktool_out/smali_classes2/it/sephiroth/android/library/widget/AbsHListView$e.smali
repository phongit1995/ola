.class Lit/sephiroth/android/library/widget/AbsHListView$e;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "e"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;

.field private final b:Lit/sephiroth/android/library/widget/c;

.field private c:I

.field private final d:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lit/sephiroth/android/library/widget/AbsHListView$e$1;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView$e$1;-><init>(Lit/sephiroth/android/library/widget/AbsHListView$e;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->d:Ljava/lang/Runnable;

    new-instance v0, Lit/sephiroth/android/library/widget/c;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v0, p1}, Lit/sephiroth/android/library/widget/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/AbsHListView$e;)Lit/sephiroth/android/library/widget/c;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    return-object p0
.end method


# virtual methods
.method a()V
    .locals 7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual/range {v0 .. v6}, Lit/sephiroth/android/library/widget/c;->a(IIIIII)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, 0x6

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, -0x1

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    return-void
.end method

.method a(I)V
    .locals 10

    if-gez p1, :cond_0

    const v0, 0x7fffffff

    const v2, 0x7fffffff

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    const/4 v2, 0x0

    :goto_0
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->c:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/c;->a(Landroid/view/animation/Interpolator;)V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    const/4 v3, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const v7, 0x7fffffff

    const/4 v8, 0x0

    const v9, 0x7fffffff

    move v4, p1

    invoke-virtual/range {v1 .. v9}, Lit/sephiroth/android/library/widget/c;->a(IIIIIIII)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v0, 0x4

    iput v0, p1, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method a(IIZ)V
    .locals 7

    if-gez p1, :cond_0

    const v0, 0x7fffffff

    const v2, 0x7fffffff

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    const/4 v2, 0x0

    :goto_0
    iput v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->c:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    if-eqz p3, :cond_1

    sget-object p3, Lit/sephiroth/android/library/widget/AbsHListView;->T:Landroid/view/animation/Interpolator;

    goto :goto_1

    :cond_1
    const/4 p3, 0x0

    :goto_1
    invoke-virtual {v0, p3}, Lit/sephiroth/android/library/widget/c;->a(Landroid/view/animation/Interpolator;)V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    const/4 v3, 0x0

    const/4 v5, 0x0

    move v4, p1

    move v6, p2

    invoke-virtual/range {v1 .. v6}, Lit/sephiroth/android/library/widget/c;->a(IIIII)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 p2, 0x4

    iput p2, p1, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method b()V
    .locals 11

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, -0x1

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->d:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->b(I)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->k(Lit/sephiroth/android/library/widget/AbsHListView;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->e()V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static/range {v1 .. v10}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z

    return-void
.end method

.method b(I)V
    .locals 13

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/c;->a(Landroid/view/animation/Interpolator;)V

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v11

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/high16 v7, -0x80000000

    const v8, 0x7fffffff

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v12, 0x0

    move v5, p1

    invoke-virtual/range {v2 .. v12}, Lit/sephiroth/android/library/widget/c;->a(IIIIIIIIII)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v0, 0x6

    iput v0, p1, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method c()V
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->d:Ljava/lang/Runnable;

    const-wide/16 v2, 0x28

    invoke-virtual {v0, v1, v2, v3}, Lit/sephiroth/android/library/widget/AbsHListView;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method c(I)V
    .locals 4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v2, v2, Lit/sephiroth/android/library/widget/AbsHListView;->R:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Lit/sephiroth/android/library/widget/c;->a(III)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getOverScrollMode()I

    move-result v0

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->h(Lit/sephiroth/android/library/widget/AbsHListView;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v0, -0x1

    iput v0, p1, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->I:Lit/sephiroth/android/library/widget/AbsHListView$j;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView$j;->a()V

    goto :goto_2

    :cond_1
    :goto_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, 0x6

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->c()F

    move-result v0

    float-to-int v0, v0

    if-lez p1, :cond_2

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->i(Lit/sephiroth/android/library/widget/AbsHListView;)Landroid/support/v4/widget/EdgeEffectCompat;

    move-result-object p1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/support/v4/widget/EdgeEffectCompat;->onAbsorb(I)Z

    goto :goto_2

    :cond_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->j(Lit/sephiroth/android/library/widget/AbsHListView;)Landroid/support/v4/widget/EdgeEffectCompat;

    move-result-object p1

    goto :goto_1

    :cond_3
    :goto_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object p1, p1, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {p1, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public run()V
    .locals 15

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    const/4 v1, 0x6

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq v0, v1, :cond_a

    packed-switch v0, :pswitch_data_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    return-void

    :pswitch_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :pswitch_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-boolean v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->e()V

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->ao:I

    if-eqz v0, :cond_9

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v0

    if-nez v0, :cond_2

    goto/16 :goto_3

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->d()Z

    move-result v1

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->b()I

    move-result v0

    iget v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->c:I

    sub-int/2addr v4, v0

    if-lez v4, :cond_3

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v6, v6, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    iput v6, v5, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v5

    iput v5, v6, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v6}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v6

    sub-int/2addr v5, v6

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v6}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v6

    sub-int/2addr v5, v6

    sub-int/2addr v5, v3

    invoke-static {v5, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    goto :goto_0

    :cond_3
    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildCount()I

    move-result v5

    sub-int/2addr v5, v3

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v7, v7, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    add-int/2addr v7, v5

    iput v7, v6, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v6, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v5

    iput v5, v6, Lit/sephiroth/android/library/widget/AbsHListView;->B:I

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v5}, Lit/sephiroth/android/library/widget/AbsHListView;->getWidth()I

    move-result v5

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v6}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingRight()I

    move-result v6

    sub-int/2addr v5, v6

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v6}, Lit/sephiroth/android/library/widget/AbsHListView;->getPaddingLeft()I

    move-result v6

    sub-int/2addr v5, v6

    sub-int/2addr v5, v3

    neg-int v5, v5

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    :goto_0
    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v6, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v6, v6, Lit/sephiroth/android/library/widget/AbsHListView;->A:I

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v7, v7, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_4

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v6

    goto :goto_1

    :cond_4
    const/4 v6, 0x0

    :goto_1
    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v7, v4, v4}, Lit/sephiroth/android/library/widget/AbsHListView;->c(II)Z

    move-result v7

    if-eqz v7, :cond_5

    if-eqz v4, :cond_5

    const/4 v2, 0x1

    :cond_5
    if-eqz v2, :cond_7

    if-eqz v5, :cond_6

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v0

    sub-int/2addr v0, v6

    sub-int v0, v4, v0

    neg-int v6, v0

    iget-object v5, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v7, 0x0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v8

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v12, v0, Lit/sephiroth/android/library/widget/AbsHListView;->R:I

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-static/range {v5 .. v14}, Lit/sephiroth/android/library/widget/AbsHListView;->b(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z

    :cond_6
    if-eqz v1, :cond_12

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/AbsHListView$e;->c(I)V

    return-void

    :cond_7
    if-eqz v1, :cond_11

    if-nez v2, :cond_11

    if-eqz v7, :cond_8

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    :cond_8
    iput v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->c:I

    :goto_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->a:Lit/sephiroth/android/library/a/a$a;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/a/a$a;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_9
    :goto_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    return-void

    :cond_a
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->b:Lit/sephiroth/android/library/widget/c;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->d()Z

    move-result v1

    if-eqz v1, :cond_11

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getScrollX()I

    move-result v1

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->b()I

    move-result v14

    sub-int v5, v14, v1

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    iget-object v7, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v11, v7, Lit/sephiroth/android/library/widget/AbsHListView;->R:I

    const/4 v12, 0x0

    const/4 v13, 0x0

    move v7, v1

    invoke-static/range {v4 .. v13}, Lit/sephiroth/android/library/widget/AbsHListView;->c(Lit/sephiroth/android/library/widget/AbsHListView;IIIIIIIIZ)Z

    move-result v4

    if-eqz v4, :cond_10

    if-gtz v1, :cond_b

    if-lez v14, :cond_b

    const/4 v4, 0x1

    goto :goto_4

    :cond_b
    const/4 v4, 0x0

    :goto_4
    if-ltz v1, :cond_c

    if-gez v14, :cond_c

    const/4 v2, 0x1

    :cond_c
    if-nez v4, :cond_e

    if-eqz v2, :cond_d

    goto :goto_5

    :cond_d
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a()V

    return-void

    :cond_e
    :goto_5
    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->c()F

    move-result v1

    float-to-int v1, v1

    if-eqz v2, :cond_f

    neg-int v1, v1

    :cond_f
    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->e()V

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/AbsHListView$e;->a(I)V

    return-void

    :cond_10
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$e;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->invalidate()V

    goto :goto_2

    :cond_11
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$e;->b()V

    :cond_12
    return-void

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
