.class Lchat/ola/vn/c/s$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/s;->c(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/s;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    iget-object v0, v0, Lchat/ola/vn/c/s;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    iget-object v0, v0, Lchat/ola/vn/c/s;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    iget-object v0, v0, Lchat/ola/vn/c/s;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    invoke-static {v2}, Lchat/ola/vn/c/s;->a(Lchat/ola/vn/c/s;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {v1}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v1, v2

    :catch_0
    :cond_0
    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    invoke-static {v2}, Lchat/ola/vn/c/s;->b(Lchat/ola/vn/c/s;)Landroid/widget/ImageView$ScaleType;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setLoadingUrl(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/c/s;->a(Lchat/ola/vn/c/s;Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/c/s$1;->a:Lchat/ola/vn/c/s;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/c/s;->a(Lchat/ola/vn/c/s;Z)V

    return-void
.end method
