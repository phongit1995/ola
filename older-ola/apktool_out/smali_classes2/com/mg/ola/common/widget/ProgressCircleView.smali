.class public Lcom/mg/ola/common/widget/ProgressCircleView;
.super Landroid/view/View;


# static fields
.field private static a:I = 0x32


# instance fields
.field private b:I

.field private c:I

.field private d:I

.field private e:I

.field private f:J

.field private g:J

.field private h:Landroid/graphics/Paint;

.field private i:Landroid/graphics/RectF;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x5

    iput p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->d:I

    const-string v0, "#50000000"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->e:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->f:J

    const-wide/16 v0, 0x64

    iput-wide v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->g:J

    const-string v0, "http://schemas.android.com/apk/res/android"

    const-string v1, "color"

    invoke-interface {p2, v0, v1, p1}, Landroid/util/AttributeSet;->getAttributeResourceValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->d:I

    invoke-direct {p0}, Lcom/mg/ola/common/widget/ProgressCircleView;->a()V

    return-void
.end method

.method private a()V
    .locals 5

    sget v0, Lcom/mg/ola/common/widget/ProgressCircleView;->a:I

    int-to-float v0, v0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/ProgressCircleView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v2, v0, v1}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v0

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int v0, v0

    iput v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    iget-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    int-to-double v0, v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int v0, v0

    new-instance v1, Landroid/graphics/RectF;

    int-to-float v0, v0

    iget v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    iget v3, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    add-int/2addr v2, v3

    int-to-float v2, v2

    iget v3, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    iget v4, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    add-int/2addr v3, v4

    int-to-float v3, v3

    invoke-direct {v1, v0, v0, v2, v3}, Landroid/graphics/RectF;-><init>(FFFF)V

    iput-object v1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->i:Landroid/graphics/RectF;

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->d:I

    iput p2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->e:I

    return-void
.end method

.method public onDraw(Landroid/graphics/Canvas;)V
    .locals 9

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    iget-wide v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->f:J

    const-wide/16 v2, 0x64

    mul-long v0, v0, v2

    iget-wide v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->g:J

    div-long/2addr v0, v2

    long-to-int v0, v0

    mul-int/lit16 v1, v0, 0x168

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    if-lez v0, :cond_0

    iget-object v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    iget v3, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->d:I

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->i:Landroid/graphics/RectF;

    const/high16 v5, 0x43870000    # 270.0f

    const/4 v7, 0x0

    iget-object v8, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    move-object v3, p1

    move v6, v1

    invoke-virtual/range {v3 .. v8}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    :cond_0
    const/16 v2, 0x64

    if-ge v0, v2, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->e:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v4, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->i:Landroid/graphics/RectF;

    const/high16 v0, 0x43870000    # 270.0f

    add-float v5, v1, v0

    const/high16 v0, 0x43b40000    # 360.0f

    sub-float v6, v0, v1

    const/4 v7, 0x0

    iget-object v8, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    move-object v3, p1

    invoke-virtual/range {v3 .. v8}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    :cond_1
    return-void
.end method

.method protected onMeasure(II)V
    .locals 1

    iget p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    iget p2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    mul-int/lit8 p2, p2, 0x2

    add-int/2addr p1, p2

    iget p2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    iget v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    mul-int/lit8 v0, v0, 0x2

    add-int/2addr p2, v0

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/common/widget/ProgressCircleView;->setMeasuredDimension(II)V

    return-void
.end method

.method public setProgress(J)V
    .locals 3

    iget-wide v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->f:J

    cmp-long v2, p1, v0

    if-nez v2, :cond_0

    return-void

    :cond_0
    iput-wide p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->f:J

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/ProgressCircleView;->invalidate()V

    return-void
.end method

.method public setProgressColor(I)V
    .locals 0

    return-void
.end method

.method public setRadius(I)V
    .locals 4

    sput p1, Lcom/mg/ola/common/widget/ProgressCircleView;->a:I

    sget p1, Lcom/mg/ola/common/widget/ProgressCircleView;->a:I

    int-to-float p1, p1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/ProgressCircleView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v1, p1, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p1

    float-to-double v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int p1, v0

    iput p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    iget p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    int-to-double v0, p1

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int p1, v0

    new-instance v0, Landroid/graphics/RectF;

    int-to-float p1, p1

    iget v1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    int-to-float v1, v1

    iget v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    int-to-float v2, v2

    invoke-direct {v0, p1, p1, v1, v2}, Landroid/graphics/RectF;-><init>(FFFF)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->i:Landroid/graphics/RectF;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/ProgressCircleView;->requestLayout()V

    return-void
.end method

.method public setStrokeWidth(F)V
    .locals 4

    float-to-int v0, p1

    iput v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->h:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->b:I

    int-to-double v0, p1

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int p1, v0

    new-instance v0, Landroid/graphics/RectF;

    int-to-float p1, p1

    iget v1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    int-to-float v1, v1

    iget v2, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->c:I

    int-to-float v2, v2

    invoke-direct {v0, p1, p1, v1, v2}, Landroid/graphics/RectF;-><init>(FFFF)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->i:Landroid/graphics/RectF;

    return-void
.end method

.method public setTotal(J)V
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-eqz v2, :cond_0

    iput-wide p1, p0, Lcom/mg/ola/common/widget/ProgressCircleView;->g:J

    :cond_0
    return-void
.end method
