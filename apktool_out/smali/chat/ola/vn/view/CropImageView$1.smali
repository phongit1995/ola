.class Lchat/ola/vn/view/CropImageView$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/CropImageView;->a()V
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

    iput-object p1, p0, Lchat/ola/vn/view/CropImageView$1;->a:Lchat/ola/vn/view/CropImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView$1;->a:Lchat/ola/vn/view/CropImageView;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/CropImageView;->setLayerType(ILandroid/graphics/Paint;)V

    return-void
.end method
