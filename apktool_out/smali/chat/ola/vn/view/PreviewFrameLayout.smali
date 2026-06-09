.class public Lchat/ola/vn/view/PreviewFrameLayout;
.super Landroid/widget/RelativeLayout;


# instance fields
.field private a:D

.field private b:I

.field private c:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-wide p1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/view/PreviewFrameLayout;->setAspectRatio(D)V

    return-void
.end method


# virtual methods
.method protected onLayout(ZIIII)V
    .locals 7

    iget v0, p0, Lchat/ola/vn/view/PreviewFrameLayout;->c:I

    add-int v3, p2, v0

    iget p2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->b:I

    add-int v4, p3, p2

    iget p2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->c:I

    add-int v5, p4, p2

    iget p2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->b:I

    add-int v6, p5, p2

    move-object v1, p0

    move v2, p1

    invoke-super/range {v1 .. v6}, Landroid/widget/RelativeLayout;->onLayout(ZIIII)V

    return-void
.end method

.method protected onMeasure(II)V
    .locals 9

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p2

    int-to-double v0, p1

    int-to-double v2, p2

    div-double v4, v0, v2

    const/4 v6, 0x0

    iput v6, p0, Lchat/ola/vn/view/PreviewFrameLayout;->b:I

    iput v6, p0, Lchat/ola/vn/view/PreviewFrameLayout;->c:I

    iget-wide v6, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    cmpg-double v8, v4, v6

    if-gez v8, :cond_0

    iget-wide v0, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    mul-double v0, v0, v2

    double-to-int v0, v0

    sub-int p1, v0, p1

    neg-int p1, p1

    div-int/lit8 p1, p1, 0x2

    iput p1, p0, Lchat/ola/vn/view/PreviewFrameLayout;->c:I

    move p1, v0

    goto :goto_0

    :cond_0
    iget-wide v2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    cmpl-double v6, v4, v2

    if-lez v6, :cond_1

    iget-wide v2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    div-double/2addr v0, v2

    double-to-int v0, v0

    sub-int p2, v0, p2

    neg-int p2, p2

    div-int/lit8 p2, p2, 0x2

    iput p2, p0, Lchat/ola/vn/view/PreviewFrameLayout;->b:I

    move p2, v0

    :cond_1
    :goto_0
    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p1, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p1

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    invoke-super {p0, p1, p2}, Landroid/widget/RelativeLayout;->onMeasure(II)V

    return-void
.end method

.method public setAspectRatio(D)V
    .locals 3

    const-wide/16 v0, 0x0

    cmpg-double v2, p1, v0

    if-gtz v2, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1

    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/view/PreviewFrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getRequestedOrientation()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    div-double/2addr v0, p1

    move-wide p1, v0

    :catch_0
    :cond_1
    iget-wide v0, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    cmpl-double v2, v0, p1

    if-eqz v2, :cond_2

    iput-wide p1, p0, Lchat/ola/vn/view/PreviewFrameLayout;->a:D

    invoke-virtual {p0}, Lchat/ola/vn/view/PreviewFrameLayout;->requestLayout()V

    :cond_2
    return-void
.end method
