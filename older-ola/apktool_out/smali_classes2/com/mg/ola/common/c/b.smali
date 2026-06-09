.class public Lcom/mg/ola/common/c/b;
.super Lcom/mg/ola/common/c/c;


# instance fields
.field private f:Landroid/widget/HorizontalScrollView;

.field private g:Landroid/view/animation/Animation;

.field private h:Landroid/view/ViewGroup;

.field private i:Landroid/view/ViewGroup;

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/mg/ola/common/c/a;",
            ">;"
        }
    .end annotation
.end field

.field private k:Z

.field private l:Landroid/view/View$OnClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/mg/ola/common/c/c;-><init>(Landroid/content/Context;)V

    new-instance v0, Lcom/mg/ola/common/c/b$2;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/c/b$2;-><init>(Lcom/mg/ola/common/c/b;)V

    iput-object v0, p0, Lcom/mg/ola/common/c/b;->l:Landroid/view/View$OnClickListener;

    const v0, 0x7f01003e

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/common/c/b;->g:Landroid/view/animation/Animation;

    iget-object p1, p0, Lcom/mg/ola/common/c/b;->g:Landroid/view/animation/Animation;

    new-instance v0, Lcom/mg/ola/common/c/b$1;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/c/b$1;-><init>(Lcom/mg/ola/common/c/b;)V

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    const p1, 0x7f0b00be

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/c/b;->a(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->getContentView()Landroid/view/View;

    move-result-object p1

    const v0, 0x7f0903fd

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iput-object v0, p0, Lcom/mg/ola/common/c/b;->h:Landroid/view/ViewGroup;

    const v0, 0x7f0903fc

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iput-object v0, p0, Lcom/mg/ola/common/c/b;->i:Landroid/view/ViewGroup;

    const v0, 0x7f090446

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/HorizontalScrollView;

    iput-object p1, p0, Lcom/mg/ola/common/c/b;->f:Landroid/widget/HorizontalScrollView;

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/c/b;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/c/b;->j:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 1

    invoke-super {p0}, Lcom/mg/ola/common/c/c;->a()V

    iget-object v0, p0, Lcom/mg/ola/common/c/b;->i:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    return-void
.end method

.method protected a(Landroid/graphics/Rect;Landroid/view/View;)V
    .locals 5

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x2

    invoke-direct {v0, v1, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->c()I

    move-result v0

    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v0, v2}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-virtual {p2, v0, v1}, Landroid/view/View;->measure(II)V

    invoke-virtual {p2}, Landroid/view/View;->getMeasuredHeight()I

    move-result p2

    iget-object v0, p0, Lcom/mg/ola/common/c/b;->f:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0}, Landroid/widget/HorizontalScrollView;->getMeasuredWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->b()I

    move-result v1

    iget v2, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->d()I

    move-result v3

    iget v4, p1, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v3, v4

    const/4 v4, 0x0

    if-le v2, v3, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    if-eqz v2, :cond_1

    iget v3, p1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v3, p2

    add-int/2addr v3, v1

    goto :goto_1

    :cond_1
    iget p2, p1, Landroid/graphics/Rect;->bottom:I

    sub-int v3, p2, v1

    :goto_1
    iget p2, p1, Landroid/graphics/Rect;->left:I

    add-int/2addr p2, v0

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->c()I

    move-result v1

    if-le p2, v1, :cond_2

    iget p2, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result p1

    sub-int/2addr v0, p1

    sub-int p1, p2, v0

    if-gez p1, :cond_4

    const/4 p1, 0x0

    goto :goto_2

    :cond_2
    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result p2

    if-le p2, v0, :cond_3

    invoke-virtual {p1}, Landroid/graphics/Rect;->centerX()I

    move-result p1

    div-int/lit8 v0, v0, 0x2

    sub-int/2addr p1, v0

    goto :goto_2

    :cond_3
    iget p1, p1, Landroid/graphics/Rect;->left:I

    :cond_4
    :goto_2
    invoke-virtual {p0, p1, v3, v2}, Lcom/mg/ola/common/c/b;->a(IIZ)V

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/mg/ola/common/c/c;->a(Landroid/view/View;)V

    iget-object p1, p0, Lcom/mg/ola/common/c/b;->f:Landroid/widget/HorizontalScrollView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0}, Landroid/widget/HorizontalScrollView;->scrollTo(II)V

    iget-boolean p1, p0, Lcom/mg/ola/common/c/b;->c:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/c/b;->h:Landroid/view/ViewGroup;

    iget-object v0, p0, Lcom/mg/ola/common/c/b;->g:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_0
    return-void
.end method

.method protected a(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mg/ola/common/c/a;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/mg/ola/common/c/b;->j:Ljava/util/List;

    invoke-virtual {p0}, Lcom/mg/ola/common/c/b;->g()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/common/c/a;

    iget-boolean v2, p0, Lcom/mg/ola/common/c/b;->k:Z

    const/4 v3, 0x0

    if-nez v2, :cond_0

    const v2, 0x7f0b00bc

    iget-object v4, p0, Lcom/mg/ola/common/c/b;->i:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2, v4, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v2

    move-object v3, v2

    check-cast v3, Landroid/widget/TextView;

    iget-object v4, v1, Lcom/mg/ola/common/c/a;->b:Ljava/lang/CharSequence;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, v1, Lcom/mg/ola/common/c/a;->a:Landroid/graphics/drawable/Drawable;

    const/4 v5, 0x0

    invoke-virtual {v3, v5, v4, v5, v5}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    :goto_1
    iget-object v3, p0, Lcom/mg/ola/common/c/b;->l:Landroid/view/View$OnClickListener;

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_2

    :cond_0
    const v2, 0x7f0b00bb

    iget-object v4, p0, Lcom/mg/ola/common/c/b;->i:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2, v4, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v2

    move-object v3, v2

    check-cast v3, Landroid/widget/ImageView;

    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v4, v1, Lcom/mg/ola/common/c/a;->a:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    :goto_2
    iget-object v3, p0, Lcom/mg/ola/common/c/b;->i:Landroid/view/ViewGroup;

    invoke-virtual {v3, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    new-instance v3, Ljava/lang/ref/WeakReference;

    invoke-direct {v3, v2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v3, v1, Lcom/mg/ola/common/c/a;->d:Ljava/lang/ref/WeakReference;

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/common/c/b;->k:Z

    return-void
.end method
