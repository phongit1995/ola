.class Lchat/ola/vn/c/k$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/k;->e(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/k;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/k;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    invoke-static {v0, p1}, Lchat/ola/vn/c/k;->a(Lchat/ola/vn/c/k;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    iget-object v0, v0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setCachingId(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/c/k$1;->a:Lchat/ola/vn/c/k;

    invoke-static {v0, p1}, Lchat/ola/vn/c/k;->a(Lchat/ola/vn/c/k;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
