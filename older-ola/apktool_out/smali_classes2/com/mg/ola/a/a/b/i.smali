.class Lcom/mg/ola/a/a/b/i;
.super Ljava/lang/Object;


# instance fields
.field a:I

.field b:Lcom/mg/ola/a/a/b/h;

.field c:Lcom/mg/ola/a/a/b/h;

.field d:Landroid/view/animation/Interpolator;

.field e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/h;",
            ">;"
        }
    .end annotation
.end field

.field f:Lcom/mg/ola/a/a/b/m;


# direct methods
.method public varargs constructor <init>([Lcom/mg/ola/a/a/b/h;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    array-length v0, p1

    iput v0, p0, Lcom/mg/ola/a/a/b/i;->a:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/a/a/b/h;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/i;->b:Lcom/mg/ola/a/a/b/h;

    iget-object p1, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mg/ola/a/a/b/i;->a:I

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/a/a/b/h;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    iget-object p1, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/h;->d()Landroid/view/animation/Interpolator;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/i;->d:Landroid/view/animation/Interpolator;

    return-void
.end method

.method public static varargs a([F)Lcom/mg/ola/a/a/b/i;
    .locals 6

    array-length v0, p0

    const/4 v1, 0x2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    new-array v1, v1, [Lcom/mg/ola/a/a/b/h$a;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-ne v0, v4, :cond_0

    invoke-static {v2}, Lcom/mg/ola/a/a/b/h;->b(F)Lcom/mg/ola/a/a/b/h;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$a;

    aput-object v0, v1, v3

    const/high16 v0, 0x3f800000    # 1.0f

    aget p0, p0, v3

    invoke-static {v0, p0}, Lcom/mg/ola/a/a/b/h;->a(FF)Lcom/mg/ola/a/a/b/h;

    move-result-object p0

    check-cast p0, Lcom/mg/ola/a/a/b/h$a;

    aput-object p0, v1, v4

    goto :goto_1

    :cond_0
    aget v5, p0, v3

    invoke-static {v2, v5}, Lcom/mg/ola/a/a/b/h;->a(FF)Lcom/mg/ola/a/a/b/h;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h$a;

    aput-object v2, v1, v3

    :goto_0
    if-ge v4, v0, :cond_1

    int-to-float v2, v4

    add-int/lit8 v3, v0, -0x1

    int-to-float v3, v3

    div-float/2addr v2, v3

    aget v3, p0, v4

    invoke-static {v2, v3}, Lcom/mg/ola/a/a/b/h;->a(FF)Lcom/mg/ola/a/a/b/h;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h$a;

    aput-object v2, v1, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    new-instance p0, Lcom/mg/ola/a/a/b/e;

    invoke-direct {p0, v1}, Lcom/mg/ola/a/a/b/e;-><init>([Lcom/mg/ola/a/a/b/h$a;)V

    return-object p0
.end method

.method public static varargs a([I)Lcom/mg/ola/a/a/b/i;
    .locals 6

    array-length v0, p0

    const/4 v1, 0x2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    new-array v1, v1, [Lcom/mg/ola/a/a/b/h$b;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-ne v0, v4, :cond_0

    invoke-static {v2}, Lcom/mg/ola/a/a/b/h;->a(F)Lcom/mg/ola/a/a/b/h;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h$b;

    aput-object v0, v1, v3

    const/high16 v0, 0x3f800000    # 1.0f

    aget p0, p0, v3

    invoke-static {v0, p0}, Lcom/mg/ola/a/a/b/h;->a(FI)Lcom/mg/ola/a/a/b/h;

    move-result-object p0

    check-cast p0, Lcom/mg/ola/a/a/b/h$b;

    aput-object p0, v1, v4

    goto :goto_1

    :cond_0
    aget v5, p0, v3

    invoke-static {v2, v5}, Lcom/mg/ola/a/a/b/h;->a(FI)Lcom/mg/ola/a/a/b/h;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h$b;

    aput-object v2, v1, v3

    :goto_0
    if-ge v4, v0, :cond_1

    int-to-float v2, v4

    add-int/lit8 v3, v0, -0x1

    int-to-float v3, v3

    div-float/2addr v2, v3

    aget v3, p0, v4

    invoke-static {v2, v3}, Lcom/mg/ola/a/a/b/h;->a(FI)Lcom/mg/ola/a/a/b/h;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h$b;

    aput-object v2, v1, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    new-instance p0, Lcom/mg/ola/a/a/b/g;

    invoke-direct {p0, v1}, Lcom/mg/ola/a/a/b/g;-><init>([Lcom/mg/ola/a/a/b/h$b;)V

    return-object p0
.end method


# virtual methods
.method public a(F)Ljava/lang/Object;
    .locals 4

    iget v0, p0, Lcom/mg/ola/a/a/b/i;->a:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->d:Landroid/view/animation/Interpolator;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->d:Landroid/view/animation/Interpolator;

    invoke-interface {v0, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->f:Lcom/mg/ola/a/a/b/m;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->b:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v1

    iget-object v2, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_1
    const/4 v0, 0x0

    cmpg-float v0, p1, v0

    const/4 v2, 0x1

    if-gtz v0, :cond_3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-interface {v1, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_2
    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->b:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v1

    sub-float/2addr p1, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v2

    sub-float/2addr v2, v1

    div-float/2addr p1, v2

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->f:Lcom/mg/ola/a/a/b/m;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/i;->b:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v1, p1, v2, v0}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_3
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_5

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mg/ola/a/a/b/i;->a:I

    sub-int/2addr v2, v1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-interface {v1, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_4
    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v1

    sub-float/2addr p1, v1

    iget-object v2, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v2

    sub-float/2addr v2, v1

    div-float/2addr p1, v2

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->f:Lcom/mg/ola/a/a/b/m;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v0

    iget-object v2, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1, p1, v0, v2}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_5
    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->b:Lcom/mg/ola/a/a/b/h;

    :goto_0
    iget v1, p0, Lcom/mg/ola/a/a/b/i;->a:I

    if-ge v2, v1, :cond_8

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v3

    cmpg-float v3, p1, v3

    if-gez v3, :cond_7

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->d()Landroid/view/animation/Interpolator;

    move-result-object v2

    if-eqz v2, :cond_6

    invoke-interface {v2, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    :cond_6
    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v2

    sub-float/2addr p1, v2

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->c()F

    move-result v3

    sub-float/2addr v3, v2

    div-float/2addr p1, v3

    iget-object v2, p0, Lcom/mg/ola/a/a/b/i;->f:Lcom/mg/ola/a/a/b/m;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v2, p1, v0, v1}, Lcom/mg/ola/a/a/b/m;->a(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_7
    add-int/lit8 v2, v2, 0x1

    move-object v0, v1

    goto :goto_0

    :cond_8
    iget-object p1, p0, Lcom/mg/ola/a/a/b/i;->c:Lcom/mg/ola/a/a/b/h;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/mg/ola/a/a/b/m;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/i;->f:Lcom/mg/ola/a/a/b/m;

    return-void
.end method

.method public b()Lcom/mg/ola/a/a/b/i;
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v2, v1, [Lcom/mg/ola/a/a/b/h;

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_0

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/h;->e()Lcom/mg/ola/a/a/b/h;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/mg/ola/a/a/b/i;

    invoke-direct {v0, v2}, Lcom/mg/ola/a/a/b/i;-><init>([Lcom/mg/ola/a/a/b/h;)V

    return-object v0
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/i;->b()Lcom/mg/ola/a/a/b/i;

    move-result-object v0

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    const-string v0, " "

    const/4 v1, 0x0

    :goto_0
    iget v2, p0, Lcom/mg/ola/a/a/b/i;->a:I

    if-ge v1, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/h;->b()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v0, "  "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method
