.class Lchat/ola/vn/view/CropImageView$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/CropImageView;->onDraw(Landroid/graphics/Canvas;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/CropImageView;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/CropImageView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/CropImageView$3;->a:Lchat/ola/vn/view/CropImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView$3;->a:Lchat/ola/vn/view/CropImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/CropImageView;->isHardwareAccelerated()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView$3;->a:Lchat/ola/vn/view/CropImageView;

    const/4 v2, 0x2

    :goto_0
    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/view/CropImageView;->setLayerType(ILandroid/graphics/Paint;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/CropImageView$3;->a:Lchat/ola/vn/view/CropImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    goto :goto_0

    :catch_0
    return-void
.end method
