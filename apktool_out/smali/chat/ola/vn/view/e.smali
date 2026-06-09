.class public Lchat/ola/vn/view/e;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/hardware/Camera$PictureCallback;
.implements Landroid/view/TextureView$SurfaceTextureListener;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "NewApi"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/e$b;,
        Lchat/ola/vn/view/e$a;
    }
.end annotation


# instance fields
.field private a:Landroid/view/TextureView;

.field private b:Landroid/view/ViewStub;

.field private c:Landroid/hardware/Camera;

.field private d:I

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/view/View;

.field private h:Landroid/widget/ImageButton;

.field private i:Landroid/widget/ImageView;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/TextView;

.field private l:I

.field private m:I

.field private n:I

.field private o:I

.field private p:Lchat/ola/vn/view/e$a;

.field private q:Z

.field private r:Z

.field private s:Z

.field private t:Ljava/lang/Short;

.field private u:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/view/e;->q:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/view/e;->r:Z

    iput-boolean v0, p0, Lchat/ola/vn/view/e;->s:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/e;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Lchat/ola/vn/view/e;->q:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/view/e;->r:Z

    iput-boolean p2, p0, Lchat/ola/vn/view/e;->s:Z

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/e;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Lchat/ola/vn/view/e;->q:Z

    const/4 p3, 0x1

    iput-boolean p3, p0, Lchat/ola/vn/view/e;->r:Z

    iput-boolean p2, p0, Lchat/ola/vn/view/e;->s:Z

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/e;->a(Landroid/content/Context;)V

    return-void
.end method

.method private static a(Ljava/util/List;)Landroid/util/Pair;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/hardware/Camera$Size;",
            ">;)",
            "Landroid/util/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    const/4 v0, 0x0

    const/4 v1, 0x0

    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/hardware/Camera$Size;

    iget v3, v2, Landroid/hardware/Camera$Size;->width:I

    iget v4, v2, Landroid/hardware/Camera$Size;->height:I

    mul-int v3, v3, v4

    mul-int v4, v0, v1

    if-le v3, v4, :cond_0

    iget v0, v2, Landroid/hardware/Camera$Size;->width:I

    iget v1, v2, Landroid/hardware/Camera$Size;->height:I

    goto :goto_0

    :cond_1
    new-instance p0, Landroid/util/Pair;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/view/e;Landroid/view/TextureView;)Landroid/view/TextureView;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e;->a:Landroid/view/TextureView;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/view/e;Ljava/lang/Short;)Ljava/lang/Short;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    return-object p1
.end method

