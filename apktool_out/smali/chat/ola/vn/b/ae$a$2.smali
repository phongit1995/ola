.class Lchat/ola/vn/b/ae$a$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/ae$a;->a(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/ae$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/ae$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ae$a$2;->a:Lchat/ola/vn/b/ae$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ae$a$2;->a:Lchat/ola/vn/b/ae$a;

    iget-object v0, v0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/b/ae$a$2;->a:Lchat/ola/vn/b/ae$a;

    iget-object v0, v0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
