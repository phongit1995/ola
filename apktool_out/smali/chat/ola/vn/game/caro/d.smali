.class public Lchat/ola/vn/game/caro/d;
.super Landroid/view/View;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/game/caro/d$a;
    }
.end annotation


# static fields
.field public static a:I = 0x32

.field private static i:I = 0x4

.field private static j:I = 0x0

.field private static k:I = -0xd1d513

.field private static l:I = -0xed4b7

.field private static m:I = -0x6fe286c5

.field private static n:I = -0xdff8a49

.field private static o:J = 0x7d0L

.field private static p:J = 0x64L


# instance fields
.field private A:Landroid/graphics/Point;

.field private b:Landroid/graphics/Paint;

.field private c:Landroid/graphics/Paint;

.field private d:Landroid/graphics/Paint;

.field private e:Landroid/graphics/Paint;

.field private f:Landroid/graphics/Paint;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/graphics/Point;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/graphics/Point;",
            ">;"
        }
    .end annotation
.end field

.field private q:I

.field private r:I

.field private s:Landroid/graphics/Point;

.field private t:Z

.field private u:Z

.field private v:Landroid/graphics/PointF;

.field private w:Landroid/os/CountDownTimer;

.field private x:Lchat/ola/vn/game/caro/d$a;

.field private y:Z

.field private z:Landroid/graphics/Point;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget v0, Lchat/ola/vn/f;->l:I

    sput v0, Lchat/ola/vn/game/caro/d;->j:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->t:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->u:Z

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->y:Z

    invoke-direct {p0}, Lchat/ola/vn/game/caro/d;->d()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->t:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->u:Z

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->y:Z

    invoke-direct {p0}, Lchat/ola/vn/game/caro/d;->d()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->t:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->u:Z

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->y:Z

    invoke-direct {p0}, Lchat/ola/vn/game/caro/d;->d()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/game/caro/d;)Landroid/graphics/Paint;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    return-object p0
.end method

.method private a(FF)Landroid/graphics/Point;
    .locals 1

    float-to-int p1, p1

    float-to-int p2, p2

    :try_start_0
    sget v0, Lchat/ola/vn/game/caro/d;->a:I

    rem-int v0, p1, v0

    sub-int/2addr p1, v0

    sget v0, Lchat/ola/vn/game/caro/d;->a:I

    rem-int v0, p2, v0

    sub-int/2addr p2, v0

    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0, p1, p2}, Landroid/graphics/Point;-><init>(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private a(Landroid/graphics/Canvas;)V
    .locals 6

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/game/caro/d;->t:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    if-eqz v0, :cond_0

    new-instance v0, Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iget v1, v1, Landroid/graphics/Point;->x:I

    add-int/lit8 v1, v1, 0x4

    iget-object v2, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iget v2, v2, Landroid/graphics/Point;->y:I

    add-int/lit8 v2, v2, 0x4

    iget-object v3, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iget v3, v3, Landroid/graphics/Point;->x:I

    sget v4, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, -0x4

    iget-object v4, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iget v4, v4, Landroid/graphics/Point;->y:I

    sget v5, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v4, v5

    add-int/lit8 v4, v4, -0x4

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v1, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method private a(Landroid/graphics/Point;Landroid/graphics/Canvas;)V
    .locals 8

    :try_start_0
    sget v0, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v0, v0, 0x5

    iget v1, p1, Landroid/graphics/Point;->x:I

    add-int/2addr v1, v0

    int-to-float v3, v1

    iget v1, p1, Landroid/graphics/Point;->y:I

    add-int/2addr v1, v0

    int-to-float v4, v1

    iget v1, p1, Landroid/graphics/Point;->x:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v1, v2

    sub-int/2addr v1, v0

    int-to-float v5, v1

    iget v1, p1, Landroid/graphics/Point;->y:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v1, v2

    sub-int/2addr v1, v0

    int-to-float v6, v1

    iget-object v7, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    move-object v2, p2

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    iget v1, p1, Landroid/graphics/Point;->x:I

    add-int/2addr v1, v0

    int-to-float v3, v1

    iget v1, p1, Landroid/graphics/Point;->y:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v1, v2

    sub-int/2addr v1, v0

    int-to-float v4, v1

    iget v1, p1, Landroid/graphics/Point;->x:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    add-int/2addr v1, v2

    sub-int/2addr v1, v0

    int-to-float v5, v1

    iget p1, p1, Landroid/graphics/Point;->y:I

    add-int/2addr p1, v0

    int-to-float v6, p1

    iget-object v7, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    move-object v2, p2

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Landroid/graphics/Point;Ljava/util/List;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Point;",
            "Ljava/util/List<",
            "Landroid/graphics/Point;",
            ">;)Z"
        }
    .end annotation

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    :try_start_0
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Point;

    iget v1, v0, Landroid/graphics/Point;->x:I

    iget v2, p1, Landroid/graphics/Point;->x:I

    if-ne v1, v2, :cond_0

    iget v0, v0, Landroid/graphics/Point;->y:I

    iget v1, p1, Landroid/graphics/Point;->y:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-ne v0, v1, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method static synthetic b()I
    .locals 1

    sget v0, Lchat/ola/vn/game/caro/d;->m:I

    return v0
