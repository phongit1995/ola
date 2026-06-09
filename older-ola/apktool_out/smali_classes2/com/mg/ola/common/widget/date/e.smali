.class Lcom/mg/ola/common/widget/date/e;
.super Lcom/mg/ola/common/widget/date/a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/a;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public a()I
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/e;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/date/g;->e()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/e;->h:[Ljava/lang/String;

    array-length v1, v1

    if-gez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    if-lt v0, v1, :cond_1

    add-int/lit8 v1, v1, -0x1

    return v1

    :cond_1
    return v0
.end method

.method public b(I)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/e;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/e;->i:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/e;->isShown()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/e;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/date/g;->a(I)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/e;->a:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/e;->i:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/mg/ola/common/widget/date/e;->a(II)V

    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 8

    invoke-super {p0, p1}, Lcom/mg/ola/common/widget/date/a;->onDraw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/e;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/date/g;->e()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/e;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/date/g;->f()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/date/e;->h:[Ljava/lang/String;

    array-length v2, v2

    const/4 v3, -0x3

    :goto_0
    const/4 v4, 0x3

    if-gt v3, v4, :cond_1

    add-int v4, v0, v3

    if-ltz v4, :cond_0

    if-ge v4, v2, :cond_0

    iget-object v5, p0, Lcom/mg/ola/common/widget/date/e;->h:[Ljava/lang/String;

    aget-object v4, v5, v4

    iget v5, p0, Lcom/mg/ola/common/widget/date/e;->g:I

    int-to-float v5, v5

    iget v6, p0, Lcom/mg/ola/common/widget/date/e;->e:I

    iget v7, p0, Lcom/mg/ola/common/widget/date/e;->d:I

    add-int/2addr v6, v7

    iget v7, p0, Lcom/mg/ola/common/widget/date/e;->f:I

    mul-int v7, v7, v3

    add-int/2addr v6, v7

    sub-int/2addr v6, v1

    int-to-float v6, v6

    iget-object v7, p0, Lcom/mg/ola/common/widget/date/e;->c:Landroid/graphics/Paint;

    invoke-virtual {p1, v4, v5, v6, v7}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lcom/mg/ola/common/widget/date/a;->onSizeChanged(IIII)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/date/e;->b:Lcom/mg/ola/common/widget/date/g;

    iget p2, p0, Lcom/mg/ola/common/widget/date/e;->f:I

    iget-object p3, p0, Lcom/mg/ola/common/widget/date/e;->h:[Ljava/lang/String;

    array-length p3, p3

    add-int/lit8 p3, p3, -0x1

    mul-int p2, p2, p3

    int-to-float p2, p2

    iget p3, p0, Lcom/mg/ola/common/widget/date/e;->f:I

    int-to-float p3, p3

    const/4 p4, 0x0

    invoke-virtual {p1, p2, p3, p4}, Lcom/mg/ola/common/widget/date/g;->a(FFZ)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/e;->b()V

    return-void
.end method
