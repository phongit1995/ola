.class Lchat/ola/vn/me/b$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/me/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/TextView;

.field c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/me/b;


# direct methods
.method public constructor <init>(Lchat/ola/vn/me/b;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/b$a;->d:Lchat/ola/vn/me/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09029a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09055d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/me/b$a;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f0806a5

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_1
    return-void
.end method

.method private b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/c/t;->k(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/g;)V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/b$a;->c:Ljava/lang/String;

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/b$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/me/b$a;->b(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/me/b$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/me/b$a;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
