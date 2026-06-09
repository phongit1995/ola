.class public Lchat/ola/vn/view/RotateLayout;
.super Landroid/view/ViewGroup;


# instance fields
.field private a:I

.field private b:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const p1, 0x106000d

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/RotateLayout;->setBackgroundResource(I)V

    return-void
.end method


# virtual methods
.method protected onFinishInflate()V
    .locals 2

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/RotateLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->b(Landroid/view/View;F)V

    iget-object v0, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->c(Landroid/view/View;F)V

    return-void
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    sub-int/2addr p4, p2

    sub-int/2addr p5, p3

    iget p1, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    const/4 p2, 0x0

    if-eqz p1, :cond_1

    const/16 p3, 0x5a

    if-eq p1, p3, :cond_0

    const/16 p3, 0xb4

    if-eq p1, p3, :cond_1

    const/16 p3, 0x10e

    if-eq p1, p3, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1, p2, p2, p5, p4}, Landroid/view/View;->layout(IIII)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1, p2, p2, p4, p5}, Landroid/view/View;->layout(IIII)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 5

    iget v0, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    const/16 v1, 0x10e

    const/16 v2, 0xb4

    const/16 v3, 0x5a

    const/4 v4, 0x0

    if-eqz v0, :cond_1

    if-eq v0, v3, :cond_0

    if-eq v0, v2, :cond_1

    if-eq v0, v1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p0, v0, p2, p1}, Lchat/ola/vn/view/RotateLayout;->measureChild(Landroid/view/View;II)V

    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v4

    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result p1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p0, v0, p1, p2}, Lchat/ola/vn/view/RotateLayout;->measureChild(Landroid/view/View;II)V

    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredWidth()I

    move-result v4

    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result p1

    :goto_0
    invoke-virtual {p0, v4, p1}, Lchat/ola/vn/view/RotateLayout;->setMeasuredDimension(II)V

    iget p2, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    const/4 v0, 0x0

    if-eqz p2, :cond_5

    if-eq p2, v3, :cond_4

    if-eq p2, v2, :cond_3

    if-eq p2, v1, :cond_2

    goto :goto_3

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    int-to-float p2, v4

    invoke-static {p1, p2}, Lcom/mg/ola/a/a/c/b;->e(Landroid/view/View;F)V

    goto :goto_2

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    int-to-float v0, v4

    goto :goto_1

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    :goto_1
    invoke-static {p2, v0}, Lcom/mg/ola/a/a/c/b;->e(Landroid/view/View;F)V

    iget-object p2, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    int-to-float p1, p1

    invoke-static {p2, p1}, Lcom/mg/ola/a/a/c/b;->f(Landroid/view/View;F)V

    goto :goto_3

    :cond_5
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    invoke-static {p1, v0}, Lcom/mg/ola/a/a/c/b;->f(Landroid/view/View;F)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/view/RotateLayout;->b:Landroid/view/View;

    iget p2, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    neg-int p2, p2

    int-to-float p2, p2

    invoke-static {p1, p2}, Lcom/mg/ola/a/a/c/b;->d(Landroid/view/View;F)V

    return-void
.end method

.method public setOrientation(I)V
    .locals 1

    rem-int/lit16 p1, p1, 0x168

    iget v0, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    if-ne v0, p1, :cond_0

    return-void

    :cond_0
    iput p1, p0, Lchat/ola/vn/view/RotateLayout;->a:I

    invoke-virtual {p0}, Lchat/ola/vn/view/RotateLayout;->requestLayout()V

    return-void
.end method
