.class Lcom/mg/ola/common/widget/image/viewer/b$d;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/image/viewer/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/image/viewer/b;

.field private final b:Lcom/mg/ola/common/widget/image/viewer/d;

.field private c:I

.field private d:I


# direct methods
.method public constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p2}, Lcom/mg/ola/common/widget/image/viewer/d;->a(Landroid/content/Context;)Lcom/mg/ola/common/widget/image/viewer/d;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/image/viewer/d;->a(Z)V

    return-void
.end method

.method public a(IIII)V
    .locals 14

    move-object v0, p0

    iget-object v1, v0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b()Landroid/graphics/RectF;

    move-result-object v1

    if-nez v1, :cond_0

    return-void

    :cond_0
    iget v2, v1, Landroid/graphics/RectF;->left:F

    neg-float v2, v2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v4

    move v2, p1

    int-to-float v2, v2

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v3

    cmpg-float v3, v2, v3

    const/4 v5, 0x0

    if-gez v3, :cond_1

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v3

    sub-float/2addr v3, v2

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v2

    move v9, v2

    const/4 v8, 0x0

    goto :goto_0

    :cond_1
    move v8, v4

    move v9, v8

    :goto_0
    iget v2, v1, Landroid/graphics/RectF;->top:F

    neg-float v2, v2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    move/from16 v3, p2

    int-to-float v3, v3

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v6

    cmpg-float v6, v3, v6

    if-gez v6, :cond_2

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    sub-float/2addr v1, v3

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    move v11, v1

    const/4 v10, 0x0

    goto :goto_1

    :cond_2
    move v10, v2

    move v11, v10

    :goto_1
    iput v4, v0, Lcom/mg/ola/common/widget/image/viewer/b$d;->c:I

    iput v2, v0, Lcom/mg/ola/common/widget/image/viewer/b$d;->d:I

    if-ne v4, v9, :cond_3

    if-eq v2, v11, :cond_4

    :cond_3
    iget-object v3, v0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    const/4 v12, 0x0

    const/4 v13, 0x0

    move v5, v2

    move/from16 v6, p3

    move/from16 v7, p4

    invoke-virtual/range {v3 .. v13}, Lcom/mg/ola/common/widget/image/viewer/d;->a(IIIIIIIIII)V

    :cond_4
    return-void
.end method

.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/d;->a()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/d;->b()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->b:Lcom/mg/ola/common/widget/image/viewer/d;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/image/viewer/d;->c()I

    move-result v2

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v3}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;

    move-result-object v3

    iget v4, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->c:I

    sub-int/2addr v4, v1

    int-to-float v4, v4

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->d:I

    sub-int/2addr v5, v2

    int-to-float v5, v5

    invoke-virtual {v3, v4, v5}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    iget-object v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    iget-object v4, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v4}, Lcom/mg/ola/common/widget/image/viewer/b;->j()Landroid/graphics/Matrix;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/mg/ola/common/widget/image/viewer/b;->a(Lcom/mg/ola/common/widget/image/viewer/b;Landroid/graphics/Matrix;)V

    iput v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->c:I

    iput v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$d;->d:I

    invoke-static {v0, p0}, Lcom/mg/ola/common/widget/image/viewer/a;->a(Landroid/view/View;Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method
