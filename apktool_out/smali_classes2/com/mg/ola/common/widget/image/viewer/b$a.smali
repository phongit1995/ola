.class Lcom/mg/ola/common/widget/image/viewer/b$a;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/image/viewer/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/image/viewer/b;

.field private final b:F

.field private final c:F

.field private final d:F

.field private final e:F


# direct methods
.method public constructor <init>(Lcom/mg/ola/common/widget/image/viewer/b;FFFF)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p3, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->d:F

    iput p4, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->b:F

    iput p5, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->c:F

    cmpg-float p1, p2, p3

    if-gez p1, :cond_0

    const p1, 0x3f88f5c3    # 1.07f

    :goto_0
    iput p1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->e:F

    return-void

    :cond_0
    const p1, 0x3f6e147b    # 0.93f

    goto :goto_0

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->c()Landroid/widget/ImageView;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;

    move-result-object v1

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->e:F

    iget v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->e:F

    iget v4, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->b:F

    iget v5, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->c:F

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/graphics/Matrix;->postScale(FFFF)Z

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Lcom/mg/ola/common/widget/image/viewer/b;)V

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->g()F

    move-result v1

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->e:F

    const/high16 v3, 0x3f800000    # 1.0f

    cmpl-float v2, v2, v3

    if-lez v2, :cond_0

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->d:F

    cmpg-float v2, v1, v2

    if-ltz v2, :cond_1

    :cond_0
    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->e:F

    cmpg-float v2, v2, v3

    if-gez v2, :cond_2

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->d:F

    cmpg-float v2, v2, v1

    if-gez v2, :cond_2

    :cond_1
    invoke-static {v0, p0}, Lcom/mg/ola/common/widget/image/viewer/a;->a(Landroid/view/View;Ljava/lang/Runnable;)V

    return-void

    :cond_2
    iget v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->d:F

    div-float/2addr v0, v1

    iget-object v1, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/image/viewer/b;->b(Lcom/mg/ola/common/widget/image/viewer/b;)Landroid/graphics/Matrix;

    move-result-object v1

    iget v2, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->b:F

    iget v3, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->c:F

    invoke-virtual {v1, v0, v0, v2, v3}, Landroid/graphics/Matrix;->postScale(FFFF)Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/b$a;->a:Lcom/mg/ola/common/widget/image/viewer/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/image/viewer/b;->c(Lcom/mg/ola/common/widget/image/viewer/b;)V

    :cond_3
    return-void
.end method
