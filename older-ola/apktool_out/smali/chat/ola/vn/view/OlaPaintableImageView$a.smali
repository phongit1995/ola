.class Lchat/ola/vn/view/OlaPaintableImageView$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/OlaPaintableImageView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field public a:Landroid/graphics/Path;

.field public b:Landroid/graphics/Paint;

.field final synthetic c:Lchat/ola/vn/view/OlaPaintableImageView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/OlaPaintableImageView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView$a;->c:Lchat/ola/vn/view/OlaPaintableImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p1, Landroid/graphics/Path;

    invoke-direct {p1}, Landroid/graphics/Path;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView$a;->a:Landroid/graphics/Path;

    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/OlaPaintableImageView$a;->b:Landroid/graphics/Paint;

    return-void
.end method