.method private a(II)V
    .locals 6

    int-to-float p1, p1

    int-to-float p2, p2

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v1

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v1

    if-eq v1, v2, :cond_2

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    const/4 v1, 0x3

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v3, 0x1

    :cond_2
    :goto_1
    iget v0, p0, Lchat/ola/vn/view/e;->l:I

    int-to-float v0, v0

    iget v1, p0, Lchat/ola/vn/view/e;->m:I

    int-to-float v1, v1

    if-eqz v3, :cond_3

    iget v0, p0, Lchat/ola/vn/view/e;->m:I

    int-to-float v0, v0

    iget v1, p0, Lchat/ola/vn/view/e;->l:I

    int-to-float v1, v1

    :cond_3
    cmpl-float v2, v0, p1

    const/high16 v3, 0x3f800000    # 1.0f

    if-ltz v2, :cond_4

    cmpl-float v2, v1, p2

    if-ltz v2, :cond_4

    div-float v3, v0, p1

    div-float v0, v1, p2

    goto :goto_2

    :cond_4
    cmpg-float v2, v0, p1

    if-gtz v2, :cond_5

    cmpg-float v2, v1, p2

    if-gtz v2, :cond_5

    div-float v3, p1, v0

    div-float v0, p2, v1

    move v5, v3

    move v3, v0

    move v0, v5

    goto :goto_2

    :cond_5
    cmpl-float v2, p1, v0

    if-ltz v2, :cond_6

    div-float v0, p1, v0

    div-float v1, p2, v1

    div-float/2addr v0, v1

    goto :goto_2

    :cond_6
    cmpl-float v2, p2, v1

    if-ltz v2, :cond_7

    div-float v1, p2, v1

    div-float v0, p1, v0

    div-float v0, v1, v0

    move v3, v0

    :cond_7
    const/high16 v0, 0x3f800000    # 1.0f

    :goto_2
    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr p1, v1

    float-to-int p1, p1

    div-float/2addr p2, v1

    float-to-int p2, p2

    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    int-to-float p1, p1

    int-to-float p2, p2

    invoke-virtual {v1, v3, v0, p1, p2}, Landroid/graphics/Matrix;->setScale(FFFF)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->a:Landroid/view/TextureView;

    invoke-virtual {p1, v1}, Landroid/view/TextureView;->setTransform(Landroid/graphics/Matrix;)V

    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 2

    const v0, 0x7f0b0131

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/e;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const p1, 0x7f090146

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/view/ViewStub;

    iput-object p1, p0, Lchat/ola/vn/view/e;->b:Landroid/view/ViewStub;

    const p1, 0x7f090204

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    const p1, 0x7f090462

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/e;->f:Landroid/widget/TextView;

    const p1, 0x7f090206

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageButton;

    iput-object p1, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    const p1, 0x7f0903bf

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/e;->g:Landroid/view/View;

    const p1, 0x7f0904af

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    const p1, 0x7f090473

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/e;->j:Landroid/view/View;

    const p1, 0x7f09048b

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/e;->k:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/e;->k:Landroid/widget/TextView;

    const-string v0, "\u221e"

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/e;->k:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    invoke-virtual {p1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    invoke-virtual {p1, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->f:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09048a

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/e;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/e;->u:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/e;->u:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->f:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Landroid/graphics/SurfaceTexture;II)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v0

    invoke-virtual {v0}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewSizes()Ljava/util/List;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/view/e;->a(Ljava/util/List;)Landroid/util/Pair;

    move-result-object v1

    iget-object v2, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object v3, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-virtual {v0, v2, v3}, Landroid/hardware/Camera$Parameters;->setPreviewSize(II)V

    iget-object v2, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iput v2, p0, Lchat/ola/vn/view/e;->l:I

    iget-object v1, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    iput v1, p0, Lchat/ola/vn/view/e;->m:I

    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v1, v0}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/view/e;->a(II)V

    iget-object p2, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {p2, p1}, Landroid/hardware/Camera;->setPreviewTexture(Landroid/graphics/SurfaceTexture;)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {p1}, Landroid/hardware/Camera;->startPreview()V

    iget-object p1, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->f:Landroid/widget/TextView;

    const/4 p3, 0x0

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    invoke-virtual {p1, p3}, Landroid/widget/ImageButton;->setVisibility(I)V

    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result p1

    const/4 v0, 0x1

    if-le p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, p3}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_0
    new-instance p1, Lchat/ola/vn/view/e$4;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/e$4;-><init>(Lchat/ola/vn/view/e;)V

    const-wide/16 p2, 0x1388

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/e;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/view/e;->f()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/e;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/e;->r:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/view/e;)Landroid/view/TextureView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->a:Landroid/view/TextureView;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/view/e;)Landroid/view/ViewStub;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->b:Landroid/view/ViewStub;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/view/e;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->j:Landroid/view/View;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/view/e;)Ljava/lang/Short;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->t:Ljava/lang/Short;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/view/e;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->k:Landroid/widget/TextView;

    return-object p0
.end method

.method private f()V
    .locals 4

    const v0, 0x7f0f0196

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    if-eqz v1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v1

    const/4 v2, 0x1

    iput v2, p0, Lchat/ola/vn/view/e;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget v2, p0, Lchat/ola/vn/view/e;->d:I

    invoke-static {v2}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    if-nez v2, :cond_2

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    :try_start_3
    invoke-static {v2}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    iget-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    if-eqz v3, :cond_1

    iput v2, p0, Lchat/ola/vn/view/e;->d:I
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/a/a;->a(Landroid/app/Activity;)I

    move-result v2

    iget v3, p0, Lchat/ola/vn/view/e;->d:I

    invoke-static {v2, v3}, Lchat/ola/vn/util/a/a;->a(II)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/hardware/Camera;->setDisplayOrientation(I)V

    return-void

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    return-void

    :catch_2
    move-exception v1

    iget-object v2, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/view/e;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->g:Landroid/view/View;

    return-object p0
