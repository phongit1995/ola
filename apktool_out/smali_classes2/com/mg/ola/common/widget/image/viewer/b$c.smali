.class Lcom/mg/ola/common/widget/image/viewer/b$c;
.super Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/image/viewer/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/image/viewer/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-direct {p0}, Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;Lcom/mg/ola/common/widget/image/viewer/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/image/viewer/b$c;-><init>(Lcom/mg/ola/common/widget/image/viewer/b;)V

    return-void
.end method


# virtual methods
.method public onScale(Landroid/view/ScaleGestureDetector;)Z
    .locals 4

    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v1

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Landroid/widget/ImageView;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v1

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;)F

    move-result v3

    cmpg-float v1, v1, v3

    if-ltz v1, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;

    move-result-object v1

    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getFocusX()F

    move-result v3

    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getFocusY()F

    move-result p1

    invoke-virtual {v1, v0, v0, v3, p1}, Landroid/graphics/Matrix;->postScale(FFFF)Z

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Lcom/mg/ola/common/widget/image/viewer/b;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$c;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {p1, v2}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;Z)Z

    :cond_1
    return v2
.end method