.end method

.method private b(Landroid/graphics/Canvas;)V
    .locals 7

    iget-boolean v0, p0, Lchat/ola/vn/game/caro/d;->y:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->z:Landroid/graphics/Point;

    iget v0, v0, Landroid/graphics/Point;->x:I

    int-to-float v2, v0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->z:Landroid/graphics/Point;

    iget v0, v0, Landroid/graphics/Point;->y:I

    int-to-float v3, v0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->A:Landroid/graphics/Point;

    iget v0, v0, Landroid/graphics/Point;->x:I

    int-to-float v4, v0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->A:Landroid/graphics/Point;

    iget v0, v0, Landroid/graphics/Point;->y:I

    int-to-float v5, v0

    iget-object v6, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    move-object v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    :cond_0
    return-void
.end method

.method private b(Landroid/graphics/Point;Landroid/graphics/Canvas;)V
    .locals 3

    :try_start_0
    iget v0, p1, Landroid/graphics/Point;->x:I

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v1, v1, 0x2

    add-int/2addr v0, v1

    int-to-float v0, v0

    iget p1, p1, Landroid/graphics/Point;->y:I

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p1, v1

    int-to-float p1, p1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    int-to-float v1, v1

    const/high16 v2, 0x40400000    # 3.0f

    div-float/2addr v1, v2

    iget-object v2, p0, Lchat/ola/vn/game/caro/d;->d:Landroid/graphics/Paint;

    invoke-virtual {p2, v0, p1, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private b(Landroid/graphics/Point;)Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;Ljava/util/List;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;Ljava/util/List;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method static synthetic c()I
    .locals 1

    sget v0, Lchat/ola/vn/game/caro/d;->j:I

    return v0
.end method

.method private c(Landroid/graphics/Canvas;)V
    .locals 9

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    :try_start_0
    iget v2, p0, Lchat/ola/vn/game/caro/d;->r:I

    if-gt v1, v2, :cond_0

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v2, v2, v1

    int-to-float v4, v2

    const/4 v5, 0x0

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v2, v2, v1

    int-to-float v6, v2

    invoke-virtual {p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v2

    int-to-float v7, v2

    iget-object v8, p0, Lchat/ola/vn/game/caro/d;->b:Landroid/graphics/Paint;

    move-object v3, p1

    invoke-virtual/range {v3 .. v8}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    iget v1, p0, Lchat/ola/vn/game/caro/d;->q:I

    if-gt v0, v1, :cond_1

    const/4 v3, 0x0

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v1, v1, v0

    int-to-float v4, v1

    invoke-virtual {p1}, Landroid/graphics/Canvas;->getWidth()I

    move-result v1

    int-to-float v5, v1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v1, v1, v0

    int-to-float v6, v1

    iget-object v7, p0, Lchat/ola/vn/game/caro/d;->b:Landroid/graphics/Paint;

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private d()V
    .locals 7

    invoke-direct {p0}, Lchat/ola/vn/game/caro/d;->e()V

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    sget v0, Lchat/ola/vn/game/caro/d;->j:I

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->setBackgroundColor(I)V

    new-instance v0, Lchat/ola/vn/game/caro/d$1;

    sget-wide v3, Lchat/ola/vn/game/caro/d;->o:J

    sget-wide v5, Lchat/ola/vn/game/caro/d;->p:J

    move-object v1, v0

    move-object v2, p0

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/game/caro/d$1;-><init>(Lchat/ola/vn/game/caro/d;JJ)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->w:Landroid/os/CountDownTimer;

    return-void
.end method

.method private d(Landroid/graphics/Canvas;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Point;

    invoke-direct {p0, v1, p1}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;Landroid/graphics/Canvas;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method private e()V
    .locals 3

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->b:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->b:Landroid/graphics/Paint;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->b:Landroid/graphics/Paint;

    const v2, -0xbbbbbc

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->i:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->c:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->k:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->d:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->d:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->i:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->d:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->d:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->l:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->i:I

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->e:Landroid/graphics/Paint;

    sget v2, Lchat/ola/vn/game/caro/d;->m:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v1, v1, 0x2

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL_AND_STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->f:Landroid/graphics/Paint;

    sget v1, Lchat/ola/vn/game/caro/d;->n:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    return-void
.end method

.method private e(Landroid/graphics/Canvas;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Point;

    invoke-direct {p0, v1, p1}, Lchat/ola/vn/game/caro/d;->b(Landroid/graphics/Point;Landroid/graphics/Canvas;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(II)Landroid/graphics/Point;
    .locals 2

    :try_start_0
    new-instance v0, Landroid/graphics/Point;

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int p2, p2, v1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p2, v1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int p1, p1, v1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    div-int/lit8 v1, v1, 0x2

    add-int/2addr p1, v1

    invoke-direct {v0, p2, p1}, Landroid/graphics/Point;-><init>(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->z:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->A:Landroid/graphics/Point;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/game/caro/d;->y:Z

    return-void
.end method

.method public a(IIII)V
    .locals 0

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/game/caro/d;->a(II)Landroid/graphics/Point;

    move-result-object p1

    invoke-virtual {p0, p3, p4}, Lchat/ola/vn/game/caro/d;->a(II)Landroid/graphics/Point;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;Landroid/graphics/Point;)V

    return-void
.end method

.method public a(Landroid/graphics/Point;)V
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    invoke-virtual {p0}, Lchat/ola/vn/game/caro/d;->invalidate()V

    return-void

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    if-nez v0, :cond_1

    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0, p1}, Landroid/graphics/Point;-><init>(Landroid/graphics/Point;)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->s:Landroid/graphics/Point;

    iget v1, p1, Landroid/graphics/Point;->x:I

    iget p1, p1, Landroid/graphics/Point;->y:I

    invoke-virtual {v0, v1, p1}, Landroid/graphics/Point;->set(II)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->w:Landroid/os/CountDownTimer;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->w:Landroid/os/CountDownTimer;

    invoke-virtual {p1}, Landroid/os/CountDownTimer;->cancel()V

    iget-boolean p1, p0, Lchat/ola/vn/game/caro/d;->t:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->w:Landroid/os/CountDownTimer;

    invoke-virtual {p1}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method public a(Landroid/graphics/Point;Landroid/graphics/Point;)V
    .locals 1

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0, p1}, Landroid/graphics/Point;-><init>(Landroid/graphics/Point;)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->z:Landroid/graphics/Point;

    new-instance p1, Landroid/graphics/Point;

    invoke-direct {p1, p2}, Landroid/graphics/Point;-><init>(Landroid/graphics/Point;)V

    iput-object p1, p0, Lchat/ola/vn/game/caro/d;->A:Landroid/graphics/Point;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->y:Z

    invoke-virtual {p0}, Lchat/ola/vn/game/caro/d;->invalidate()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/game/caro/a;)V
    .locals 4

    if-eqz p1, :cond_3

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/game/caro/d;->b(Lchat/ola/vn/game/caro/a;)Landroid/graphics/Point;

    move-result-object v0

    iget-short v1, p1, Lchat/ola/vn/game/caro/a;->e:S

    sget-short v2, Lchat/ola/vn/game/caro/a;->a:S

    const/4 v3, 0x0

    if-ne v1, v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1, v3}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    :goto_0
    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Point;)V

    return-void

    :cond_1
    iget-short p1, p1, Lchat/ola/vn/game/caro/a;->e:S

    sget-short v1, Lchat/ola/vn/game/caro/a;->b:S

    if-ne p1, v1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    if-nez p1, :cond_2

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1, v3}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_3
    return-void
