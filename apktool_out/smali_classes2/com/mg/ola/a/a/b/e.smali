.class Lcom/mg/ola/a/a/b/e;
.super Lcom/mg/ola/a/a/b/i;


# instance fields
.field private g:F

.field private h:F

.field private i:F

.field private j:Z


# direct methods
.method public varargs constructor <init>([Lcom/mg/ola/a/a/b/h$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/b/i;-><init>([Lcom/mg/ola/a/a/b/h;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/e;->j:Z

    return-void
.end method


# virtual methods
.method public a()Lcom/mg/ola/a/a/b/e;
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v2, v1, [Lcom/mg/ola/a/a/b/h$a;

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_0

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/h;->e()Lcom/mg/ola/a/a/b/h;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/h$a;

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/mg/ola/a/a/b/e;

    invoke-direct {v0, v2}, Lcom/mg/ola/a/a/b/e;-><init>([Lcom/mg/ola/a/a/b/h$a;)V

    return-object v0
.end method

.method public a(F)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lcom/mg/ola/a/a/b/e;->b(F)F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    return-object p1
.end method

.method public b(F)F
    .locals 5

    iget v0, p0, Lcom/mg/ola/a/a/b/e;->a:I

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_3

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/e;->j:Z

    if-eqz v0, :cond_0

    iput-boolean v2, p0, Lcom/mg/ola/a/a/b/e;->j:Z

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v0

    iput v0, p0, Lcom/mg/ola/a/a/b/e;->g:F

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v0

    iput v0, p0, Lcom/mg/ola/a/a/b/e;->h:F

    iget v0, p0, Lcom/mg/ola/a/a/b/e;->h:F

    iget v1, p0, Lcom/mg/ola/a/a/b/e;->g:F

    sub-float/2addr v0, v1

    iput v0, p0, Lcom/mg/ola/a/a/b/e;->i:F

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->d:Landroid/view/animation/Interpolator;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->d:Landroid/view/animation/Interpolator;

    invoke-interface {v0, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    if-nez v0, :cond_2

    iget v0, p0, Lcom/mg/ola/a/a/b/e;->g:F

    iget v1, p0, Lcom/mg/ola/a/a/b/e;->i:F

    mul-float p1, p1, v1

    add-float/2addr v0, p1

    return v0

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    iget v1, p0, Lcom/mg/ola/a/a/b/e;->g:F

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    iget v2, p0, Lcom/mg/ola/a/a/b/e;->h:F

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    :goto_0
    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->floatValue()F

    move-result p1

    return p1

    :cond_3
    const/4 v0, 0x0

    cmpg-float v0, p1, v0

    if-gtz v0, :cond_6

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/h$a;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v2

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v3

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v0

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v4

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-interface {v1, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_4
    sub-float/2addr p1, v0

    sub-float/2addr v4, v0

    div-float/2addr p1, v4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    if-nez v0, :cond_5

    sub-float/2addr v3, v2

    mul-float p1, p1, v3

    add-float/2addr v2, p1

    return v2

    :cond_5
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->floatValue()F

    move-result v2

    return v2

    :cond_6
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_9

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mg/ola/a/a/b/e;->a:I

    sub-int/2addr v2, v1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mg/ola/a/a/b/e;->a:I

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/h$a;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v2

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v3

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v0

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v4

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-interface {v1, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_7
    sub-float/2addr p1, v0

    sub-float/2addr v4, v0

    div-float/2addr p1, v4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    if-nez v0, :cond_8

    sub-float/2addr v3, v2

    mul-float p1, p1, v3

    add-float/2addr v2, p1

    return v2

    :cond_8
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->floatValue()F

    move-result v2

    return v2

    :cond_9
    iget-object v0, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    move-object v1, v0

    const/4 v0, 0x1

    :goto_1
    iget v2, p0, Lcom/mg/ola/a/a/b/e;->a:I

    if-ge v0, v2, :cond_d

    iget-object v2, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h$a;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v4

    cmpg-float v4, p1, v4

    if-gez v4, :cond_c

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h$a;->d()Landroid/view/animation/Interpolator;

    move-result-object v0

    if-eqz v0, :cond_a

    invoke-interface {v0, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_a
    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v0

    sub-float/2addr p1, v0

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v0

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->c()F

    move-result v3

    sub-float/2addr v0, v3

    div-float/2addr p1, v0

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v0

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h$a;->f()F

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    if-nez v2, :cond_b

    sub-float/2addr v1, v0

    mul-float p1, p1, v1

    add-float/2addr v0, p1

    return v0

    :cond_b
    iget-object v2, p0, Lcom/mg/ola/a/a/b/e;->f:Lcom/mg/ola/a/a/b/m;

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-interface {v2, p1, v0, v1}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->floatValue()F

    move-result v0

    return v0

    :cond_c
    add-int/lit8 v0, v0, 0x1

    move-object v1, v2

    goto :goto_1

    :cond_d
    iget-object p1, p0, Lcom/mg/ola/a/a/b/e;->e:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mg/ola/a/a/b/e;->a:I

    sub-int/2addr v0, v3

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object p1

    goto/16 :goto_0
.end method

.method public synthetic b()Lcom/mg/ola/a/a/b/i;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/e;->a()Lcom/mg/ola/a/a/b/e;

    move-result-object v0

    return-object v0
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/e;->a()Lcom/mg/ola/a/a/b/e;

    move-result-object v0

    return-object v0
.end method
