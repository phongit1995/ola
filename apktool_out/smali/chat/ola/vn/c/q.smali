.class public Lchat/ola/vn/c/q;
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
            "Lcom/mg/ola/common/widget/image/viewer/PhotoView;",
            ">;"
        }
    .end annotation
.end field

.field private c:Ljava/lang/String;

.field private d:I

.field private e:Z

.field private f:Landroid/widget/ImageView$ScaleType;


# direct methods
.method public constructor <init>(Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Ljava/lang/String;IZ)V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/c/q;->d:I

    iput-boolean v0, p0, Lchat/ola/vn/c/q;->e:Z

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    iput-object v0, p0, Lchat/ola/vn/c/q;->f:Landroid/widget/ImageView$ScaleType;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    iput-object p4, p0, Lchat/ola/vn/c/q;->c:Ljava/lang/String;

    if-eqz p3, :cond_0

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p3}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lchat/ola/vn/c/q;->a:Ljava/lang/ref/WeakReference;

    :cond_0
    iput-boolean p6, p0, Lchat/ola/vn/c/q;->e:Z

    iput p5, p0, Lchat/ola/vn/c/q;->d:I

    iput-object p2, p0, Lchat/ola/vn/c/q;->f:Landroid/widget/ImageView$ScaleType;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/q;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/c/q;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/q;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/q;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/q;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/q;->a:Ljava/lang/ref/WeakReference;

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

.method static synthetic b(Lchat/ola/vn/c/q;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/c/q;->e:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/c/q;)Landroid/widget/ImageView$ScaleType;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/q;->f:Landroid/widget/ImageView$ScaleType;

    return-object p0
.end method


# virtual methods
.method public f(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/c/q;->a(Z)V

    new-instance v1, Lchat/ola/vn/c/d;

    invoke-direct {v1}, Lchat/ola/vn/c/d;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/c/q;->c:Ljava/lang/String;

    iget v3, p0, Lchat/ola/vn/c/q;->d:I

    invoke-static {v2, v3, v0}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;IZ)Lchat/ola/vn/c/f;

    move-result-object v2

    invoke-virtual {v2, p1}, Lchat/ola/vn/c/f;->j(Ljava/lang/String;)V

    new-instance p1, Lchat/ola/vn/c/q$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/q$1;-><init>(Lchat/ola/vn/c/q;)V

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
    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/q;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getLoadingUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_1

    :try_start_1
    iget-boolean v1, p0, Lchat/ola/vn/c/q;->e:Z

    if-eqz v1, :cond_0

    invoke-static {p2}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v1

    :catch_0
    :cond_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/c/q;->f:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v0, p2, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/c/q;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method
