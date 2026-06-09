.class Lchat/ola/vn/c/n$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/n;->c(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/n;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    iget-object v0, v0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    iget-object v0, v0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    iget-object v0, v0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->g()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    invoke-static {v1}, Lchat/ola/vn/c/n;->a(Lchat/ola/vn/c/n;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p1, v1

    :catch_0
    :cond_0
    :try_start_2
    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/c/n$1;->a:Lchat/ola/vn/c/n;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/c/n;->a(Lchat/ola/vn/c/n;Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
