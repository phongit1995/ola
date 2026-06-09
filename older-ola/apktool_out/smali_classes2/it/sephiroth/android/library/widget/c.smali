.class public Lit/sephiroth/android/library/widget/c;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/widget/c$a;
    }
.end annotation


# static fields
.field private static f:F = 8.0f

.field private static g:F = 1.0f


# instance fields
.field private a:I

.field private final b:Lit/sephiroth/android/library/widget/c$a;

.field private final c:Lit/sephiroth/android/library/widget/c$a;

.field private d:Landroid/view/animation/Interpolator;

.field private final e:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c;->a(F)F

    move-result v1

    div-float/2addr v0, v1

    sput v0, Lit/sephiroth/android/library/widget/c;->g:F

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lit/sephiroth/android/library/widget/c;-><init>(Landroid/content/Context;Landroid/view/animation/Interpolator;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/view/animation/Interpolator;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Lit/sephiroth/android/library/widget/c;-><init>(Landroid/content/Context;Landroid/view/animation/Interpolator;Z)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/view/animation/Interpolator;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lit/sephiroth/android/library/widget/c;->d:Landroid/view/animation/Interpolator;

    iput-boolean p3, p0, Lit/sephiroth/android/library/widget/c;->e:Z

    new-instance p2, Lit/sephiroth/android/library/widget/c$a;

    invoke-direct {p2, p1}, Lit/sephiroth/android/library/widget/c$a;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    new-instance p2, Lit/sephiroth/android/library/widget/c$a;

    invoke-direct {p2, p1}, Lit/sephiroth/android/library/widget/c$a;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    return-void
.end method

.method public static a(F)F
    .locals 4

    sget v0, Lit/sephiroth/android/library/widget/c;->f:F

    mul-float p0, p0, v0

    const/high16 v0, 0x3f800000    # 1.0f

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    neg-float v1, p0

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->exp(D)D

    move-result-wide v1

    double-to-float v1, v1

    sub-float/2addr v0, v1

    sub-float/2addr p0, v0

    goto :goto_0

    :cond_0
    const v1, 0x3ebc5ab2

    sub-float p0, v0, p0

    float-to-double v2, p0

    invoke-static {v2, v3}, Ljava/lang/Math;->exp(D)D

    move-result-wide v2

    double-to-float p0, v2

    sub-float/2addr v0, p0

    const p0, 0x3f21d2a7

    mul-float v0, v0, p0

    add-float p0, v0, v1

    :goto_0
    sget v0, Lit/sephiroth/android/library/widget/c;->g:F

    mul-float p0, p0, v0

    return p0
.end method


# virtual methods
.method public a(III)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0, p1, p2, p3}, Lit/sephiroth/android/library/widget/c$a;->c(III)V

    return-void
.end method

.method public a(IIIII)V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lit/sephiroth/android/library/widget/c;->a:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0, p1, p3, p5}, Lit/sephiroth/android/library/widget/c$a;->a(III)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {p1, p2, p4, p5}, Lit/sephiroth/android/library/widget/c$a;->a(III)V

    return-void
.end method

.method public a(IIIIIIII)V
    .locals 11

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    invoke-virtual/range {v0 .. v10}, Lit/sephiroth/android/library/widget/c;->a(IIIIIIIIII)V

    return-void
.end method

.method public a(IIIIIIIIII)V
    .locals 12

    move-object v0, p0

    iget-boolean v1, v0, Lit/sephiroth/android/library/widget/c;->e:Z

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c;->a()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, v0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v1

    iget-object v2, v0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v2}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v2

    move v3, p3

    int-to-float v4, v3

    invoke-static {v4}, Ljava/lang/Math;->signum(F)F

    move-result v5

    invoke-static {v1}, Ljava/lang/Math;->signum(F)F

    move-result v6

    cmpl-float v5, v5, v6

    if-nez v5, :cond_1

    move/from16 v5, p4

    int-to-float v6, v5

    invoke-static {v6}, Ljava/lang/Math;->signum(F)F

    move-result v7

    invoke-static {v2}, Ljava/lang/Math;->signum(F)F

    move-result v8

    cmpl-float v7, v7, v8

    if-nez v7, :cond_2

    add-float/2addr v4, v1

    float-to-int v1, v4

    add-float/2addr v6, v2

    float-to-int v2, v6

    move v5, v1

    goto :goto_0

    :cond_0
    move v3, p3

    :cond_1
    move/from16 v5, p4

    :cond_2
    move v2, v5

    move v5, v3

    :goto_0
    const/4 v1, 0x1

    iput v1, v0, Lit/sephiroth/android/library/widget/c;->a:I

    iget-object v3, v0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    move v4, p1

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p9

    invoke-virtual/range {v3 .. v8}, Lit/sephiroth/android/library/widget/c$a;->a(IIIII)V

    iget-object v6, v0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    move v7, p2

    move v8, v2

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p10

    invoke-virtual/range {v6 .. v11}, Lit/sephiroth/android/library/widget/c$a;->a(IIIII)V

    return-void
