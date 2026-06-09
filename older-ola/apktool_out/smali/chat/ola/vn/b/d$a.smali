.class Lchat/ola/vn/b/d$a;
.super Landroid/widget/FrameLayout;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field public a:Lcom/google/android/gms/maps/model/Marker;

.field final synthetic b:Lchat/ola/vn/b/d;

.field private c:Landroid/widget/ImageView;

.field private d:Landroid/widget/ImageView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/d;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/d$a;->b:Lchat/ola/vn/b/d;

    invoke-direct {p0, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/b/d$a;->getContext()Landroid/content/Context;

    move-result-object p1

    const p2, 0x7f0b00e3

    invoke-static {p1, p2, p0}, Lchat/ola/vn/b/d$a;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const p1, 0x7f09028d

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/d$a;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/d$a;->c:Landroid/widget/ImageView;

    const p1, 0x7f09028c

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/d$a;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/d$a;->d:Landroid/widget/ImageView;

    const p1, 0x7f090542

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/d$a;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/d$a;->e:Landroid/widget/TextView;

    const p1, 0x7f090541

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/d$a;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/d$a;->f:Landroid/widget/TextView;

    return-void
.end method

.method private a()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->b:Lchat/ola/vn/b/d;

    invoke-static {v0}, Lchat/ola/vn/b/d;->a(Lchat/ola/vn/b/d;)Lchat/ola/vn/b/d$a;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    iput-object v1, v0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->e:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    sget-object v0, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    goto :goto_0

    :cond_1
    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/a/f;->a(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v2

    :goto_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, ""

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_3
    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v0

    invoke-virtual {v0, v2}, Lchat/ola/vn/util/h;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/util/g;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->f:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->f:Landroid/widget/TextView;

    const/4 v1, 0x0

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->f:Landroid/widget/TextView;

    const/4 v1, 0x4

    goto :goto_1

    :cond_5
    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/b/d$a;->c()V

    invoke-direct {p0}, Lchat/ola/vn/b/d$a;->b()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/d$a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/b/d$a;->a()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/b/d$a;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/d$a;->d:Landroid/widget/ImageView;

    return-object p0
.end method

.method private b()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->d:Landroid/widget/ImageView;

    const v2, 0x7f0806a5

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->d:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/c/f;->b(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/b/d$a$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/b/d$a$1;-><init>(Lchat/ola/vn/b/d$a;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance v1, Lchat/ola/vn/c/e;

    invoke-direct {v1}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v2, 0x1

    new-array v2, v2, [Lchat/ola/vn/c/f;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {v1, v2}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/b/d$a;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/d$a;->c:Landroid/widget/ImageView;

    return-object p0
.end method

.method private c()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->c:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v1}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/t;->d(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->c:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->b:Lchat/ola/vn/b/d;

    invoke-static {v0}, Lchat/ola/vn/b/d;->b(Lchat/ola/vn/b/d;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v1}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/b/d$a;->c:Landroid/widget/ImageView;

    sget v1, Lchat/ola/vn/f;->K:I

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackgroundColor(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/b/d$a;->a:Lcom/google/android/gms/maps/model/Marker;

    invoke-virtual {v0}, Lcom/google/android/gms/maps/model/Marker;->getSnippet()Ljava/lang/String;

    move-result-object v0

    sget v1, Lchat/ola/vn/e;->c:I

    invoke-static {v0, v1}, Lchat/ola/vn/c/f;->h(Ljava/lang/String;I)Lchat/ola/vn/c/f;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/b/d$a$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/b/d$a$2;-><init>(Lchat/ola/vn/b/d$a;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance v1, Lchat/ola/vn/c/e;

    invoke-direct {v1}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v2, 0x1

    new-array v2, v2, [Lchat/ola/vn/c/f;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {v1, v2}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
