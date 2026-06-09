.class public Lchat/ola/vn/c/p;
.super Lchat/ola/vn/c/c;


# instance fields
.field a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/view/OlaCachedImageView;",
            ">;"
        }
    .end annotation
.end field

.field private c:Ljava/lang/String;

.field private d:I

.field private e:Z


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Ljava/lang/String;IZ)V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/c/p;->d:I

    iput-boolean v0, p0, Lchat/ola/vn/c/p;->e:Z

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    iput-object p3, p0, Lchat/ola/vn/c/p;->c:Ljava/lang/String;

    if-eqz p2, :cond_0

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lchat/ola/vn/c/p;->a:Ljava/lang/ref/WeakReference;

    :cond_0
    iput-boolean p5, p0, Lchat/ola/vn/c/p;->e:Z

    iput p4, p0, Lchat/ola/vn/c/p;->d:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/p;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/c/p;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/p;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/p;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/p;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/p;->a:Ljava/lang/ref/WeakReference;

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

.method static synthetic b(Lchat/ola/vn/c/p;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/c/p;->e:Z

    return p0
.end method


# virtual methods
.method public f(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/c/p;->a(Z)V

    new-instance v1, Lchat/ola/vn/c/d;

    invoke-direct {v1}, Lchat/ola/vn/c/d;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/c/p;->c:Ljava/lang/String;

    iget v3, p0, Lchat/ola/vn/c/p;->d:I

    invoke-static {v2, v3, v0}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;IZ)Lchat/ola/vn/c/f;

    move-result-object v2

    invoke-virtual {v2, p1}, Lchat/ola/vn/c/f;->j(Ljava/lang/String;)V

    new-instance p1, Lchat/ola/vn/c/p$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/p$1;-><init>(Lchat/ola/vn/c/p;)V

    invoke-virtual {v2, p1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-array p1, v0, [Lchat/ola/vn/c/f;

    const/4 v0, 0x0

    aput-object v2, p1, v0

    invoke-virtual {v1, p1}, Lchat/ola/vn/c/d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public f(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/p;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_1

    :try_start_1
    iget-boolean v1, p0, Lchat/ola/vn/c/p;->e:Z

    if-eqz v1, :cond_0

    invoke-static {p2}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v1

    :catch_0
    :cond_0
    :try_start_2
    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/p;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method