.end method

.method public b(Lchat/ola/vn/game/caro/a;)Landroid/graphics/Point;
    .locals 3

    if-eqz p1, :cond_0

    :try_start_0
    new-instance v0, Landroid/graphics/Point;

    iget v1, p1, Lchat/ola/vn/game/caro/a;->d:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int v1, v1, v2

    iget p1, p1, Lchat/ola/vn/game/caro/a;->c:I

    sget v2, Lchat/ola/vn/game/caro/d;->a:I

    mul-int p1, p1, v2

    invoke-direct {v0, v1, p1}, Landroid/graphics/Point;-><init>(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(II)Z
    .locals 1

    :try_start_0
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->getLocalVisibleRect(Landroid/graphics/Rect;)Z

    invoke-virtual {v0, p1, p2}, Landroid/graphics/Rect;->contains(II)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public c(II)V
    .locals 2

    if-ltz p1, :cond_0

    if-ltz p2, :cond_0

    :try_start_0
    iput p1, p0, Lchat/ola/vn/game/caro/d;->q:I

    iput p2, p0, Lchat/ola/vn/game/caro/d;->r:I

    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int p2, p2, v1

    sget v1, Lchat/ola/vn/game/caro/d;->a:I

    mul-int p1, p1, v1

    invoke-direct {v0, p2, p1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0}, Lchat/ola/vn/game/caro/d;->requestLayout()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public draw(Landroid/graphics/Canvas;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/view/View;->draw(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->c(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->a(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->d(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->e(Landroid/graphics/Canvas;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->b(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public getCaroViewListener()Lchat/ola/vn/game/caro/d$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->x:Lchat/ola/vn/game/caro/d$a;

    return-object v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/game/caro/d;->v:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->x:F

    sub-float/2addr v0, v1

    float-to-double v0, v0

    const-wide/high16 v3, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1, v3, v4}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iget-object v5, p0, Lchat/ola/vn/game/caro/d;->v:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->y:F

    sub-float/2addr p1, v5

    float-to-double v5, p1

    invoke-static {v5, v6, v3, v4}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v3

    add-double/2addr v0, v3

    const-wide/high16 v3, 0x3fe0000000000000L    # 0.5

    invoke-static {v0, v1, v3, v4}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    double-to-float p1, v0

    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float p1, p1, v0

    if-lez p1, :cond_0

    iput-boolean v2, p0, Lchat/ola/vn/game/caro/d;->u:Z

    :cond_0
    return v2

    :pswitch_2
    iget-boolean v0, p0, Lchat/ola/vn/game/caro/d;->u:Z

    if-nez v0, :cond_2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/game/caro/d;->a(FF)Landroid/graphics/Point;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-direct {p0, p1}, Lchat/ola/vn/game/caro/d;->b(Landroid/graphics/Point;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->x:Lchat/ola/vn/game/caro/d$a;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->x:Lchat/ola/vn/game/caro/d$a;

    iget v3, p1, Landroid/graphics/Point;->y:I

    sget v4, Lchat/ola/vn/game/caro/d;->a:I

    div-int/2addr v3, v4

    iget p1, p1, Landroid/graphics/Point;->x:I

    sget v4, Lchat/ola/vn/game/caro/d;->a:I

    div-int/2addr p1, v4

    invoke-interface {v0, v3, p1}, Lchat/ola/vn/game/caro/d$a;->a(II)V

    :cond_1
    iput-boolean v1, p0, Lchat/ola/vn/game/caro/d;->u:Z

    :cond_2
    return v2

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->v:Landroid/graphics/PointF;

    if-nez v0, :cond_3

    new-instance v0, Landroid/graphics/PointF;

    invoke-direct {v0}, Landroid/graphics/PointF;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->v:Landroid/graphics/PointF;

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->v:Landroid/graphics/PointF;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v3

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    invoke-virtual {v0, v3, p1}, Landroid/graphics/PointF;->set(FF)V

    iput-boolean v1, p0, Lchat/ola/vn/game/caro/d;->u:Z

    return v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public setCaroViewListener(Lchat/ola/vn/game/caro/d$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/d;->x:Lchat/ola/vn/game/caro/d$a;

    return-void
.end method

.method public setDrawBackgroundLastPoint(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/d;->t:Z

    return-void
.end method

.method public setOList(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/game/caro/a;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/game/caro/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->b(Lchat/ola/vn/game/caro/a;)Landroid/graphics/Point;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/game/caro/d;->h:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method public setXList(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/game/caro/a;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/game/caro/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/game/caro/d;->b(Lchat/ola/vn/game/caro/a;)Landroid/graphics/Point;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/game/caro/d;->g:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method
