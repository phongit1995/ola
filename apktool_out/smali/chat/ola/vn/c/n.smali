.class public Lchat/ola/vn/c/n;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/w;


# instance fields
.field a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/view/OlaCachedImageView;",
            ">;"
        }
    .end annotation
.end field

.field b:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private c:I

.field private d:I

.field private e:I

.field private f:Z


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IIIZ)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/c/n;->c:I

    iput v0, p0, Lchat/ola/vn/c/n;->d:I

    iput v0, p0, Lchat/ola/vn/c/n;->e:I

    iput-boolean v0, p0, Lchat/ola/vn/c/n;->f:Z

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    if-eqz p2, :cond_0

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lchat/ola/vn/c/n;->b:Ljava/lang/ref/WeakReference;

    :cond_0
    iput p3, p0, Lchat/ola/vn/c/n;->c:I

    iput p4, p0, Lchat/ola/vn/c/n;->d:I

    iput p5, p0, Lchat/ola/vn/c/n;->e:I

    iput-boolean p6, p0, Lchat/ola/vn/c/n;->f:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/n;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/n;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/n;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n;->b:Ljava/lang/ref/WeakReference;

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

.method static synthetic a(Lchat/ola/vn/c/n;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/c/n;->f:Z

    return p0
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

.method public c(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    :try_start_0
    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/c/n;->a(Z)V

    invoke-static {p1}, Lchat/ola/vn/c/f;->g(Ljava/lang/String;)Lchat/ola/vn/c/f;

    iget v1, p0, Lchat/ola/vn/c/n;->c:I

    packed-switch v1, :pswitch_data_0

    iget v1, p0, Lchat/ola/vn/c/n;->d:I

    goto :goto_0

    :pswitch_0
    invoke-static {p1}, Lchat/ola/vn/c/f;->h(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object p1

    goto :goto_1

    :pswitch_1
    invoke-static {p1}, Lchat/ola/vn/c/f;->g(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object p1

    goto :goto_1

    :goto_0
    iget v2, p0, Lchat/ola/vn/c/n;->e:I

    invoke-static {p1, v1, v2}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;II)Lchat/ola/vn/c/f;

    move-result-object p1

    :goto_1
    new-instance v1, Lchat/ola/vn/c/n$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/c/n$1;-><init>(Lchat/ola/vn/c/n;)V

    invoke-virtual {p1, v1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance v1, Lchat/ola/vn/c/e;

    invoke-direct {v1}, Lchat/ola/vn/c/e;-><init>()V

    new-array v0, v0, [Lchat/ola/vn/c/f;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    invoke-virtual {v1, v0}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public c(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/n;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_1

    :try_start_1
    iget-boolean v1, p0, Lchat/ola/vn/c/n;->f:Z

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

    invoke-direct {p0, p1}, Lchat/ola/vn/c/n;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
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
