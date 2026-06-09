.class Lcom/mg/ola/common/widget/date/g;
.super Ljava/lang/Object;


# instance fields
.field private a:Z

.field private b:Z

.field private c:Z

.field private d:F

.field private e:F

.field private f:F

.field private g:F

.field private h:F

.field private i:F

.field private j:F

.field private k:F


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(IF)V
    .locals 3

    int-to-float p1, p1

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    mul-float p1, p1, v0

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->b:Z

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    rem-float/2addr v0, v1

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    rem-float/2addr p1, v0

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    rem-float/2addr v0, v1

    cmpg-float v1, p1, v0

    if-gez v1, :cond_0

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    add-float/2addr v1, p1

    goto :goto_0

    :cond_0
    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    sub-float v1, p1, v1

    :goto_0
    sub-float v2, v0, p1

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpl-float v0, v2, v0

    if-lez v0, :cond_1

    move p1, v1

    :cond_1
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gez v0, :cond_2

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    add-float/2addr v0, v1

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    :cond_2
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    cmpg-float v0, p1, v0

    if-gez v0, :cond_3

    neg-float p1, p2

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    goto :goto_1

    :cond_3
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    cmpl-float p1, p1, v0

    if-lez p1, :cond_4

    iput p2, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    :goto_1
    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->e:F

    const/4 p1, 0x1

    :goto_2
    iput-boolean p1, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    return-void

    :cond_4
    const/4 p1, 0x0

    goto :goto_2
.end method

.method private c(F)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget-boolean p1, p0, Lcom/mg/ola/common/widget/date/g;->b:Z

    if-eqz p1, :cond_0

    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    rem-float/2addr p1, v0

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    const/4 v0, 0x0

    cmpg-float p1, p1, v0

    if-gez p1, :cond_0

    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    add-float/2addr p1, v0

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    :cond_0
    return-void
.end method

.method private h()Z
    .locals 3

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->b:Z

    const/4 v1, 0x0

    if-nez v0, :cond_1

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v2, p0, Lcom/mg/ola/common/widget/date/g;->g:F

    cmpg-float v0, v0, v2

    if-gez v0, :cond_0

    const/high16 v0, 0x42480000    # 50.0f

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->g:F

    :goto_0
    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    goto :goto_1

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v2, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    cmpl-float v0, v0, v2

    if-lez v0, :cond_1

    const/high16 v0, -0x3db80000    # -50.0f

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    goto :goto_0

    :goto_1
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->e:F

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    return v0

    :cond_1
    return v1
.end method

.method private i()V
    .locals 4

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    const/high16 v1, 0x40a00000    # 5.0f

    const/high16 v2, 0x40000000    # 2.0f

    if-gez v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v3, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    div-float/2addr v3, v2

    sub-float/2addr v0, v3

    :goto_0
    iget v2, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    div-float/2addr v0, v2

    float-to-int v0, v0

    invoke-direct {p0, v0, v1}, Lcom/mg/ola/common/widget/date/g;->a(IF)V

    return-void

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v3, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    div-float/2addr v3, v2

    add-float/2addr v0, v3

    goto :goto_0

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    return-void
.end method

.method public a(F)V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    add-float/2addr v0, p1

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/date/g;->c(F)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/date/g;->h()Z

    return-void
.end method

.method public a(FFZ)V
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->a()V

    iput-boolean p3, p0, Lcom/mg/ola/common/widget/date/g;->b:Z

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->g:F

    iput p2, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    if-eqz p3, :cond_0

    iget p1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    const/high16 p3, 0x3f800000    # 1.0f

    sub-float/2addr p2, p3

    add-float/2addr p1, p2

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->h:F

    :cond_0
    return-void
.end method

.method public a(I)V
    .locals 2

    int-to-float v0, p1

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    mul-float v0, v0, v1

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    sub-float/2addr v0, v1

    const/high16 v1, 0x40400000    # 3.0f

    div-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v1, 0x42a00000    # 80.0f

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/common/widget/date/g;->a(IF)V

    return-void
.end method

.method public b()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    return-void
.end method

.method public b(F)V
    .locals 3

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    return-void

    :cond_0
    const/high16 v0, 0x41f00000    # 30.0f

    div-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v2, 0x40e00000    # 7.0f

    cmpg-float v0, v0, v2

    if-gez v0, :cond_1

    iput-boolean v1, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    return-void

    :cond_1
    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    return-void
.end method

.method public b(I)V
    .locals 1

    int-to-float p1, p1

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    mul-float p1, p1, v0

    iput p1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    return-void
.end method

.method public c()V
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->d()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/date/g;->i()V

    :cond_0
    return-void
.end method

.method public d()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x1

    return v0
.end method

.method public e()I
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    div-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method public f()I
    .locals 2

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->i:F

    rem-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method public g()Z
    .locals 4

    const-string v0, "update"

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_3

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const/high16 v3, 0x40e00000    # 7.0f

    cmpg-float v0, v0, v3

    if-gez v0, :cond_1

    iput-boolean v2, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->d()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/mg/ola/common/widget/date/g;->i()V

    :cond_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->d()Z

    move-result v0

    return v0

    :cond_1
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v2, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    sub-float/2addr v0, v2

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/date/g;->c(F)V

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    const v2, 0x3f6b851f    # 0.92f

    mul-float v0, v0, v2

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    invoke-direct {p0}, Lcom/mg/ola/common/widget/date/g;->h()Z

    move-result v0

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    const v2, 0x3f19999a    # 0.6f

    mul-float v0, v0, v2

    iput v0, p0, Lcom/mg/ola/common/widget/date/g;->d:F

    :cond_2
    return v1

    :cond_3
    iget-boolean v0, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    if-eqz v0, :cond_5

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    iget v3, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    sub-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    iget v3, p0, Lcom/mg/ola/common/widget/date/g;->e:F

    cmpg-float v0, v0, v3

    if-gez v0, :cond_4

    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->k:F

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/date/g;->c(F)V

    iput-boolean v2, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/g;->d()Z

    move-result v0

    return v0

    :cond_4
    iget v0, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    iget v2, p0, Lcom/mg/ola/common/widget/date/g;->f:F

    add-float/2addr v0, v2

    invoke-direct {p0, v0}, Lcom/mg/ola/common/widget/date/g;->c(F)V

    return v1

    :cond_5
    return v2
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "pos:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/mg/ola/common/widget/date/g;->j:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v1, ", isFl:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/date/g;->a:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", isMv:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/mg/ola/common/widget/date/g;->c:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
