.class Lchat/ola/vn/entry/b/ab$4$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ab$4;->c(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab$4;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ab$4;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ab$4$1;->a:Lchat/ola/vn/entry/b/ab$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab$4$1;->a:Lchat/ola/vn/entry/b/ab$4;

    iget-object v0, v0, Lchat/ola/vn/entry/b/ab$4;->a:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab$4$1;->a:Lchat/ola/vn/entry/b/ab$4;

    iget-object v0, v0, Lchat/ola/vn/entry/b/ab$4;->c:Lchat/ola/vn/entry/b/ab;

    invoke-static {v0}, Lchat/ola/vn/entry/b/ab;->a(Lchat/ola/vn/entry/b/ab;)Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object v0

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab$4$1;->a:Lchat/ola/vn/entry/b/ab$4;

    iget-object v0, v0, Lchat/ola/vn/entry/b/ab$4;->c:Lchat/ola/vn/entry/b/ab;

    invoke-static {v0}, Lchat/ola/vn/entry/b/ab;->a(Lchat/ola/vn/entry/b/ab;)Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab$4$1;->a:Lchat/ola/vn/entry/b/ab$4;

    iget-object v1, v1, Lchat/ola/vn/entry/b/ab$4;->a:Ljava/lang/String;

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
