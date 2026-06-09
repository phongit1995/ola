.class Lchat/ola/vn/entry/b/u$2;
.super Lchat/ola/vn/c/i;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/u;->g()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/f;

.field final synthetic b:Lchat/ola/vn/entry/b/u;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/u;Lchat/ola/vn/c/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    iput-object p2, p0, Lchat/ola/vn/entry/b/u$2;->a:Lchat/ola/vn/c/f;

    invoke-direct {p0}, Lchat/ola/vn/c/i;-><init>()V

    return-void
.end method


# virtual methods
.method public c(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {v0}, Lchat/ola/vn/entry/b/u;->b(Lchat/ola/vn/entry/b/u;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/u$2;->a:Lchat/ola/vn/c/f;

    new-instance v0, Lchat/ola/vn/entry/b/u$2$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/u$2$1;-><init>(Lchat/ola/vn/entry/b/u$2;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance p1, Lchat/ola/vn/c/e;

    invoke-direct {p1}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v0, 0x1

    new-array v0, v0, [Lchat/ola/vn/c/f;

    const/4 v1, 0x0

    iget-object v2, p0, Lchat/ola/vn/entry/b/u$2;->a:Lchat/ola/vn/c/f;

    aput-object v2, v0, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {v0}, Lchat/ola/vn/entry/b/u;->b(Lchat/ola/vn/entry/b/u;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {v0}, Lchat/ola/vn/entry/b/u;->c(Lchat/ola/vn/entry/b/u;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {v0}, Lchat/ola/vn/entry/b/u;->d(Lchat/ola/vn/entry/b/u;)Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object v0

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u$2;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {v0}, Lchat/ola/vn/entry/b/u;->d(Lchat/ola/vn/entry/b/u;)Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object v0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
