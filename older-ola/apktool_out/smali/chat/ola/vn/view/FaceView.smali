.class public Lchat/ola/vn/view/FaceView;
.super Landroid/view/View;


# instance fields
.field private final a:Ljava/lang/String;

.field private final b:Z

.field private c:I

.field private d:I

.field private e:Z

.field private f:Z

.field private g:Landroid/graphics/Matrix;

.field private h:Landroid/graphics/RectF;

.field private i:[Lchat/ola/vn/util/a/b;

.field private j:Landroid/graphics/drawable/Drawable;

.field private final k:Landroid/graphics/drawable/Drawable;

.field private final l:Landroid/graphics/drawable/Drawable;

.field private final m:Landroid/graphics/drawable/Drawable;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-string p1, "FaceView"

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->a:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/FaceView;->b:Z

    new-instance p1, Landroid/graphics/Matrix;

    invoke-direct {p1}, Landroid/graphics/Matrix;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->g:Landroid/graphics/Matrix;

    new-instance p1, Landroid/graphics/RectF;

    invoke-direct {p1}, Landroid/graphics/RectF;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f0806c6

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->k:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f0806c3

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->l:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f0806c4

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->m:Landroid/graphics/drawable/Drawable;

    iget-object p1, p0, Lchat/ola/vn/view/FaceView;->k:Landroid/graphics/drawable/Drawable;

    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->j:Landroid/graphics/drawable/Drawable;

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    array-length v0, v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/FaceView;->g:Landroid/graphics/Matrix;

    iget-boolean v1, p0, Lchat/ola/vn/view/FaceView;->e:Z

    iget v2, p0, Lchat/ola/vn/view/FaceView;->c:I

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->getHeight()I

    move-result v4

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/util/a/a;->a(Landroid/graphics/Matrix;ZIII)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    iget-object v0, p0, Lchat/ola/vn/view/FaceView;->g:Landroid/graphics/Matrix;

    iget v1, p0, Lchat/ola/vn/view/FaceView;->d:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->postRotate(F)Z

    iget v0, p0, Lchat/ola/vn/view/FaceView;->d:I

    neg-int v0, v0

    int-to-float v0, v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->rotate(F)V

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    iget-object v2, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    aget-object v2, v2, v0

    iget-object v2, v2, Lchat/ola/vn/util/a/b;->a:Landroid/graphics/Rect;

    invoke-virtual {v1, v2}, Landroid/graphics/RectF;->set(Landroid/graphics/Rect;)V

    iget-object v1, p0, Lchat/ola/vn/view/FaceView;->g:Landroid/graphics/Matrix;

    iget-object v2, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    invoke-virtual {v1, v2}, Landroid/graphics/Matrix;->mapRect(Landroid/graphics/RectF;)Z

    iget-object v1, p0, Lchat/ola/vn/view/FaceView;->j:Landroid/graphics/drawable/Drawable;

    iget-object v2, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->left:F

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iget-object v3, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->top:F

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    iget-object v4, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->right:F

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    iget-object v5, p0, Lchat/ola/vn/view/FaceView;->h:Landroid/graphics/RectF;

    iget v5, v5, Landroid/graphics/RectF;->bottom:F

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    iget-object v1, p0, Lchat/ola/vn/view/FaceView;->j:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    :cond_1
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public setDisplayOrientation(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/FaceView;->c:I

    return-void
.end method

.method public setFaces([Landroid/hardware/Camera$Face;)V
    .locals 5

    iget-boolean v0, p0, Lchat/ola/vn/view/FaceView;->f:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    array-length v0, p1

    new-array v0, v0, [Lchat/ola/vn/util/a/b;

    iput-object v0, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    const/4 v0, 0x0

    array-length v1, p1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    new-instance v3, Lchat/ola/vn/util/a/b;

    aget-object v4, p1, v0

    invoke-direct {v3, v4}, Lchat/ola/vn/util/a/b;-><init>(Landroid/hardware/Camera$Face;)V

    aput-object v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->invalidate()V

    return-void
.end method

.method public setFaces([Lchat/ola/vn/util/a/b;)V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/FaceView;->f:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/view/FaceView;->i:[Lchat/ola/vn/util/a/b;

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->invalidate()V

    return-void
.end method

.method public setMirror(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/FaceView;->e:Z

    return-void
.end method

.method public setOrientation(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/FaceView;->d:I

    invoke-virtual {p0}, Lchat/ola/vn/view/FaceView;->invalidate()V

    return-void
.end method