.end method

.method private g()V
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const-string v1, "\u221e"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "3 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0646

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "4 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "5 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "6 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "7 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "8 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "9 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "10 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/view/e$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/e$3;-><init>(Lchat/ola/vn/view/e;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic h(Lchat/ola/vn/view/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/e;->n:I

    return p0
.end method

.method private h()V
    .locals 5

    iget-boolean v0, p0, Lchat/ola/vn/view/e;->s:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const v0, 0x7f0f0196

    :try_start_0
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v1

    const/4 v2, 0x1

    if-gt v1, v2, :cond_1

    return-void

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/view/e;->f:Landroid/widget/TextView;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    invoke-virtual {v3, v4}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/view/e;->i:Landroid/widget/ImageView;

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    iput-boolean v2, p0, Lchat/ola/vn/view/e;->s:Z

    iget-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->stopPreview()V

    iget-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->release()V

    const/4 v3, 0x0

    iput-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    iget v3, p0, Lchat/ola/vn/view/e;->d:I

    const/4 v4, 0x0

    if-ne v3, v2, :cond_2

    iput v4, p0, Lchat/ola/vn/view/e;->d:I

    goto :goto_0

    :cond_2
    iput v2, p0, Lchat/ola/vn/view/e;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :goto_0
    :try_start_1
    iget v2, p0, Lchat/ola/vn/view/e;->d:I

    invoke-static {v2}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    if-nez v2, :cond_4

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v1, :cond_4

    :try_start_3
    invoke-static {v2}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    iget-object v3, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    if-eqz v3, :cond_3

    iput v2, p0, Lchat/ola/vn/view/e;->d:I
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_2

    :catch_1
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_4
    :goto_2
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/a/a;->a(Landroid/app/Activity;)I

    move-result v2

    iget v3, p0, Lchat/ola/vn/view/e;->d:I

    invoke-static {v2, v3}, Lchat/ola/vn/util/a/a;->a(II)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/hardware/Camera;->setDisplayOrientation(I)V

    goto :goto_3

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    iget-object v1, p0, Lchat/ola/vn/view/e;->a:Landroid/view/TextureView;

    invoke-virtual {v1}, Landroid/view/TextureView;->getSurfaceTexture()Landroid/graphics/SurfaceTexture;

    move-result-object v1

    iget v2, p0, Lchat/ola/vn/view/e;->n:I

    iget v3, p0, Lchat/ola/vn/view/e;->o:I

    invoke-direct {p0, v1, v2, v3}, Lchat/ola/vn/view/e;->a(Landroid/graphics/SurfaceTexture;II)V

    iput-boolean v4, p0, Lchat/ola/vn/view/e;->s:Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    return-void

    :catch_2
    move-exception v1

    iget-object v2, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/view/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/e;->o:I

    return p0
.end method

