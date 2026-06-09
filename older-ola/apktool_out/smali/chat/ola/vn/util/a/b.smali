.class public Lchat/ola/vn/util/a/b;
.super Ljava/lang/Object;


# instance fields
.field public a:Landroid/graphics/Rect;

.field public b:I

.field public c:I

.field public d:Landroid/graphics/Point;

.field public e:Landroid/graphics/Point;

.field public f:Landroid/graphics/Point;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/util/a/b;->c:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->d:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->e:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->f:Landroid/graphics/Point;

    return-void
.end method

.method public constructor <init>(Landroid/hardware/Camera$Face;)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/util/a/b;->c:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->d:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->e:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->f:Landroid/graphics/Point;

    iget-object v0, p1, Landroid/hardware/Camera$Face;->rect:Landroid/graphics/Rect;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->a:Landroid/graphics/Rect;

    iget v0, p1, Landroid/hardware/Camera$Face;->id:I

    iput v0, p0, Lchat/ola/vn/util/a/b;->c:I

    iget-object v0, p1, Landroid/hardware/Camera$Face;->leftEye:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->d:Landroid/graphics/Point;

    iget-object v0, p1, Landroid/hardware/Camera$Face;->rightEye:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->e:Landroid/graphics/Point;

    iget-object v0, p1, Landroid/hardware/Camera$Face;->mouth:Landroid/graphics/Point;

    iput-object v0, p0, Lchat/ola/vn/util/a/b;->f:Landroid/graphics/Point;

    iget p1, p1, Landroid/hardware/Camera$Face;->score:I

    iput p1, p0, Lchat/ola/vn/util/a/b;->b:I

    return-void
.end method
