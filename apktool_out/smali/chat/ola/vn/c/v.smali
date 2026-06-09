.class public Lchat/ola/vn/c/v;
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

.field private e:Z

.field private f:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IZ)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x64

    iput v0, p0, Lchat/ola/vn/c/v;->a:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/c/v;->d:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/c/v;->e:Z

    iput-boolean v0, p0, Lchat/ola/vn/c/v;->f:Z

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    if-eqz p3, :cond_0

    new-instance p2, Ljava/lang/ref/WeakReference;

    invoke-direct {p2, p3}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p2, p0, Lchat/ola/vn/c/v;->c:Ljava/lang/ref/WeakReference;

    :cond_0
    iput-boolean p5, p0, Lchat/ola/vn/c/v;->e:Z

    iput-object p1, p0, Lchat/ola/vn/c/v;->d:Ljava/lang/String;

    iput p4, p0, Lchat/ola/vn/c/v;->a:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/v;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/v;->b(Z)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/v;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/c/v;->e:Z

    return p0
.end method

.method private b(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/v;->c:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/v;->c:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/v;->c:Ljava/lang/ref/WeakReference;

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

.method static synthetic b(Lchat/ola/vn/c/v;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/c/v;->f:Z

    return p0
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-boolean p1, p0, Lchat/ola/vn/c/v;->f:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/c/v;->d:Ljava/lang/String;

    iget-boolean v1, p0, Lchat/ola/vn/c/v;->e:Z

    invoke-static {v0, p1, v1}, Lchat/ola/vn/c/t;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;Z)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/c/v;->d:Ljava/lang/String;

    iget v0, p0, Lchat/ola/vn/c/v;->a:I

    invoke-static {p1, v0}, Lchat/ola/vn/c/f;->e(Ljava/lang/String;I)Lchat/ola/vn/c/f;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/c/v$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/c/v$1;-><init>(Lchat/ola/vn/c/v;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance v0, Lchat/ola/vn/c/e;

    invoke-direct {v0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v1, 0x1

    new-array v1, v1, [Lchat/ola/vn/c/f;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/c/v;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz v1, :cond_3

    :try_start_1
    iget-boolean v1, p0, Lchat/ola/vn/c/v;->e:Z

    if-eqz v1, :cond_0

    invoke-static {p2}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1

    goto :goto_0

    :cond_0
    iget-boolean v1, p0, Lchat/ola/vn/c/v;->f:Z

    if-eqz v1, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, p2}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p2

    if-eqz p2, :cond_2

    const p2, 0x3f59999a    # 0.85f

    invoke-virtual {v0, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setAlpha(F)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_0
    :cond_1
    move-object v1, p2

    :catch_1
    :cond_2
    :goto_0
    :try_start_3
    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/v;->b(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_3
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/c/v;->f:Z

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

.method public final e(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public final e(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

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
