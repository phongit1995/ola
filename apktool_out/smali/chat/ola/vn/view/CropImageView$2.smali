.class Lchat/ola/vn/view/CropImageView$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/CropImageView;->c(Lchat/ola/vn/view/HighlightView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/HighlightView;

.field final synthetic b:Lchat/ola/vn/view/CropImageView;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/CropImageView;Lchat/ola/vn/view/HighlightView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/CropImageView$2;->b:Lchat/ola/vn/view/CropImageView;

    iput-object p2, p0, Lchat/ola/vn/view/CropImageView$2;->a:Lchat/ola/vn/view/HighlightView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/CropImageView$2;->b:Lchat/ola/vn/view/CropImageView;

    iget-object v1, p0, Lchat/ola/vn/view/CropImageView$2;->a:Lchat/ola/vn/view/HighlightView;

    invoke-static {v0, v1}, Lchat/ola/vn/view/CropImageView;->a(Lchat/ola/vn/view/CropImageView;Lchat/ola/vn/view/HighlightView;)V

    return-void
.end method
