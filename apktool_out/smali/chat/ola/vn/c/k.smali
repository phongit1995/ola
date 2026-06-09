.class public Lchat/ola/vn/c/k;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/w;


# instance fields
.field protected a:I

.field b:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/view/OlaCachedImageView;",
            ">;"
        }
    .end annotation
.end field

.field c:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x64

    iput v0, p0, Lchat/ola/vn/c/k;->a:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/c/k;->d:Ljava/lang/String;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    if-eqz p3, :cond_0

    new-instance p2, Ljava/lang/ref/WeakReference;

    invoke-direct {p2, p3}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p2, p0, Lchat/ola/vn/c/k;->c:Ljava/lang/ref/WeakReference;

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/c/k;->d:Ljava/lang/String;

    iput p4, p0, Lchat/ola/vn/c/k;->a:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/k;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/k;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/k;->c:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/k;->c:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/k;->c:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/16 p1, 0x8

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final a(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method

.method public final b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final b(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method

.method public final c(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final c(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method

.method public final d(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final d(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget v1, Lchat/ola/vn/f;->K:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/c/k;->d:Ljava/lang/String;

    iget v1, p0, Lchat/ola/vn/c/k;->a:I

    invoke-static {v0, v1}, Lchat/ola/vn/c/f;->i(Ljava/lang/String;I)Lchat/ola/vn/c/f;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/f;->j(Ljava/lang/String;)V

    new-instance p1, Lchat/ola/vn/c/k$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/k$1;-><init>(Lchat/ola/vn/c/k;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance p1, Lchat/ola/vn/c/e;

    invoke-direct {p1}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v1, 0x1

    new-array v1, v1, [Lchat/ola/vn/c/f;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    invoke-virtual {p1, v1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public e(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/k;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/c/k;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public final f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final f(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    return-void
.end method