.end method

.method a(Landroid/view/animation/Interpolator;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/c;->d:Landroid/view/animation/Interpolator;

    return-void
.end method

.method public final a()Z
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->a(Lit/sephiroth/android/library/widget/c$a;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->a(Lit/sephiroth/android/library/widget/c$a;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public a(FF)Z
    .locals 3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->e(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c$a;->d(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v1

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c$a;->e(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v2}, Lit/sephiroth/android/library/widget/c$a;->d(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v2

    sub-int/2addr v1, v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/c;->a()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {p1}, Ljava/lang/Math;->signum(F)F

    move-result p1

    int-to-float v0, v0

    invoke-static {v0}, Ljava/lang/Math;->signum(F)F

    move-result v0

    cmpl-float p1, p1, v0

    if-nez p1, :cond_0

    invoke-static {p2}, Ljava/lang/Math;->signum(F)F

    move-result p1

    int-to-float p2, v1

    invoke-static {p2}, Ljava/lang/Math;->signum(F)F

    move-result p2

    cmpl-float p1, p1, p2

    if-nez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public a(IIIIII)Z
    .locals 2

    const/4 v0, 0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/c;->a:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v1, p1, p3, p4}, Lit/sephiroth/android/library/widget/c$a;->b(III)Z

    move-result p1

    iget-object p3, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {p3, p2, p5, p6}, Lit/sephiroth/android/library/widget/c$a;->b(III)Z

    move-result p2

    if-nez p1, :cond_1

    if-eqz p2, :cond_0

    return v0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    return v0
.end method

.method public final b()I
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->b(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v0

    return v0
.end method

.method public final b(F)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/c$a;->a(F)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/c$a;->a(F)V

    return-void
.end method

.method public c()F
    .locals 3

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v1

    mul-float v0, v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v1

    iget-object v2, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v2}, Lit/sephiroth/android/library/widget/c$a;->c(Lit/sephiroth/android/library/widget/c$a;)F

    move-result v2

    mul-float v1, v1, v2

    add-float/2addr v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    return v0
.end method

.method public d()Z
    .locals 6

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/c;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget v0, p0, Lit/sephiroth/android/library/widget/c;->a:I

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->a(Lit/sephiroth/android/library/widget/c$a;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->c()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->b()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->a()V

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->a(Lit/sephiroth/android/library/widget/c$a;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->c()Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->b()Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->a()V

    goto :goto_1

    :pswitch_1
    invoke-static {}, Landroid/view/animation/AnimationUtils;->currentAnimationTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v2}, Lit/sephiroth/android/library/widget/c$a;->g(Lit/sephiroth/android/library/widget/c$a;)J

    move-result-wide v2

    sub-long v4, v0, v2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/c$a;->f(Lit/sephiroth/android/library/widget/c$a;)I

    move-result v0

    int-to-long v1, v0

    cmp-long v3, v4, v1

    if-gez v3, :cond_3

    long-to-float v1, v4

    int-to-float v0, v0

    div-float/2addr v1, v0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->d:Landroid/view/animation/Interpolator;

    if-nez v0, :cond_2

    invoke-static {v1}, Lit/sephiroth/android/library/widget/c;->a(F)F

    move-result v0

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->d:Landroid/view/animation/Interpolator;

    invoke-interface {v0, v1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result v0

    :goto_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v1, v0}, Lit/sephiroth/android/library/widget/c$a;->b(F)V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v1, v0}, Lit/sephiroth/android/library/widget/c$a;->b(F)V

    goto :goto_1

    :cond_3
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/c;->e()V

    :cond_4
    :goto_1
    const/4 v0, 0x1

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public e()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->b:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->a()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/c;->c:Lit/sephiroth/android/library/widget/c$a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/c$a;->a()V

    return-void
.end method
