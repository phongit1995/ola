.class Lchat/ola/vn/c/v$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/v;->a(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/v;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    iget-object v0, v0, Lchat/ola/vn/c/v;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    iget-object v0, v0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    iget-object v0, v0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    iget-object v0, v0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    invoke-static {v2}, Lchat/ola/vn/c/v;->a(Lchat/ola/vn/c/v;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {v1}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v2

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    invoke-static {v2}, Lchat/ola/vn/c/v;->b(Lchat/ola/vn/c/v;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v1}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    if-eqz v1, :cond_2

    const v1, 0x3f59999a    # 0.85f

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setAlpha(F)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_0
    :cond_1
    move-object v2, v1

    :catch_1
    :cond_2
    :goto_0
    :try_start_3
    invoke-virtual {p1}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/c/v$1;->a:Lchat/ola/vn/c/v;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/c/v;->a(Lchat/ola/vn/c/v;Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_3
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