.method static synthetic j(Lchat/ola/vn/view/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/e;->l:I

    return p0
.end method

.method static synthetic k(Lchat/ola/vn/view/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/e;->m:I

    return p0
.end method

.method static synthetic l(Lchat/ola/vn/view/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/e;->d:I

    return p0
.end method

.method static synthetic m(Lchat/ola/vn/view/e;)Lchat/ola/vn/view/e$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    return-object p0
.end method


# virtual methods
.method public b()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/e;->u:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public c()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/e;->q:Z

    return v0
.end method

.method public d()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    invoke-interface {v0}, Lchat/ola/vn/view/e$a;->J()Z

    move-result v0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lchat/ola/vn/view/e;->q:Z

    :cond_0
    return-void
.end method

.method public e()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/e;->h:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    invoke-interface {v0}, Lchat/ola/vn/view/e$a;->K()Z

    move-result v0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lchat/ola/vn/view/e;->q:Z

    :cond_0
    return-void
.end method

.method public getOlaCameraListener()Lchat/ola/vn/view/e$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090206

    if-eq p1, v0, :cond_5

    const v0, 0x7f090462

    if-eq p1, v0, :cond_2

    const v0, 0x7f09048a

    if-eq p1, v0, :cond_1

    const v0, 0x7f0904af

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/view/e;->h()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/view/e;->g()V

    return-void

    :cond_2
    iget-boolean p1, p0, Lchat/ola/vn/view/e;->r:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez p1, :cond_3

    return-void

    :cond_3
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/util/c/a;->w:Landroid/net/Uri;

    invoke-static {p1, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_4
    const/4 p1, 0x0

    :try_start_2
    iput-boolean p1, p0, Lchat/ola/vn/view/e;->r:Z

    iget-object v0, p0, Lchat/ola/vn/view/e;->j:Landroid/view/View;

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/view/View;->setAlpha(F)V

    iget-object v0, p0, Lchat/ola/vn/view/e;->j:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e;->j:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object p1

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/view/e$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/e$2;-><init>(Lchat/ola/vn/view/e;)V

    invoke-virtual {p1, v0}, Landroid/view/ViewPropertyAnimator;->setListener(Landroid/animation/Animator$AnimatorListener;)Landroid/view/ViewPropertyAnimator;

    iget-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0, p0}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V

    return-void

    :cond_5
    iget-boolean p1, p0, Lchat/ola/vn/view/e;->q:Z

    if-eqz p1, :cond_6

    invoke-virtual {p0}, Lchat/ola/vn/view/e;->e()V

    return-void

    :cond_6
    invoke-virtual {p0}, Lchat/ola/vn/view/e;->d()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090206

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    invoke-interface {p1}, Lchat/ola/vn/view/e$a;->I()Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public onPictureTaken([BLandroid/hardware/Camera;)V
    .locals 2

    :try_start_0
    new-instance p2, Lchat/ola/vn/view/e$b;

    const/4 v0, 0x0

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/view/e$b;-><init>(Lchat/ola/vn/view/e;Lchat/ola/vn/view/e$1;)V

    const/4 v0, 0x1

    new-array v0, v0, [[B

    const/4 v1, 0x0

    aput-object p1, v0, v1

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/e$b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {p1}, Landroid/hardware/Camera;->startPreview()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/view/d;->onSizeChanged(IIII)V

    new-instance p1, Lchat/ola/vn/view/e$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/e$1;-><init>(Lchat/ola/vn/view/e;)V

    const-wide/16 p2, 0x320

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method

.method public onSurfaceTextureAvailable(Landroid/graphics/SurfaceTexture;II)V
    .locals 0

    :try_start_0
    iput p2, p0, Lchat/ola/vn/view/e;->n:I

    iput p3, p0, Lchat/ola/vn/view/e;->o:I

    iget p2, p0, Lchat/ola/vn/view/e;->n:I

    iget p3, p0, Lchat/ola/vn/view/e;->o:I

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/e;->a(Landroid/graphics/SurfaceTexture;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object p2, p0, Lchat/ola/vn/view/e;->e:Landroid/widget/TextView;

    const p3, 0x7f0f0196

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onSurfaceTextureDestroyed(Landroid/graphics/SurfaceTexture;)Z
    .locals 2

    const/4 p1, 0x0

    :try_start_0
    const-string v0, "OlaChat"

    const-string v1, "********MAKE SURE RELEASE CAMERA************"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    iget-object v0, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x1

    iput-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    return v0

    :catchall_0
    move-exception v0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iput-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    const/4 p1, 0x0

    return p1

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/view/e;->c:Landroid/hardware/Camera;

    throw v0
.end method

.method public onSurfaceTextureSizeChanged(Landroid/graphics/SurfaceTexture;II)V
    .locals 0

    iput p2, p0, Lchat/ola/vn/view/e;->n:I

    iput p3, p0, Lchat/ola/vn/view/e;->o:I

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/view/e;->a(II)V

    return-void
.end method

.method public onSurfaceTextureUpdated(Landroid/graphics/SurfaceTexture;)V
    .locals 0

    return-void
.end method

.method public setOlaCameraListener(Lchat/ola/vn/view/e$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e;->p:Lchat/ola/vn/view/e$a;

    return-void
.end method
